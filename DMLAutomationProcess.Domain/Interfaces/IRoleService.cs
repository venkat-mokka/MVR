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
}
