using DMLAutomationProcess.Domain.Entities;
using DMLAutomationProcess.Domain.Interfaces;
using DMLAutomationProcess.Infra.Dbcontext;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace DMLAutomationProcess.Infra.Services
{
    public class RoleService : IRoleService
    {
        private readonly RoleManager<ApplicationRole> _roleManager;
        private readonly UserManager<ApplicationUser> _userManager;

        public RoleService(RoleManager<ApplicationRole> roleManager, UserManager<ApplicationUser> userManager)
        {
            _roleManager = roleManager;
            _userManager = userManager;
        }

        public async Task<bool> CreateRoleAndUserAsync(string roleName, ApplicationUser user, string password)
        {
            var roleExists = await _roleManager.RoleExistsAsync(roleName);
            if (!roleExists)
            {
                var applicationRole = new ApplicationRole { Name = roleName, CreatedDate = DateTime.Now };
                await _roleManager.CreateAsync(applicationRole);
            }

            var result = await _userManager.CreateAsync(user, password);
            if (result.Succeeded)
            {
                await _userManager.AddToRoleAsync(user, roleName);
                return true;
            }
            return false;
        }

        public async Task<List<ApplicationRoleListViewModel>> GetRolesWithUserCountsAsync()
        {
            var roles = await _roleManager.Roles.ToListAsync();
            var model = new List<ApplicationRoleListViewModel>();

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

            return model;
        }

        public async Task<ApplicationRoleViewModel> GetRoleByIdAsync(string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            if (role != null)
            {
                return new ApplicationRoleViewModel
                {
                    RoleName = role.Name,
                    Id = role.Id
                };
            }
            return null;
        }

        public async Task<bool> AddOrUpdateRoleAsync(ApplicationRoleViewModel model)
        {
            var role = await _roleManager.FindByIdAsync(model.Id) ?? new ApplicationRole { Name = model.RoleName };
            role.Name = model.RoleName;
            role.CreatedDate = DateTime.Now;

            var result = model.Id != null
                ? await _roleManager.UpdateAsync(role)
                : await _roleManager.CreateAsync(role);

            return result.Succeeded;
        }

        public async Task<ApplicationRoleListViewModel> GetRoleForDeletionAsync(string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            if (role != null)
            {
                var usersInRole = await _userManager.GetUsersInRoleAsync(role.Name);
                return new ApplicationRoleListViewModel
                {
                    RoleName = role.Name,
                    Id = id,
                    NumberOfUsers = usersInRole.Count
                };
            }
            return null;
        }

        public async Task<bool> DeleteRoleAsync(string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            if (role != null)
            {
                var result = await _roleManager.DeleteAsync(role);
                return result.Succeeded;
            }
            return false;
        }
    }

    public class AccountService : IAccountService
    {
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly TelemetryClient _telemetryClient;

        public AccountService(SignInManager<ApplicationUser> signInManager, UserManager<ApplicationUser> userManager, TelemetryClient telemetryClient)
        {
            _signInManager = signInManager;
            _userManager = userManager;
            _telemetryClient = telemetryClient;
        }

        public async Task<SignInResult> LoginAsync(LoginViewModel model)
        {
            _telemetryClient.TrackEvent("Login Started");
            var result = await _signInManager.PasswordSignInAsync(model.UserName, model.Password, model.RememberMe, lockoutOnFailure: false);

            if (result.Succeeded)
            {
                _telemetryClient.TrackEvent("Login Ended");
            }
            else
            {
                _telemetryClient.TrackEvent("Login Failed");
            }

            return result;
        }

        public async Task<ApplicationUser> GetUserByNameAsync(string userName)
        {
            return await _userManager.FindByNameAsync(userName);
        }

        public async Task<IdentityResult> ChangePasswordAsync(ApplicationUser user, string oldPassword, string newPassword)
        {
            return await _userManager.ChangePasswordAsync(user, oldPassword, newPassword);
        }

        public async Task LogOffAsync()
        {
            await _signInManager.SignOutAsync();
        }
    }

    public class AdminService : IAdminService
    {
        private readonly ApplicationDbContext _context;

        public AdminService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<string> GetCurrentUserIdAsync(string username)
        {
            return await Helper.GetCurrentUserId(_context, username);
        }

        public async Task<List<SelectListItem>> GetDepartmentsAsync()
        {
            return await _context.Departments.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.DepartmentID.ToString()
            }).ToListAsync();
        }

        public async Task<List<OPSummaryReport>> GetOPSummaryReportAsync(DateTime fromDate, DateTime toDate, int departmentID)
        {
            return await _context.OPRegistrations
                .Where(r => r.VisitDate >= fromDate && r.VisitDate <= toDate && (departmentID == 0 || r.DepartmentID == departmentID))
                .GroupBy(r => r.Department)
                .Select(g => new OPSummaryReport
                {
                    DepartmentName = g.Key.Name,
                    NewMale = g.Count(r => r.IsType == false && r.Patient.GenderID == 1),
                    NewFemale = g.Count(r => r.IsType == false && r.Patient.GenderID == 2),
                    NewTotal = g.Count(r => r.IsType == false),
                    OldMale = g.Count(r => r.IsType == true && r.Patient.GenderID == 1),
                    OldFemale = g.Count(r => r.IsType == true && r.Patient.GenderID == 2),
                    OldTotal = g.Count(r => r.IsType == true),
                    GrandTotal = g.Count()
                })
                .OrderBy(result => result.DepartmentName)
                .ToListAsync();
        }

        public async Task<List<OPDeatilsReport>> GetOPDetailsReportAsync(DateTime fromDate, DateTime toDate, int departmentID)
        {
            var opDetailsQuery = _context.OPRegistrations
                .Where(a => a.VisitDate >= fromDate && a.VisitDate <= toDate);

            if (departmentID != 0)
            {
                opDetailsQuery = opDetailsQuery.Where(a => a.DepartmentID == departmentID);
            }

            return await opDetailsQuery
                .Include(a => a.Department)
                .Include(a => a.Patient)
                    .ThenInclude(p => p.Gender)
                .Include(a => a.Patient)
                    .ThenInclude(p => p.Village)
                        .ThenInclude(v => v.Mandal)
                            .ThenInclude(m => m.District)
                .Select(a => new OPDeatilsReport
                {
                    SrNo = a.ID,
                    UHID = a.Patient.UHID,
                    OPID = a.OPID,
                    DepartmentName = a.Department.Name,
                    PatientName = $"{a.Patient.FirstName} {a.Patient.LastName}",
                    Age = $"{a.Patient.Age}/Y",
                    GenderName = a.Patient.Gender.Name,
                    Address = a.Patient.Village.Name != null ?
                              $"{a.Patient.Village.Name} (V), {a.Patient.Village.Mandal.Name} (M), {a.Patient.Village.Mandal.District.Name} (D)" : "",
                    Diagnosis = "", // Populate if available
                    MobileNo = a.Patient.MobileNumber,
                    AadhaarNo = a.Patient.AadhaarNo
                }).ToListAsync();
        }
    }


}
