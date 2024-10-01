using DMLAutomationProcess.Domain.Entities;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using DMLAutomationProcess.Domain.Interfaces;
using DMLAutomationProcess.Infra.Services;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Text;

namespace DMLAutomationProcess.Web.Controllers
{
    public class AccountController : Controller
    {
        private readonly IRoleService _roleService;
        private readonly IAccountService _accountService;
        private readonly TelemetryClient _telemetryClient;
        public AccountController(IRoleService roleService, IAccountService accountService, TelemetryClient telemetryClient)
        {
            _roleService = roleService;
            _accountService = accountService;
            _telemetryClient = telemetryClient;
        }

        #region Manage Roles

        [HttpGet]
        public async Task<ActionResult> ManageRoles()
        {
            // Fetch roles and their user counts
            var model = await _roleService.GetRolesWithUserCountsAsync();
            ViewBag.Roles = model;
            return View();
        }

        [HttpGet]
        public ActionResult AddRole()
        {
            return PartialView("_AddRole");
        }

        [HttpPost]
        public async Task<IActionResult> AddRole(string id, ApplicationRoleViewModel model)
        {
            if (ModelState.IsValid)
            {
                bool isExist = !string.IsNullOrEmpty(id);
                if (await _roleService.AddOrUpdateRoleAsync(model))
                {
                    TempData["Success"] = isExist ? "Role Updated Successfully" : "Role Added Successfully";
                    return PartialView("_BindRoles");
                }
            }
            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> EditRole(string id)
        {
            var roleViewModel = await _roleService.GetRoleByIdAsync(id);
            return PartialView("_EditRole", roleViewModel);
        }

        [HttpGet]
        public async Task<IActionResult> DeleteRole(string id)
        {
            var model = await _roleService.GetRoleForDeletionAsync(id);
            return PartialView("_DeleteRoleConfirm", model);
        }

        [HttpPost]
        public async Task<IActionResult> DeleteRoleConfirm(string id)
        {
            if (!string.IsNullOrEmpty(id) && await _roleService.DeleteRoleAsync(id))
            {
                TempData["Success"] = "Role Deleted Successfully";
                return PartialView("_BindRoles");
            }
            return View();
        }

        #endregion

        #region Login & LogOut
        [HttpGet]
        public IActionResult Login(string? returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model, string? returnUrl = null)
        {
            try
            {
                HttpContext.Session.Clear();
                ViewData["ReturnUrl"] = returnUrl;
                if (ModelState.IsValid)
                {
                    var result = await _accountService.LoginAsync(model);
                    if (result.Succeeded)
                    {
                        //var claims = new List<Claim>()
                        //{
                        //    new Claim("UserName", model.UserName)
                        //};
                        //var userIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                        //var principal = new ClaimsPrincipal(userIdentity);
                        //await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

                        if (User.IsInRole("Admin"))
                        {
                            return RedirectToAction(nameof(AdminController.Index), "Admin");
                        }
                        if (User.IsInRole("User"))
                        {
                            //return RedirectToAction(nameof(UserController.Index), "User");
                        }
                        if (User.IsInRole("Doctor"))
                        {
                            return RedirectToAction(nameof(DoctorController.Index), "Doctor");
                        }
                        else
                        {
                            return RedirectToAction(nameof(HomeController.Index), "Home");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError(string.Empty, "Invalid login attempt.");
                        return View(model);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
            return View(model);
        }

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> ChangePassword()
        {
            ViewBag.UserId = await _accountService.GetUserByNameAsync(User?.Identity?.Name);
            return View();
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ChangePassword(ManageUserViewModel model)
        {
            var user = await _accountService.GetUserByNameAsync(User.Identity.Name);
            if (user == null) return NotFound("User not found.");

            var result = await _accountService.ChangePasswordAsync(user, model.OldPassword, model.NewPassword);
            if (result.Succeeded)
            {
                await _accountService.LogOffAsync();
                TempData["success"] = "Your password has been changed successfully!";
                return RedirectToAction("Login");
            }
            else
            {
                foreach (var error in result.Errors)
                {
                    ModelState.AddModelError(string.Empty, error.Description);
                }
            }

            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> LogOff()
        {
            await _accountService.LogOffAsync();
            return RedirectToAction("Login");
        }


        //[HttpPost]
        //public async Task<IActionResult> ChangePassword(ApplicationUser user, ManageUserViewModel model)
        //{
        //    //IdentityResult result = _userManager.ChangePasswordAsync(user, model.OldPassword, model.NewPassword);
        //    //if (result.Succeeded)
        //    //{
        //    //    await _signInManager.SignOutAsync();
        //    //    TempData["success"] = "Your password has been changed successfully!";
        //    //}
        //    //else
        //    //{
        //    //    TempData["error"] = "Please Enter Valid Current Password !";
        //    //}
        //    return RedirectToAction("Login", "Account");
        //}

        //[HttpGet]
        //public async Task<IActionResult> LogOff()
        //{
        //    try
        //    {
        //        await _signInManager.SignOutAsync();
        //    }
        //    catch (Exception ex)
        //    {
        //        _telemetryClient.TrackException(ex);
        //    }
        //    return RedirectToAction("Login");
        //}

        #endregion
    }
}
