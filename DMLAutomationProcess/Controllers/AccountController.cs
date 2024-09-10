using DMLAutomationProcess.Models;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Threading.Channels;

namespace DMLAutomationProcess.Controllers
{
    public class AccountController : Controller
    {
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly RoleManager<ApplicationRole> _roleManager;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ApplicationDbContext _context;
        private readonly TelemetryClient _telemetryClient;
        public AccountController(SignInManager<ApplicationUser> signInManager, RoleManager<ApplicationRole> roleManager, UserManager<ApplicationUser> userManager, ApplicationDbContext context, TelemetryClient telemetryClient)
        {
            _signInManager = signInManager;
            _roleManager = roleManager;
            _userManager = userManager;
            _context = context;
            _telemetryClient = telemetryClient;
        }

        #region Manage Roles

        [HttpGet]
        public async Task<ActionResult> ManageRoles()
        {
            await CreateRoleAndUser();
            // Fetch all roles
            var roles = await _roleManager.Roles.ToListAsync();

            // Prepare the model list
            var model = new List<ApplicationRoleListViewModel>();

            // Iterate over each role and get the number of users
            foreach (var role in roles)
            {
                var usersInRole = await _userManager.GetUsersInRoleAsync(role.Name);
                model.Add(new ApplicationRoleListViewModel
                {
                    RoleName = role.Name,
                    Id = role.Id,
                    NumberOfUsers = usersInRole.Count
                });
            }
            ViewBag.Roles = model;
            return View();
        }

        [HttpGet]
        public ActionResult AddRole()
        {
            return PartialView("_AddRole");
        }

        public async Task<bool> CreateRoleAndUser()
        {
            ApplicationRole applicationRole = new ApplicationRole();
            applicationRole.Name = "Admin";
            applicationRole.CreatedDate = DateTime.Now;
            IdentityResult roleRuslt = await _roleManager.CreateAsync(applicationRole);

            ApplicationUser user = new ApplicationUser
            {
                Name = "venkat",
                UserName = "venkat",
                Email = "venkat@gmail.com",
                CreatedDate = DateTime.Now,
                IsActive = true,
            };
            IdentityResult result = await _userManager.CreateAsync(user, "Venkat@123");
            if (result.Succeeded)
            {
                if (applicationRole != null)
                {
                    IdentityResult roleResult = await _userManager.AddToRoleAsync(user, applicationRole.Name);
                    if (roleResult.Succeeded)
                    {
                        return roleRuslt.Succeeded;
                    }
                }
            }
            return false;
        }

        [HttpPost]
        public async Task<IActionResult> AddRole(string id, ApplicationRoleViewModel model)
        {
            //if (ModelState.IsValid)
            //{
            bool isExist = !string.IsNullOrEmpty(id);
            ApplicationRole? applicationRole = isExist ? await _roleManager.FindByIdAsync(id) :
           new ApplicationRole
           {
               Name = model.RoleName,
               CreatedDate = DateTime.Now
           };
            IdentityResult roleRuslt = isExist ? await _roleManager.UpdateAsync(applicationRole)
                                                : await _roleManager.CreateAsync(applicationRole);
            if (roleRuslt.Succeeded)
            {
                await ManageRoles();
                if (isExist)
                    TempData["Success"] = "Role Updated Successfully";
                else
                    TempData["Success"] = "Role Added Successfully";
                return PartialView("_BindRoles");
            }
            //}
            return View(model);
        }

        [HttpGet]
        public ActionResult EditRole(string id)
        {
            var res = _roleManager.Roles.Where(a => a.Id == id).Select(r => new ApplicationRoleViewModel
            {
                RoleName = r.Name,
                Id = r.Id,
            }).FirstOrDefault();
            return PartialView("_EditRole", res);
        }

        [HttpGet]
        public async Task<IActionResult> DeleteRole(string id)
        {
            ApplicationRoleListViewModel model = new ApplicationRoleListViewModel();
            if (!string.IsNullOrEmpty(id))
            {
                var res = await _roleManager.FindByIdAsync(id);
                var usersInRole = await _userManager.GetUsersInRoleAsync(res?.Name);
                model = new ApplicationRoleListViewModel
                {
                    RoleName = res?.Name,
                    Id = id,
                    NumberOfUsers = usersInRole.Count
                };
            }
            return PartialView("_DeleteRoleConfirm", model);
        }

        [HttpPost]
        public async Task<IActionResult> DeleteRoleConfirm(string id)
        {
            if (!string.IsNullOrEmpty(id))
            {
                ApplicationRole applicationRole = await _roleManager.FindByIdAsync(id);
                if (applicationRole != null)
                {
                    IdentityResult roleRuslt = _roleManager.DeleteAsync(applicationRole).Result;
                    if (roleRuslt.Succeeded)
                    {
                        await ManageRoles();
                        TempData["Success"] = "Role Deleted Successfully";
                        return PartialView("_BindRoles");
                    }
                }
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
                _telemetryClient.TrackEvent("Login Started !");
                ViewData["ReturnUrl"] = returnUrl;
                if (ModelState.IsValid)
                {
                    //await CreateRoleAndUserThenUserRoleMapping(model);
                    var result = await _signInManager.PasswordSignInAsync(model.UserName, model.Password, model.RememberMe, lockoutOnFailure: false);
                    if (result.Succeeded)
                    {
                        _telemetryClient.TrackEvent("Login Ended !");
                        return RedirectToLocal(returnUrl);
                    }
                    else
                    {
                        ModelState.AddModelError(string.Empty, "Invalid login attempt.");
                        _telemetryClient.TrackEvent("Login Failed !");
                        return View(model);
                    }
                }
            }
            catch (Exception ex)
            {
                _telemetryClient.TrackException(ex);
            }
            return View(model);
        }

        private IActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction(nameof(HomeController.Index), "Home");
            }
        }

        [HttpGet]
        public async Task<IActionResult> LogOff()
        {
            try
            {
                await _signInManager.SignOutAsync();
            }
            catch (Exception ex)
            {
                _telemetryClient.TrackException(ex);
            }
            return RedirectToAction("Login");
        }
        #endregion
    }
}
