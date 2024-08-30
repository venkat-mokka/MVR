using DMLAutomationProcess.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Maui.ApplicationModel.Communication;
using Microsoft.Maui.Graphics;
using static Microsoft.Maui.ApplicationModel.Permissions;
//using System.Web.Mvc;

namespace DMLAutomationProcess.Controllers
{
    public class UserController : Controller
    {
        private readonly RoleManager<ApplicationRole> _roleManager;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ApplicationDbContext _context;
        public UserController(RoleManager<ApplicationRole> roleManager, UserManager<ApplicationUser> userManager, ApplicationDbContext context)
        {
            _roleManager = roleManager;
            _userManager = userManager;
            _context = context;
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

        [HttpGet]
        public async Task<IActionResult> Registration()
        {
            OpRegistrationViewModel opRegistrationViewModel = new OpRegistrationViewModel();
            OPRegistration oPRegistrations = new OPRegistration();

            oPRegistrations.UHID = DateTime.Now.ToString("yyyyMMdd") + "0001";
            oPRegistrations.OPID = "OP." + DateTime.Now.ToString("yyMMdd") + "0001";
            oPRegistrations.VisitDate = DateTime.Now;
            opRegistrationViewModel.OPRegistrations = oPRegistrations;

            await BindData();
            return View(opRegistrationViewModel);
        }

        public async Task<bool> BindData()
        {
            ViewBag.Prefixs = await _context.Prefixs.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            ViewBag.Genders = await _context.Genders.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            ViewBag.PatientTypes = await _context.PatientTypes.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            ViewBag.Departments = await _context.Departments.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            ViewBag.Specialitys = await _context.Specialitys.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            ViewBag.Doctors = await _context.Doctors.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            ViewBag.FeeTypes = await _context.FeeTypes.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            ViewBag.Years = await _context.Years.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();
            ViewBag.Units = await _context.Units.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.ID.ToString()

            }).ToListAsync();

            return true;
        }

        [HttpPost]
        public async Task<IActionResult> Registration(OPRegistration models)
        {
            try
            {
                var model = new OPRegistration
                {
                    FirstName = "V",
                    LastName = "M",
                    Age = 35,
                    DOB = DateTime.Now,
                    Email = "MV.doe@example.com",
                    Phone = "987654321",
                    PrefixID = 1,
                    AadhaarNo = 123456789012,
                    AbhaNo = 987654321012345,
                    PatientTypeID = null,
                    DepartmentID = null,
                    SpecialityID = null,
                    DoctorID = null,
                    FeeTypeID = null,
                    YearID = null
                };

                // Create parameters for the stored procedure
                var parameters = new[]
                {
                    new SqlParameter("@FirstName", model?.FirstName),
                    new SqlParameter("@LastName", model?.LastName),
                    new SqlParameter("@Age", model?.Age),
                    new SqlParameter("@DOB", model?.DOB),
                    new SqlParameter("@Email", model?.Email),
                    new SqlParameter("@Phone", model?.Phone),
                    new SqlParameter("@PrefixID", model?.PrefixID),
                    new SqlParameter("@AadhaarNo", model?.AadhaarNo),
                    new SqlParameter("@AbhaNo", model?.AbhaNo),
                    new SqlParameter("@PatientTypeID", DBNull.Value),
                    new SqlParameter("@DepartmentID", DBNull.Value),
                    new SqlParameter("@SpecialityID", DBNull.Value),
                    new SqlParameter("@DoctorID", DBNull.Value),
                    new SqlParameter("@FeeTypeID", DBNull.Value),
                    new SqlParameter("@YearID", DBNull.Value)
                    };

                _context.Database.ExecuteSqlRaw("EXEC InsertOPPatient @FirstName, @LastName, @Age, @DOB, @Email, @Phone, @PrefixID, @AadhaarNo, @AbhaNo, @PatientTypeID, @DepartmentID, @SpecialityID, @DoctorID, @FeeTypeID, @YearID", parameters);
            }
            catch (Exception ex)
            {

            }
            return View();
        }

        [HttpPost]
        public JsonResult Test(string Prefix)
        {
            // Initialize a list of cities
            List<City> ObjList = new List<City>()
    {
        new City { Id = 1, Name = "Latur" },
        new City { Id = 2, Name = "Mumbai" },
        new City { Id = 3, Name = "Pune" },
        new City { Id = 4, Name = "Delhi" },
        new City { Id = 5, Name = "Dehradun" },
        new City { Id = 6, Name = "Noida" },
        new City { Id = 7, Name = "New Delhi" }
    };

            // Check if Prefix is null or empty and handle accordingly
            if (string.IsNullOrEmpty(Prefix))
            {
                return Json(new List<object>()); // Return an empty list if no prefix is provided
            }

            // Search records from the list using LINQ query
            var result = ObjList
                         .Where(N => N.Name.StartsWith(Prefix, StringComparison.OrdinalIgnoreCase))
                         .Select(N => new { N.Name })
                         .ToList();

            // Return the result as JSON
            return Json(result);
        }
    }
}
