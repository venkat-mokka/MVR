using DMLAutomationProcess.Models;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Maui.Graphics;
using System.Security.Cryptography;

namespace DMLAutomationProcess.Controllers
{
    public class UserController : Controller
    {
        private readonly RoleManager<ApplicationRole> _roleManager;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ApplicationDbContext _context;
        private readonly TelemetryClient _telemetryClient;
        public UserController(RoleManager<ApplicationRole> roleManager, UserManager<ApplicationUser> userManager, ApplicationDbContext context, TelemetryClient telemetryClient)
        {
            _roleManager = roleManager;
            _userManager = userManager;
            _context = context;
            _telemetryClient = telemetryClient;
        }

        #region Manage Users
        [HttpGet]
        public async Task<ActionResult> ManageUsers()
        {
            // Fetch all users
            var users = await _userManager.Users.ToListAsync();

            // Fetch all roles and create a dictionary for quick role lookup
            var roles = await _roleManager.Roles.ToListAsync();
            var roleNamesToIds = roles.ToDictionary(r => r.Name, r => r.Id);

            // Create a list of ApplicationUsersListViewModel
            var model = new List<ApplicationUsersListViewModel>();

            foreach (var user in users)
            {
                var roleNames = await _userManager.GetRolesAsync(user);

                // Handle users with multiple roles or if roles are not found
                var roleName = roleNames
                    .Select(roleName => roleNamesToIds.TryGetValue(roleName, out var roleId) ? roleId.ToString() : "Unknown")
                    .FirstOrDefault(); // Assuming you need the first role or default to "Unknown"

                model.Add(new ApplicationUsersListViewModel
                {
                    Name = user.Name,
                    Id = user.Id,
                    UserName = user.UserName,
                    Email = user.Email,
                    RoleName = await _roleManager.Roles.Where(a => a.Id == roleName).Select(a => a.Name).FirstOrDefaultAsync()
                });
            }

            // Pass the model to the view
            ViewBag.Users = model;
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> AddUser()
        {
            ViewBag.Roles = await _roleManager.Roles.OrderByDescending(f => f.Id).Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.Id
            }).ToListAsync();

            return PartialView("_AddUser");
        }

        [HttpPost]
        public async Task<IActionResult> AddUser(RegisterViewModel model)
        {
            ApplicationUser user = new ApplicationUser
            {
                Name = model.UserName,
                UserName = model.UserName,
                Email = model.Email
            };
            IdentityResult result = await _userManager.CreateAsync(user, model.Password);
            if (result.Succeeded)
            {
                ApplicationRole applicationRole = await _roleManager.FindByIdAsync(model?.RoleId);
                if (applicationRole != null)
                {
                    IdentityResult roleResult = await _userManager.AddToRoleAsync(user, applicationRole.Name);
                    if (roleResult.Succeeded)
                    {
                        await ManageUsers();
                        TempData["Success"] = "User Added Successfully";
                        return PartialView("_BindUsers");
                    }
                }
            }
            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> EditUser(string id)
        {
            EditUserViewModel model = new EditUserViewModel();
            ViewBag.Roles = await _roleManager.Roles.OrderByDescending(f => f.Id).Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.Id
            }).ToListAsync();

            if (!string.IsNullOrEmpty(id))
            {
                ApplicationUser user = await _userManager.FindByIdAsync(id);
                if (user != null)
                {
                    model.Id = user.Id;
                    model.Name = user.Name;
                    model.UserName = user.UserName;
                    model.Email = user.Email;
                    model.RoleId = _roleManager.Roles.Single(r => r.Name == _userManager.GetRolesAsync(user).Result.Single()).Id;
                }
            }
            return PartialView("_EditUser", model);
        }

        [HttpPost]
        public async Task<IActionResult> EditUser(string id, EditUserViewModel model)
        {
            ApplicationUser user = await _userManager.FindByIdAsync(id);
            if (user != null)
            {
                user.Name = model.UserName;
                model.UserName = model.UserName;
                user.Email = model.Email;
                string existingRole = _userManager.GetRolesAsync(user).Result.Single();
                string existingRoleId = _roleManager.Roles.Single(r => r.Name == existingRole).Id;
                IdentityResult result = await _userManager.UpdateAsync(user);
                if (result.Succeeded)
                {
                    if (existingRoleId != model.RoleId)
                    {
                        IdentityResult roleResult = await _userManager.RemoveFromRoleAsync(user, existingRole);
                        if (roleResult.Succeeded)
                        {
                            ApplicationRole applicationRole = await _roleManager.FindByIdAsync(model.RoleId);
                            if (applicationRole != null)
                            {
                                IdentityResult newRoleResult = await _userManager.AddToRoleAsync(user, applicationRole.Name);
                                if (newRoleResult.Succeeded)
                                {
                                    await ManageUsers();
                                    TempData["Success"] = "User Updated Successfully";
                                    return PartialView("_BindUsers");
                                }
                            }
                        }
                    }
                }
            }
            return PartialView("_EditUser", model);
        }

        [HttpGet]
        public async Task<IActionResult> DeleteUser(string id)
        {
            EditUserViewModel model = new EditUserViewModel();
            if (!string.IsNullOrEmpty(id))
            {
                ApplicationUser applicationUser = await _userManager.FindByIdAsync(id);
                model.Id = applicationUser.Id;
                model.UserName = applicationUser.UserName;
                return PartialView("_DeleteUserConfirm", model);
            }
            return PartialView("_DeleteUserConfirm");
        }

        [HttpPost]
        public async Task<IActionResult> DeleteUserConfirm(string id)
        {
            if (!string.IsNullOrEmpty(id))
            {
                ApplicationUser applicationUser = await _userManager.FindByIdAsync(id);
                if (applicationUser != null)
                {
                    IdentityResult result = await _userManager.DeleteAsync(applicationUser);
                    if (result.Succeeded)
                    {
                        await ManageUsers();
                        TempData["Success"] = "User Deleted Successfully";
                        return PartialView("_BindUsers");
                    }
                }
            }
            return View();
        }
        #endregion

        #region OP New & Revisit Registrations

        [HttpGet]
        public async Task<JsonResult> GetVillageNamesByAutoSerach(string term)
        {
            if (!string.IsNullOrEmpty(term))
            {
                List<string> _datas = await _context.Villages
                     .Where(v => v.Name.ToLower().StartsWith(term.ToLower()))
                     .Select(v => v.Name)
                     .ToListAsync();

                return Json(_datas);
            }
            else
            {
                return Json(null);
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetGenderByPrefix(int prefixID)
        {
            var result = await _context.Prefixes
                .Where(v => v.PrefixID == prefixID)
                .Include(v => v.Gender)
                .Select(v => new
                {
                    genderID = v.GenderID,
                    genderName = v.Gender.Name
                })
                .ToListAsync();

            return Json(result);
        }

        [HttpGet]
        public async Task<IActionResult> GetMandalByVillageName(string villageName)
        {
            var result = await _context.Villages
                .Where(v => v.Name == villageName)
                .Include(v => v.Mandal)
                .ThenInclude(m => m.District)
                .ThenInclude(d => d.State)
                .Select(v => new
                {
                    villageID = v.VillageID,
                    pinCode = v.Pincode,
                    mandalName = v.Mandal.Name,
                    districtName = v.Mandal.District.Name,
                    stateName = v.Mandal.District.State.Name
                })
                .ToListAsync();

            return Json(result);
        }

        public async Task<bool> BindData()
        {
            // Patient Demographic Details 

            //   await _context.Database.ExecuteSqlRawAsync("EXEC InsertOPPatient");


            ViewBag.Prefixs = await _context.Prefixes.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.PrefixID.ToString()

            }).ToListAsync();

            ViewBag.Genders = await _context.Genders.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.GenderID.ToString()

            }).ToListAsync();

            ViewBag.PatientTypes = await _context.PatientTypes.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.PatientTypeID.ToString()

            }).ToListAsync();

            ViewBag.Departments = await _context.Departments.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.DepartmentID.ToString()

            }).ToListAsync();

            ViewBag.Specialitys = await _context.Specialities.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.SpecialityID.ToString()

            }).ToListAsync();

            ViewBag.Doctors = new List<SelectListItem>
            {
                new SelectListItem { Text = "", Value = "" }
            };

            ViewBag.FeeTypes = await _context.FeeTypes.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.FeeTypeID.ToString()

            }).ToListAsync();

            ViewBag.AgeTypes = await _context.AgeTypes.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.AgeTypeID.ToString()

            }).ToListAsync();


            // Patient Contact Details 
            ViewBag.MaritalStatuss = await _context.MaritalStatuses.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.MaritalStatusID.ToString()

            }).ToListAsync();

            ViewBag.Religions = await _context.Religions.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ReligionID.ToString()

            }).ToListAsync();

            ViewBag.BloodGroups = await _context.BloodGroups.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.BloodGroupID.ToString()

            }).ToListAsync();
            ViewBag.IdProofs = await _context.IDProofTypes.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.IDProofTypeID.ToString()

            }).ToListAsync();

            return true;
        }

        [HttpGet]
        public async Task<string> GetFormattedUnitNames(int departmentID)
        {
            // Get the current day name
            var currentDayName = DateTime.Now.AddDays(-1).ToString("dddd").Substring(0, 3).ToUpper();
            //currentDayName = "TUE";
            var unitNames = await _context.DepartmentDayUnitMappings
                .Where(mapping =>
                    mapping.Departments.DepartmentID == departmentID &&
                    mapping.DaywiseSchedules.Name.Substring(0, 3).ToUpper() == currentDayName
                )
                .OrderBy(mapping => mapping.Units.Name)
                //.Select(mapping => mapping.Units.Name)
                .Select(mapping => new { UnitName = mapping.Units.Name, UnitID = mapping.Units.UnitID })
                .ToListAsync();

            var formattedUnitNames = unitNames.Any()
                ? "UNIT -" + string.Join(" & ", unitNames.Select((unit, index) =>
                    index == 0 ? unit.UnitName.Replace("UNIT -", "").Trim() : unit.UnitName.Replace("UNIT -", "").Trim()))
                : string.Empty;

            // Format Unit IDs: Just join them with commas
            var formattedUnitIds = unitNames.Any()
                ? string.Join(",", unitNames.Select(unit => unit.UnitID.ToString()))
                : string.Empty;

            var formattedUnitNamesAndUnitIds = formattedUnitNames + "^" + formattedUnitIds;

            return formattedUnitNamesAndUnitIds;
        }

        [HttpGet]
        public async Task<IActionResult> GetDoctorsByUnit(string unitIds)
        {
            // Split unitIds into a list of integers
            var unitIdList = unitIds.Split(',')
                                     .Select(id => int.Parse(id))
                                     .ToList();

            // Query the database
            var result = await _context.UnitDoctorMappings
                .Where(v => unitIdList.Contains(v.UnitID))  // Use the list of unit IDs for filtering
                .Include(v => v.Doctors)
                .Select(v => new SelectListItem
                {
                    Text = v.Doctors.Name,                // Set Text as the doctor's name
                    Value = v.DoctorID.ToString()         // Set Value as the doctor's ID
                }).OrderBy(a => a.Text)
                .ToListAsync();

            // Return the result as JSON
            return Json(result);
        }

        [HttpGet]
        public async Task<IActionResult> Registration()
        {
            OpRegistrationViewModel opRegistrationViewModel = new OpRegistrationViewModel();
            OPRegistration oPRegistration = new OPRegistration();
            Patient patient = new Patient();

            patient.UHID = await GetNewUHID();
            oPRegistration.OPID = await GetNewOPID();
            oPRegistration.ReferredBy = "Self";
            oPRegistration.VisitDate = DateTime.Now;

            opRegistrationViewModel.Patients = patient;
            opRegistrationViewModel.OPRegistrations = oPRegistration;

            await BindData();
            return View(opRegistrationViewModel);
        }

        public async Task<string> GetNewUHID()
        {
            // Get the current date in YYYYMMDD format
            var currentDatePart = DateTime.Now.ToString("yyyyMMdd");

            // Get the maximum UHID for the current date
            var maxUHID = await _context.Patients
                .Where(p => p.UHID.StartsWith(currentDatePart))
                .OrderByDescending(p => p.UHID)
                .Select(p => p.UHID)
                .FirstOrDefaultAsync();

            // Handle the case when no UHID exists for today
            if (maxUHID == null)
            {
                return currentDatePart + "0001";
            }

            // Extract the numeric part from maxUHID
            var numericPart = maxUHID.Substring(8); // XXXX

            if (!int.TryParse(numericPart, out var currentMaxNumber))
            {
                throw new InvalidOperationException("UHID format is not as expected.");
            }

            // Increment the numeric part for today's UHID
            var nextNumber = currentMaxNumber + 1;
            var nextUHIDNumericPart = nextNumber.ToString("D4"); // Pad with leading zeros

            return currentDatePart + nextUHIDNumericPart;
        }

        public async Task<string> GetNewOPID()
        {
            // Get the current date in "yyMMdd" format
            var currentDatePart = DateTime.Now.ToString("yyMMdd");

            // Get the maximum OPID for the current date
            var maxOPID = await _context.OPRegistrations
                .Where(p => p.OPID.StartsWith("OP." + currentDatePart))
                .OrderByDescending(p => p.OPID)
                .Select(p => p.OPID)
                .FirstOrDefaultAsync();

            // Handle the case when no OPID exists for today
            if (maxOPID == null)
            {
                // Generate OPID for the current day, starting with "0001"
                return "OP." + currentDatePart + "0001";
            }

            // Ensure that the OPID format is as expected
            if (!maxOPID.StartsWith("OP.") || maxOPID.Length != 13)
            {
                throw new InvalidOperationException("OPID format is not as expected.");
            }

            // Extract the numeric part from maxOPID
            var numericPartString = maxOPID.Substring(9); // Extract "0001"

            // Try parsing the numeric part to an integer
            if (!int.TryParse(numericPartString, out var numericPart))
            {
                throw new InvalidOperationException("Numeric part of OPID is not as expected.");
            }

            // Increment the numeric value by 1
            numericPart += 1;

            // Convert the incremented number to a string with leading zeros (assuming 4-digit format)
            var incrementedNumericPartString = numericPart.ToString("D4"); // Pads with leading zeros

            // Generate the new OPID with today's date and incremented number
            var nextOPID = "OP." + currentDatePart + incrementedNumericPartString;

            return nextOPID;
        }


        public async Task<string> GetNewOPID1()
        {
            // Step 1: Get the maximum OPID
            var maxOPID = await _context.OPRegistrations
                .OrderByDescending(p => p.OPID)
                .Select(p => p.OPID)
                .FirstOrDefaultAsync();

            // Step 2: Handle case when no OPID exists
            if (maxOPID == null)
            {
                // Assuming your initial OPID format is "OP.yyMMdd0001"
                // Adjust the date part as needed
                return "OP." + DateTime.Now.ToString("yyMMdd") + "0001";
            }

            // Remove the "OP." prefix and extract the numeric part
            var numericPartString = maxOPID.Substring(9); // Assuming "OP.yyMMdd" is 8 characters long

            // Try parsing the numeric part to long
            if (!long.TryParse(numericPartString, out var numericPart))
            {
                throw new InvalidOperationException("OPID format is not as expected.");
            }

            // Increment the numeric value by 1
            numericPart += 1;

            // Convert the incremented number to a string with leading zeros (assuming 4-digit format)
            var incrementedNumericPartString = numericPart.ToString("D4"); // Pads with leading zeros

            // Generate the new OPID with today's date and incremented number
            var nextOPID = "OP." + DateTime.Now.ToString("yyMMdd") + incrementedNumericPartString;

            return nextOPID;
        }

        [HttpPost]
        public async Task<IActionResult> Registration(OpRegistrationViewModel viewModel)
        {
            try
            {
                if (viewModel.Patients != null)
                {
                    _context.Patients.Add(viewModel.Patients);
                    await _context.SaveChangesAsync();
                }

                if (viewModel.PatientAddresss != null)
                {
                    viewModel.PatientAddresss.PatientID = viewModel.Patients?.ID ?? 0; // Assuming PatientID is required for PatientAddress
                    _context.PatientAddresses.Add(viewModel.PatientAddresss);
                    await _context.SaveChangesAsync();
                }

                if (viewModel.OPRegistrations != null)
                {
                    // Create parameters for the stored procedure
                    var parameters = new[]
                    {
                new SqlParameter("@PatientID", viewModel.Patients?.ID),
                new SqlParameter("@OPID", viewModel.OPRegistrations.OPID),
                new SqlParameter("@VisitDate", viewModel.OPRegistrations.VisitDate),
                new SqlParameter("@IsMlcCase", viewModel.OPRegistrations.IsMlcCase.HasValue ? (object)viewModel.OPRegistrations.IsMlcCase.Value : DBNull.Value),
                new SqlParameter("@IsEmergencyCase", viewModel.OPRegistrations.IsEmergencyCase.HasValue ? (object)viewModel.OPRegistrations.IsEmergencyCase.Value : DBNull.Value),
                new SqlParameter("@DepartmentID", viewModel.OPRegistrations.DepartmentID.HasValue ? (object)viewModel.OPRegistrations.DepartmentID.Value : DBNull.Value),
                new SqlParameter("@DoctorID", viewModel.OPRegistrations.DoctorID.HasValue ? (object)viewModel.OPRegistrations.DoctorID.Value : DBNull.Value),
                new SqlParameter("@SpecialityID", viewModel.OPRegistrations.SpecialityID.HasValue ? (object)viewModel.OPRegistrations.SpecialityID.Value : DBNull.Value),
                new SqlParameter("@FeeTypeID", viewModel.OPRegistrations.FeeTypeID.HasValue ? (object)viewModel.OPRegistrations.FeeTypeID.Value : DBNull.Value),
                new SqlParameter("@ReferredBy", viewModel.OPRegistrations.ReferredBy),
                new SqlParameter("@CreatedDate", viewModel.OPRegistrations.CreatedDate.HasValue ? (object)viewModel.OPRegistrations.CreatedDate.Value : DBNull.Value),
                new SqlParameter("@IsActive", viewModel.OPRegistrations.IsActive)
            };

                    await _context.Database.ExecuteSqlRawAsync(
                       "EXEC InsertOPRegistration @PatientID, @OPID, @VisitDate, @IsMlcCase, @IsEmergencyCase, @DepartmentID, @DoctorID, @SpecialityID, @FeeTypeID, @ReferredBy, @CreatedDate, @IsActive",
                       parameters);
                }

                TempData["Success"] = "New UHID " + viewModel.Patients?.UHID + " Created Successfully";
                await BindData();
                return RedirectToAction("Registration");
            }
            catch (Exception ex)
            {
                _telemetryClient.TrackException(ex);
                TempData["Error"] = "An error occurred while processing UHID " + (viewModel.Patients?.UHID ?? "unknown") + ".";
                return View();
            }
        }

        [HttpGet]
        public async Task<IActionResult> Revisit_Registration(string? redirect = null)
        {
            var opRegistrationViewModel = new OpRegistrationViewModel();
            await BindData();
            if (redirect != null)
            {
                // Query the Patient by UHID
                var patient = await _context.Patients
                    .Where(x => x.UHID == "")
                    .FirstOrDefaultAsync();

                if (patient != null)
                {

                    // Query the PatientAddress and OPRegistration for the found patient
                    var patientAddress = await _context.PatientAddresses
                        .Where(x => x.PatientID == patient.ID)
                        .FirstOrDefaultAsync();

                    var opRegistration = await _context.OPRegistrations
                        .Where(x => x.PatientID == patient.ID).OrderByDescending(a => a.ID)
                        .Include(a => a.Speciality)
                        .Include(a => a.Department)
                        .FirstOrDefaultAsync();
                }

                Patient patients = new Patient();
                PatientAddress patientAddresss = new PatientAddress();
                OPRegistration OpRegistrations = new OPRegistration();

                OpRegistrations.VisitDate = DateTime.Now;

                OpRegistrations.OPID = await GetNewOPID();
                OpRegistrations.VisitDate = DateTime.Now;

                // Assign the retrieved data to the ViewModel
                opRegistrationViewModel.Patients = patients;
                opRegistrationViewModel.PatientAddresss = patientAddresss;
                opRegistrationViewModel.OPRegistrations = OpRegistrations;
            }
            else
            {
                Patient patients = new Patient();
                PatientAddress patientAddresss = new PatientAddress();
                OPRegistration OpRegistrations = new OPRegistration();

                OpRegistrations.VisitDate = DateTime.Now;

                opRegistrationViewModel.Patients = patients;
                opRegistrationViewModel.PatientAddresss = patientAddresss;
                opRegistrationViewModel.OPRegistrations = OpRegistrations;
            }
            return View(opRegistrationViewModel);
        }

        public async Task<string> GetOpIdListAsync(int numIDs)
        {
            // Define the output parameter
            var outputParameter = new SqlParameter
            {
                ParameterName = "@result",
                SqlDbType = System.Data.SqlDbType.NVarChar,
                Size = -1, // Max size for NVARCHAR
                Direction = System.Data.ParameterDirection.Output
            };

            // Execute the stored procedure
            await _context.Database.ExecuteSqlRawAsync("EXEC GenerateOPIDList @numIDs, @result OUTPUT",
                new SqlParameter("@numIDs", numIDs),
                outputParameter);

            // Retrieve the output value
            return (string)outputParameter.Value;
        }

        [HttpPost]
        public async Task<IActionResult?> BindRevisitDetailsByUHID(string UHID)
        {
            if (!string.IsNullOrEmpty(UHID))
            {
                await BindData();
                // Create a new instance of the ViewModel
                var opRegistrationViewModel = new OpRegistrationViewModel();

                // Query the Patient by UHID
                var patient = await _context.Patients
                    .Where(x => x.UHID == UHID)
                    .FirstOrDefaultAsync();

                // Query the PatientAddress and OPRegistration for the found patient
                var patientAddress = await _context.PatientAddresses
                    .Where(x => x.PatientID == patient.ID)
                    .FirstOrDefaultAsync();

                var opRegistration = await _context.OPRegistrations
                    .Where(x => x.PatientID == patient.ID).OrderByDescending(a => a.ID)
                    .Include(a => a.Speciality)
                    .Include(a => a.Department)
                    .FirstOrDefaultAsync();

                // Assign the retrieved data to the ViewModel
                opRegistrationViewModel.Patients = patient;
                opRegistrationViewModel.PatientAddresss = patientAddress;
                opRegistration.OPID = await GetNewOPID();
                opRegistration.VisitDate = DateTime.Now;
                opRegistrationViewModel.OPRegistrations = opRegistration;

                return PartialView("_BindRevisit_Registration", opRegistrationViewModel);
            }
            else
            {
                return null;
            }
        }

        [HttpPost]
        public async Task<IActionResult> Revisit_Registration(OpRegistrationViewModel viewModel)
        {
            try
            {
                if (viewModel.Patients?.ID != 0)
                {
                    if (viewModel.OPRegistrations != null)
                    {
                        // Create parameters for the stored procedure
                        var parameters = new[]
                        {
                new SqlParameter("@PatientID", viewModel.Patients?.ID),
                new SqlParameter("@OPID", viewModel.OPRegistrations.OPID),
                new SqlParameter("@VisitDate", viewModel.OPRegistrations.VisitDate),
                new SqlParameter("@IsMlcCase", viewModel.OPRegistrations.IsMlcCase.HasValue ? (object)viewModel.OPRegistrations.IsMlcCase.Value : DBNull.Value),
                new SqlParameter("@IsEmergencyCase", viewModel.OPRegistrations.IsEmergencyCase.HasValue ? (object)viewModel.OPRegistrations.IsEmergencyCase.Value : DBNull.Value),
                new SqlParameter("@DepartmentID", viewModel.OPRegistrations.DepartmentID.HasValue ? (object)viewModel.OPRegistrations.DepartmentID.Value : DBNull.Value),
                new SqlParameter("@DoctorID", viewModel.OPRegistrations.DoctorID.HasValue ? (object)viewModel.OPRegistrations.DoctorID.Value : DBNull.Value),
                new SqlParameter("@SpecialityID", viewModel.OPRegistrations.SpecialityID.HasValue ? (object)viewModel.OPRegistrations.SpecialityID.Value : DBNull.Value),
                new SqlParameter("@FeeTypeID", viewModel.OPRegistrations.FeeTypeID.HasValue ? (object)viewModel.OPRegistrations.FeeTypeID.Value : DBNull.Value),
                new SqlParameter("@ReferredBy", viewModel.OPRegistrations.ReferredBy),
                new SqlParameter("@CreatedDate", viewModel.OPRegistrations.CreatedDate.HasValue ? (object)viewModel.OPRegistrations.CreatedDate.Value : DBNull.Value),
                new SqlParameter("@IsActive", viewModel.OPRegistrations.IsActive)
            };

                        await _context.Database.ExecuteSqlRawAsync(
                           "EXEC InsertOPRegistration @PatientID, @OPID, @VisitDate, @IsMlcCase, @IsEmergencyCase, @DepartmentID, @DoctorID, @SpecialityID, @FeeTypeID, @ReferredBy, @CreatedDate, @IsActive",
                           parameters);
                    }

                    TempData["Success"] = "Revisit UHID " + viewModel.Patients?.UHID + " Updated Successfully";

                    await BindData();
                    return RedirectToAction("Revisit_Registration", new { redirect = "redirect" });
                }
            }
            catch (Exception ex)
            {
                _telemetryClient.TrackException(ex);
                TempData["Error"] = "An error occurred while processing UHID " + (viewModel.Patients?.UHID ?? "unknown") + ".";
                return View();
            }
            return View();
        }

        #endregion
    }
}
