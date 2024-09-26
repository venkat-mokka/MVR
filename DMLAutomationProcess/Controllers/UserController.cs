using DMLAutomationProcess.Domain.Entities;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using DMLAutomationProcess.Domain.Interfaces;
using Microsoft.AspNetCore.Authorization;

namespace DMLAutomationProcess.Web.Controllers
{
    public class UserController : Controller
    {
        private readonly IDataBindingService _dataBindingService;
        private readonly IUserService _userService;
        private readonly TelemetryClient _telemetryClient;
        private static List<BindRevisitOpDummys> lstBindRevisitOpDummys = new List<BindRevisitOpDummys>();
        private string? userId = null;
        public UserController(IDataBindingService dataBindingService, IUserService userService, TelemetryClient telemetryClient)
        {
            _dataBindingService = dataBindingService;
            _userService = userService;
            _telemetryClient = telemetryClient;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var userId = await _userService.GetCurrentUserIdAsync(User?.Identity?.Name);
            return View("Index");
        }

        #region Manage Users
        [HttpGet]
        public async Task<ActionResult> ManageUsers()
        {
            var users = await _userService.GetAllUsersAsync();
            ViewBag.Users = users; // Assuming this method returns the list of users
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> AddUser()
        {
            ViewBag.Roles = await _userService.GetRolesAsync();
            return PartialView("_AddUser");
        }

        [HttpPost]
        public async Task<IActionResult> AddUser(RegisterViewModel model)
        {
            if (!ModelState.IsValid) return PartialView("_AddUser", model);

            var result = await _userService.CreateUserAsync(model);
            if (result.Succeeded)
            {
                TempData["Success"] = "User Added Successfully";
                return PartialView("_BindUsers");
            }

            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }

            return PartialView("_AddUser", model);
        }

        [HttpGet]
        public async Task<IActionResult> EditUser(string id)
        {
            var user = await _userService.GetUserByIdAsync(id);
            if (user == null) return NotFound();

            var model = new EditUserViewModel
            {
                Id = user.Id,
                Name = user.Name,
                UserName = user.UserName,
                Email = user.Email,
                RoleId = (await _userService.GetRolesByIdAsync(id)) // Adjust to use the userService
            };

            ViewBag.Roles = await _userService.GetRolesAsync();
            return PartialView("_EditUser", model);
        }

        [HttpPost]
        public async Task<IActionResult> EditUser(string id, EditUserViewModel model)
        {
            if (!ModelState.IsValid) return PartialView("_EditUser", model);

            var result = await _userService.UpdateUserAsync(model);
            if (result.Succeeded)
            {
                TempData["Success"] = "User Updated Successfully";
                return PartialView("_BindUsers");
            }

            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }

            return PartialView("_EditUser", model);
        }

        [HttpGet]
        public async Task<IActionResult> DeleteUser(string id)
        {
            var user = await _userService.GetUserByIdAsync(id);
            if (user == null) return NotFound();

            var model = new EditUserViewModel
            {
                Id = user.Id,
                UserName = user.UserName
            };

            return PartialView("_DeleteUserConfirm", model);
        }

        [HttpPost]
        public async Task<IActionResult> DeleteUserConfirm(string id)
        {
            var result = await _userService.DeleteUserAsync(id);
            if (result.Succeeded)
            {
                TempData["Success"] = "User Deleted Successfully";
                return PartialView("_BindUsers");
            }

            // Handle errors accordingly
            return View("Error"); // You could show an error view instead
        }
        #endregion

        #region New & Revisit OP Registrations

        [HttpGet]
        public async Task<JsonResult> GetVillageNamesByAutoSerach(string term)
        {
            if (!string.IsNullOrEmpty(term))
            {
                var villages = await _userService.GetVillageNamesAsync(term);
                return Json(villages);
            }
            else
            {
                return Json(null);
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetGenderByPrefix(int prefixID)
        {
            var gender = await _userService.GetGenderByPrefixAsync(prefixID);
            return Json(gender);
        }

        [HttpGet]
        public async Task<IActionResult> GetMandalByVillageName(string villageName)
        {
            var mandal = await _userService.GetMandalByVillageNameAsync(villageName);
            return Json(mandal);
        }

        public async Task<bool> BindData()
        {
            var model = new DataBindingModel();
            await _dataBindingService.BindDataAsync(model);

            ViewBag.Prefixes = model.Prefixes;
            ViewBag.Genders = model.Genders;
            ViewBag.PatientTypes = model.PatientTypes;
            ViewBag.Departments = model.Departments;
            ViewBag.Specialities = model.Specialities;
            ViewBag.Doctors = model.Doctors;
            ViewBag.FeeTypes = model.FeeTypes;
            ViewBag.AgeTypes = model.AgeTypes;
            ViewBag.MaritalStatuses = model.MaritalStatuses;
            ViewBag.Religions = model.Religions;
            ViewBag.BloodGroups = model.BloodGroups;
            ViewBag.IdProofs = model.IdProofs;

            return true;
        }

        [HttpGet]
        public async Task<string> GetFormattedUnitNames(int departmentID)
        {
            var res = await _userService.GetFormattedUnitNamesAsync(departmentID);
            return res;
        }

        [HttpGet]
        public async Task<IActionResult> GetDoctorsByUnit(string unitIds)
        {
            var res = await _userService.GetDoctorsByUnitAsync(unitIds);
            return Json(res);
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
            var res = await _userService.GetNewUHIDAsync();
            return res;
        }

        public async Task<string> GetNewOPID()
        {
            var res = await _userService.GetNewOPIDAsync();
            return res;
        }

        [HttpPost]
        public async Task<IActionResult> Registration(OpRegistrationViewModel viewModel)
        {
            try
            {
                await _userService.RegisterAsync(viewModel, userId);
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

        //[HttpPost]
        //public async Task<IActionResult> Registration(OpRegistrationViewModel viewModel)
        //{
        //    try
        //    {
        //        if (viewModel.Patients != null)
        //        {
        //            viewModel.Patients.MiddleName = await Helper.GetCurrentUserId(_context, User?.Identity?.Name);
        //            _context.Patients.Add(viewModel.Patients);
        //            await _context.SaveChangesAsync();
        //        }

        //        if (viewModel.PatientAddresss != null)
        //        {
        //            viewModel.PatientAddresss.PatientID = viewModel.Patients?.ID ?? 0; // Assuming PatientID is required for PatientAddress
        //            _context.PatientAddresses.Add(viewModel.PatientAddresss);
        //            await _context.SaveChangesAsync();
        //        }

        //        if (viewModel.OPRegistrations != null)
        //        {
        //            // Create parameters for the stored procedure
        //            var parameters = new[]
        //            {
        //        new SqlParameter("@PatientID", viewModel.Patients?.ID),
        //        new SqlParameter("@OPID", viewModel.OPRegistrations.OPID),
        //        new SqlParameter("@VisitDate", viewModel.OPRegistrations.VisitDate),
        //        new SqlParameter("@IsMlcCase", viewModel.OPRegistrations.IsMlcCase.HasValue ? (object)viewModel.OPRegistrations.IsMlcCase.Value : DBNull.Value),
        //        new SqlParameter("@IsEmergencyCase", viewModel.OPRegistrations.IsEmergencyCase.HasValue ? (object)viewModel.OPRegistrations.IsEmergencyCase.Value : DBNull.Value),
        //        new SqlParameter("@DepartmentID", viewModel.OPRegistrations.DepartmentID.HasValue ? (object)viewModel.OPRegistrations.DepartmentID.Value : DBNull.Value),
        //        new SqlParameter("@DoctorID", viewModel.OPRegistrations.DoctorID.HasValue ? (object)viewModel.OPRegistrations.DoctorID.Value : DBNull.Value),
        //        new SqlParameter("@SpecialityID", viewModel.OPRegistrations.SpecialityID.HasValue ? (object)viewModel.OPRegistrations.SpecialityID.Value : DBNull.Value),
        //        new SqlParameter("@FeeTypeID", viewModel.OPRegistrations.FeeTypeID.HasValue ? (object)viewModel.OPRegistrations.FeeTypeID.Value : DBNull.Value),
        //        new SqlParameter("@ReferredBy", viewModel.OPRegistrations.ReferredBy),
        //        new SqlParameter("@CreatedDate", viewModel.OPRegistrations.CreatedDate.HasValue ? (object)viewModel.OPRegistrations.CreatedDate.Value : DBNull.Value),
        //        new SqlParameter("@IsActive", viewModel.OPRegistrations.IsActive),
        //        new SqlParameter("@IsCamp", false),
        //        new SqlParameter("@IsType", false)
        //    };

        //            await _context.Database.ExecuteSqlRawAsync(
        //               "EXEC InsertOPRegistration @PatientID, @OPID, @VisitDate, @IsMlcCase, @IsEmergencyCase, @DepartmentID, @DoctorID, @SpecialityID, @FeeTypeID, @ReferredBy, @CreatedDate, @IsActive, @IsCamp,@IsType",
        //               parameters);
        //        }

        //        TempData["Success"] = "New UHID " + viewModel.Patients?.UHID + " Created Successfully";
        //        await BindData();
        //        return RedirectToAction("Registration");
        //    }
        //    catch (Exception ex)
        //    {
        //        _telemetryClient.TrackException(ex);
        //        TempData["Error"] = "An error occurred while processing UHID " + (viewModel.Patients?.UHID ?? "unknown") + ".";
        //        return View();
        //    }
        //}

        [HttpGet]
        public async Task<IActionResult> Revisit_Registration(string? redirect = null)
        {
            var opRegistrationViewModel = new OpRegistrationViewModel();
            await BindData();
            if (redirect != null)
            {
                //// Query the Patient by UHID
                //var patient = await _context.Patients
                //    .Where(x => x.UHID == "")
                //    .FirstOrDefaultAsync();

                //if (patient != null)
                //{

                //    // Query the PatientAddress and OPRegistration for the found patient
                //    var patientAddress = await _context.PatientAddresses
                //        .Where(x => x.PatientID == patient.ID)
                //        .FirstOrDefaultAsync();

                //    var opRegistration = await _context.OPRegistrations
                //        .Where(x => x.PatientID == patient.ID).OrderByDescending(a => a.ID)
                //        .Include(a => a.Speciality)
                //        .Include(a => a.Department)
                //        .FirstOrDefaultAsync();
                //}

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

        public async Task<string?> GetOpIdListAsync(int numIDs)
        {
            var res = await _userService.GetOpIdListAsync(numIDs);
            return res.ToString();
        }

        [HttpPost]
        public async Task<IActionResult?> BindRevisitDetailsByUHID(string UHID)
        {
            if (!string.IsNullOrEmpty(UHID))
            {
                await BindData();
                // Create a new instance of the ViewModel
                var opRegistrationViewModel = _userService.BindRevisitDetailsByUHID(UHID);
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
                await _userService.Revisit_RegistrationAsync(viewModel, userId);
            }
            catch (Exception ex)
            {
                _telemetryClient.TrackException(ex);
                TempData["Error"] = "An error occurred while processing UHID " + (viewModel.Patients?.UHID ?? "unknown") + ".";
                return View();
            }
            return View();
        }

        //[HttpPost]
        //public async Task<IActionResult> Revisit_Registration(OpRegistrationViewModel viewModel)
        //{
        //    try
        //    {
        //        if (viewModel.Patients?.ID != 0)
        //        {
        //            if (viewModel.OPRegistrations != null)
        //            {
        //                // Create parameters for the stored procedure
        //                var parameters = new[]
        //                {
        //        new SqlParameter("@PatientID", viewModel.Patients?.ID),
        //        new SqlParameter("@OPID", viewModel.OPRegistrations.OPID),
        //        new SqlParameter("@VisitDate", viewModel.OPRegistrations.VisitDate),
        //        new SqlParameter("@IsMlcCase", viewModel.OPRegistrations.IsMlcCase.HasValue ? (object)viewModel.OPRegistrations.IsMlcCase.Value : DBNull.Value),
        //        new SqlParameter("@IsEmergencyCase", viewModel.OPRegistrations.IsEmergencyCase.HasValue ? (object)viewModel.OPRegistrations.IsEmergencyCase.Value : DBNull.Value),
        //        new SqlParameter("@DepartmentID", viewModel.OPRegistrations.DepartmentID.HasValue ? (object)viewModel.OPRegistrations.DepartmentID.Value : DBNull.Value),
        //        new SqlParameter("@DoctorID", viewModel.OPRegistrations.DoctorID.HasValue ? (object)viewModel.OPRegistrations.DoctorID.Value : DBNull.Value),
        //        new SqlParameter("@SpecialityID", viewModel.OPRegistrations.SpecialityID.HasValue ? (object)viewModel.OPRegistrations.SpecialityID.Value : DBNull.Value),
        //        new SqlParameter("@FeeTypeID", viewModel.OPRegistrations.FeeTypeID.HasValue ? (object)viewModel.OPRegistrations.FeeTypeID.Value : DBNull.Value),
        //        new SqlParameter("@ReferredBy", viewModel.OPRegistrations.ReferredBy),
        //        new SqlParameter("@CreatedDate", viewModel.OPRegistrations.CreatedDate.HasValue ? (object)viewModel.OPRegistrations.CreatedDate.Value : DBNull.Value),
        //        new SqlParameter("@IsActive", viewModel.OPRegistrations.IsActive),
        //        new SqlParameter("@IsCamp", false),
        //        new SqlParameter("@IsType", true)
        //    };

        //                await _context.Database.ExecuteSqlRawAsync(
        //                   "EXEC InsertOPRegistration @PatientID, @OPID, @VisitDate, @IsMlcCase, @IsEmergencyCase, @DepartmentID, @DoctorID, @SpecialityID, @FeeTypeID, @ReferredBy, @CreatedDate, @IsActive, @IsCamp,@IsType",
        //                   parameters);
        //            }

        //            TempData["Success"] = "Revisit UHID " + viewModel.Patients?.UHID + " Updated Successfully";

        //            await BindData();
        //            return RedirectToAction("Revisit_Registration", new { redirect = "redirect" });
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        _telemetryClient.TrackException(ex);
        //        TempData["Error"] = "An error occurred while processing UHID " + (viewModel.Patients?.UHID ?? "unknown") + ".";
        //        return View();
        //    }
        //    return View();
        //}

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
            var (departments, genders) = await _userService.GetDepartmentIdsAsync(model);
            bool isDone = await _userService.SaveDummyAsync(departments, genders, model.VisitDate);
            return Json(isDone);
        }

        [HttpGet]
        public async Task<IActionResult> RevisitOpDummy()
        {
            var model = new DataBindingModel();
            await _dataBindingService.BindDataAsync(model);

            // Check if Departments is null or empty
            if (model.Departments == null || !model.Departments.Any())
            {
                // Handle the case where there are no departments available
                ViewBag.Departments = new List<SelectListItem>(); // Return an empty list
                ViewBag.Units = string.Empty; // No units to display
                ViewBag.Genders = model.Genders; // Return genders if available
                return View(model); // Return the model to the view
            }

            // Store departments in ViewBag
            ViewBag.Departments = model.Departments;

            // Get the current day name in the desired format
            var currentDayName = DateTime.Now.ToString("dddd").Substring(0, 3).ToUpper();

            // Get the selected department ID (if any)
            var selectedDepartment = model.Departments.FirstOrDefault();
            int departmentId = selectedDepartment != null ? Convert.ToInt32(selectedDepartment.Value) : 0;

            // Optional: Check if departmentId is valid
            if (departmentId <= 0)
            {
                ViewBag.Units = string.Empty; // Set units to an empty string or handle appropriately
                ViewBag.Genders = model.Genders; // Return genders if available
                return View(model); // Return the model to the view
            }

            // Fetch the units for the given department and day
            var units = await _userService.GetUnitsAsync(departmentId, currentDayName);

            // Store the units in ViewBag
            ViewBag.Units = units; // Assuming GetUnitsAsync returns a formatted string
            ViewBag.Genders = model.Genders; // Store genders for the view

            // Prepare a new model for patient revisit
            var revisitModel = new RevistPatientsModel
            {
                VisitDate = DateTime.Now,
                FromDate = DateTime.Now,
                ToDate = DateTime.Now
            };

            return View(revisitModel); // Return the new model to the view
        }


        [HttpPost]
        public async Task<IActionResult> RevisitOpDummy(DateTime visitDate)
        {
            bool isDone = false;
            if (lstBindRevisitOpDummys.Count > 0 && visitDate != null)
            {
                foreach (var item in lstBindRevisitOpDummys)
                {
                    isDone = await _userService.SendRevisitOpDummy(item.UHID, visitDate, item.DepartmentID, item.UnitID, item.GenderName.Substring(0, 1));
                }
                lstBindRevisitOpDummys.Clear();
                ViewBag.lstBindRevisitOpDummys = lstBindRevisitOpDummys;
                return PartialView("_BindRevisitOpDummys");
            }
            return Json(isDone);
        }

        [HttpGet]
        public async Task<IActionResult> GetUnitNames(int departmentID)
        {
            try
            {
                var currentDayName = DateTime.Now.ToString("dddd").Substring(0, 3).ToUpper();
                var units = await _userService.GetUnitsAsync(departmentID, currentDayName);
                // Return JSON response
                return Json(units);
            }
            catch (Exception ex)
            {
                // Log exception and return error response
                // _logger.LogError(ex, "An error occurred while getting unit names.");
                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetOpDetailsByDate(int departmentID, string unitIDs, int genderID, DateTime fromDate, DateTime toDate, int noofEntries)
        {
            var bindRevisitOpDummys = await _userService.GetOpDetailsByDateAsync(departmentID, unitIDs, genderID, fromDate, toDate, noofEntries);
            lstBindRevisitOpDummys.AddRange(bindRevisitOpDummys);
            ViewBag.lstBindRevisitOpDummys = lstBindRevisitOpDummys;

            // Return partial view
            return PartialView("_BindRevisitOpDummys");
        }

        #endregion
    }
}
