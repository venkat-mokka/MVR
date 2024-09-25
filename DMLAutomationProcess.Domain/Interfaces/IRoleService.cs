using DMLAutomationProcess.Domain.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DMLAutomationProcess.Domain.Interfaces
{
    public interface IRoleService
    {
        Task<bool> CreateRoleAndUserAsync(string roleName, ApplicationUser user, string password);
        Task<List<ApplicationRoleListViewModel>> GetRolesWithUserCountsAsync();
        Task<ApplicationRoleViewModel> GetRoleByIdAsync(string id);
        Task<bool> AddOrUpdateRoleAsync(ApplicationRoleViewModel model);
        Task<ApplicationRoleListViewModel> GetRoleForDeletionAsync(string id);
        Task<bool> DeleteRoleAsync(string id);
    }

    public interface IAccountService
    {
        Task<SignInResult> LoginAsync(LoginViewModel model);
        Task<ApplicationUser> GetUserByNameAsync(string userName);
        Task<IdentityResult> ChangePasswordAsync(ApplicationUser user, string oldPassword, string newPassword);
        Task LogOffAsync();
    }

    public interface IAdminService
    {
        Task<string> GetCurrentUserIdAsync(string username);
        Task<List<SelectListItem>> GetDepartmentsAsync();
        Task<List<OPSummaryReport>> GetOPSummaryReportAsync(DateTime fromDate, DateTime toDate, int departmentID);
        Task<List<OPDeatilsReport>> GetOPDetailsReportAsync(DateTime fromDate, DateTime toDate, int departmentID);
    }
}
