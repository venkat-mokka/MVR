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
}
