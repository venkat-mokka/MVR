using DMLAutomationProcess.Domain.Entities;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using DMLAutomationProcess.Domain.Interfaces;
using System.Security.Claims;

namespace DMLAutomationProcess.Web.Controllers
{
    public class UserController : Controller
    {
        private readonly IDataBindingService _dataBindingService;
        private readonly IUserService _userService;
        private readonly TelemetryClient _telemetryClient;
        private static List<BindRevisitOpDummys> lstBindRevisitOpDummys = new List<BindRevisitOpDummys>();
        private string? userId = null;
        private readonly IHttpContextAccessor? _httpContextAccessor;
        public UserController(IDataBindingService dataBindingService, IUserService userService, TelemetryClient telemetryClient, IHttpContextAccessor? httpContextAccessor)
        {
            _dataBindingService = dataBindingService;
            _userService = userService;
            _telemetryClient = telemetryClient;
            _httpContextAccessor = httpContextAccessor;
            userId = _httpContextAccessor?.HttpContext?.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
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

        [HttpGet]
        public async Task<IActionResult> Revisit_Registration(string? redirect = null)
        {
            var opRegistrationViewModel = new OpRegistrationViewModel();
            await BindData();

            Patient patients = new Patient();
            PatientAddress patientAddresss = new PatientAddress();
            OPRegistration OpRegistrations = new OPRegistration();

            OpRegistrations.VisitDate = DateTime.Now;
            if (redirect != null)
                OpRegistrations.OPID = await GetNewOPID();

            opRegistrationViewModel.Patients = patients;
            opRegistrationViewModel.PatientAddresss = patientAddresss;
            opRegistrationViewModel.OPRegistrations = OpRegistrations;
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
                var opRegistrationViewModel = await _userService.BindRevisitDetailsByUHID(UHID);
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

                TempData["Success"] = "Revisit UHID " + viewModel.Patients?.UHID + " Updated Successfully";

                await BindData();
                return RedirectToAction("Revisit_Registration", new { redirect = "redirect" });
            }
            catch (Exception ex)
            {
                _telemetryClient.TrackException(ex);
                TempData["Error"] = "An error occurred while processing UHID " + (viewModel.Patients?.UHID ?? "unknown") + ".";
                return View();
            }
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
