using DMLAutomationProcess.Models;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Maui.Graphics;
using System.Data;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;

namespace DMLAutomationProcess.Controllers
{
    public class UserController : Controller
    {
        private readonly RoleManager<ApplicationRole> _roleManager;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ApplicationDbContext _context;
        private readonly TelemetryClient _telemetryClient;
        private static List<BindRevisitOpDummys> bindRevisitOpDummys1 = new List<BindRevisitOpDummys>();
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

        #region New & Revisit OP Registrations

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
            var currentDayName = DateTime.Now.ToString("dddd").Substring(0, 3).ToUpper();
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

        #region New & Revisit OP Dummy Registrations

        [HttpGet]
        public async Task<IActionResult> NewOpDummy()
        {
            var model = new NewPatientsModel
            {
                VisitDate = DateTime.Now
            };
            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> NewOpDummy(NewPatientsModel model)
        {
            model.VisitDate = model.VisitDate;
            var (departments, genders) = await GetDepartmentIdsAsync(model);
            bool isDone = await SaveDummy(departments, genders, model.VisitDate);
            return Json(isDone);
        }

        public async Task<(List<int> departments, List<string> genders)> GetDepartmentIdsAsync(NewPatientsModel model)
        {
            var departments = new List<int>();
            var genders = new List<string>();

            // Helper method to get department ID
            async Task<int?> GetDepartmentIdAsync(string departmentName)
            {
                return await _context.Departments
                                     .Where(d => d.Name == departmentName)
                                     .Select(d => d.DepartmentID)
                                     .FirstOrDefaultAsync();
            }

            // Check and add Casualty department ID
            if (model.CasualtyMale > 0 || model.CasualtyFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Casualty");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.CasualtyMale > 0) genders.Add("M");
                    if (model.CasualtyFemale > 0) genders.Add("F");
                }
            }

            // Check and add General Medicine department ID
            if (model.GeneralMedicineMale > 0 || model.GeneralMedicineFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("General Medicine");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.GeneralMedicineMale > 0) genders.Add("M");
                    if (model.GeneralMedicineFemale > 0) genders.Add("F");
                }
            }

            // Check and add Paediatrics department ID
            if (model.PaediatricsMale > 0 || model.PaediatricsFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Paediatrics");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.PaediatricsMale > 0) genders.Add("M");
                    if (model.PaediatricsFemale > 0) genders.Add("F");
                }
            }

            // Check and add Respiratory Medicine department ID
            if (model.RespiratoryMedicineMale > 0 || model.RespiratoryMedicineFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Respiratory Medicine");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.RespiratoryMedicineMale > 0) genders.Add("M");
                    if (model.RespiratoryMedicineFemale > 0) genders.Add("F");
                }
            }

            // Check and add DVL department ID
            if (model.DVLMale > 0 || model.DVLFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Dvl");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.DVLMale > 0) genders.Add("M");
                    if (model.DVLFemale > 0) genders.Add("F");
                }
            }

            // Check and add Psychiatry department ID
            if (model.PsychiatryMale > 0 || model.PsychiatryFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Psychiatry");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.PsychiatryMale > 0) genders.Add("M");
                    if (model.PsychiatryFemale > 0) genders.Add("F");
                }
            }

            // Check and add General Surgery department ID
            if (model.GeneralSurgeryMale > 0 || model.GeneralSurgeryFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("General Surgery");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.GeneralSurgeryMale > 0) genders.Add("M");
                    if (model.GeneralSurgeryFemale > 0) genders.Add("F");
                }
            }

            // Check and add Orthopaedics department ID
            if (model.OrthopaedicsMale > 0 || model.OrthopaedicsFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Orthopaedics");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.OrthopaedicsMale > 0) genders.Add("M");
                    if (model.OrthopaedicsFemale > 0) genders.Add("F");
                }
            }

            // Check and add Ophthalmology department ID
            if (model.OphthalmologyMale > 0 || model.OphthalmologyFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Ophthalmology");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.OphthalmologyMale > 0) genders.Add("M");
                    if (model.OphthalmologyFemale > 0) genders.Add("F");
                }
            }

            // Check and add ENT department ID
            if (model.ENTMale > 0 || model.ENTFemale > 0)
            {
                var departmentId = await GetDepartmentIdAsync("ENT");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    if (model.ENTMale > 0) genders.Add("M");
                    if (model.ENTFemale > 0) genders.Add("F");
                }
            }

            // Check and add Obstetrics department ID
            if (model.Obstetrics > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Obstetrics");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    genders.Add("F");
                }
            }

            // Check and add Gynecology department ID
            if (model.Gynecology > 0)
            {
                var departmentId = await GetDepartmentIdAsync("Gynecology");
                if (departmentId.HasValue)
                {
                    departments.Add(departmentId.Value);
                    genders.Add("F");
                }
            }
            return (departments, genders);
        }

        public async Task<bool> SaveDummy(List<int> departments, List<string> genders, DateTime visitDate)
        {
            Random random = new Random(); // Create a random number generator

            foreach (int departmentId in departments)
            {
                // Get the formatted unit names and parse the unit IDs
                var res = await GetFormattedUnitNames(departmentId);
                string unitIds = res.Split("^")[1];
                var unitIdList = unitIds.Split(',').Select(a => int.Parse(a)).ToList();

                // Get doctor IDs associated with these units
                var doctorIdList = await _context.UnitDoctorMappings
                    .Where(v => unitIdList.Contains(v.UnitID))
                    .Select(v => v.DoctorID)
                    .ToListAsync();

                // If there are any units and doctors, pick random ones
                if (unitIdList.Any() && doctorIdList.Any())
                {
                    // Select a random unitId from the list
                    int randomUnitId = unitIdList[random.Next(unitIdList.Count)];

                    // Select a random doctorId from the list
                    int randomDoctorId = doctorIdList[random.Next(doctorIdList.Count)];

                    // Send to stored procedure with the random unitId and doctorId
                    await SendNewOpDummy(visitDate, departmentId, randomUnitId, randomDoctorId, genders[departments.IndexOf(departmentId)]);
                }
            }
            return true;
        }

        public async Task<bool> SendNewOpDummy(DateTime visitDate, int departmentId, int unitId, int doctorId, string gender)
        {
            string UHID = await GetNewUHID();
            string OPID = await GetNewOPID();
            if (!string.IsNullOrEmpty(UHID) && !string.IsNullOrEmpty(OPID))
            {
                try
                {
                    var result = await _context.Database.ExecuteSqlRawAsync(
                              "EXEC SendNewOpDummy @UHID = {0}, @OPID = {1}, @VisitDate = {2}, @DepartmentID = {3}, @UnitID = {4}, @DoctorID = {5}, @Gender = {6}",
                              UHID, OPID, visitDate, departmentId, unitId, doctorId, gender
                          );
                    return result > 0;
                }
                catch (Exception ex)
                {

                }
                return true;
            }
            else
            {
                return false;
            }
        }

        [HttpGet]
        public async Task<IActionResult> RevisitOpDummy()
        {
            ViewBag.Departments = await _context.Departments.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.DepartmentID.ToString()

            }).ToListAsync();

            ViewBag.Units = await _context.Units.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.UnitID.ToString()
            }).ToListAsync();

            ViewBag.Genders = await _context.Genders.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.GenderID.ToString()

            }).ToListAsync();

            var model = new RevistPatientsModel
            {
                VisitDate = DateTime.Now,
                FromDate = DateTime.Now,
                ToDate = DateTime.Now
            };
            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> RevisitOpDummy(DateTime visitDate)
        {
            bool isDone = false;
            if (bindRevisitOpDummys1.Count > 0 && visitDate != null)
            {
                foreach (var item in bindRevisitOpDummys1)
                {
                    isDone = await SendRevisitOpDummy(item.UHID, visitDate, item.DepartmentID, item.UnitID, item.GenderName.Substring(0, 1));
                }
                bindRevisitOpDummys1.Clear();
                ViewBag.bindRevisitOpDummys = bindRevisitOpDummys1;
                return PartialView("_BindRevisitOpDummys");
            }
            return Json(isDone);
        }

        public async Task<bool> SendRevisitOpDummy(string UHID, DateTime visitDate, int departmentId, int unitId, string gender)
        {
            try
            {
                // Retrieve a new OPID value
                string OPID = await GetNewOPID();

                // Check if UHID and OPID are not null or empty
                if (!string.IsNullOrEmpty(UHID) && !string.IsNullOrEmpty(OPID))
                {
                    // Execute the stored procedure
                    var result = await _context.Database.ExecuteSqlRawAsync(
                        "EXEC SendRevisitOpDummy @UHID = {0}, @OPID = {1}, @VisitDate = {2}, @DepartmentID = {3}, @UnitID = {4}, @Gender = {5}",
                        UHID, OPID, visitDate, departmentId, unitId, gender
                    );

                    // Return true if the operation affected more than 0 rows
                    return result > 0;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                // Log or handle the exception as needed
                // For example: _logger.LogError(ex, "An error occurred while sending RevisitOpDummy.");
                return false;
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetUnitNames(int departmentID)
        {
            // Get the current day name
            var currentDayName = DateTime.Now.ToString("dddd").Substring(0, 3).ToUpper();
            //currentDayName = "TUE";
            var unitNames = await _context.DepartmentDayUnitMappings
                .Where(mapping =>
                    mapping.Departments.DepartmentID == departmentID &&
                    mapping.DaywiseSchedules.Name.Substring(0, 3).ToUpper() == currentDayName
                )
                .OrderBy(mapping => mapping.Units.Name)
                .Select(mapping => new { UnitName = mapping.Units.Name, UnitID = mapping.Units.UnitID })
                .ToListAsync();

            var units = unitNames.Select(r => new SelectListItem
            {
                Text = r.UnitName,
                Value = r.UnitID.ToString()

            }).ToList();

            return Json(units);
        }

        [HttpGet]
        public async Task<IActionResult> GetOpDetailsByDate(int departmentID, int unitID, int genderID, DateTime fromDate, DateTime toDate, int noofEntries)
        {
            // Example hardcoded dates for testing
            fromDate = new DateTime(2024, 9, 5, 7, 0, 0, 0); // "2024-09-05 07:48:26.0000000"
            toDate = new DateTime(2024, 9, 7, 7, 53, 5, 0);  // "2024-09-05 07:53:05.0000000"

            // Filter and group OPRegistrations by PatientID for the specified department and gender within the date range
            var bindRevisitOpDummys = await _context.OPRegistrations
                .Where(a => a.DepartmentID == departmentID
                            && a.Patient.GenderID == genderID
                            && a.VisitDate >= fromDate
                            && a.VisitDate <= toDate)
                .Include(a => a.Department)  // Include Department details
                .Include(a => a.Patient)     // Include Patient details
                .ThenInclude(p => p.Gender)  // Include Gender via Patient
                .GroupBy(a => new { a.PatientID, a.DepartmentID, a.Patient.GenderID })  // Group by PatientID, Department, and Gender
                .Select(g => new BindRevisitOpDummys
                {
                    SNo = g.FirstOrDefault().ID,                     // Take the first entry's ID as SNo
                    UHID = g.FirstOrDefault().Patient.UHID,          // Get UHID from the first entry
                    DepartmentID = departmentID,
                    UnitID = unitID,
                    DepartmentName = g.FirstOrDefault().Department.Name, // Department Name
                    GenderName = g.FirstOrDefault().Patient.Gender.Name, // Gender Name
                    Total = g.Count()                          // Count number of entries for each patient
                })
                .OrderBy(a => a.SNo)    // Sort by SNo or ID
                .Take(noofEntries)      // Limit the number of records returned
                .ToListAsync();         // Execute asynchronously

            bindRevisitOpDummys1.AddRange(bindRevisitOpDummys);
            ViewBag.bindRevisitOpDummys = bindRevisitOpDummys1;

            // Return partial view
            return PartialView("_BindRevisitOpDummys");
        }

        #endregion

    }
}
