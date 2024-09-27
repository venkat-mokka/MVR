using DMLAutomationProcess.Domain.Entities;
using DMLAutomationProcess.MoDomain.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DMLAutomationProcess.Domain.Interfaces
{
    public interface IUserService
    {
        Task<List<ApplicationUsersListViewModel>> GetAllUsersAsync();
        Task<ApplicationUser> GetUserByIdAsync(string id);
        Task<IdentityResult> CreateUserAsync(RegisterViewModel model);
        Task<IdentityResult> UpdateUserAsync(EditUserViewModel model);
        Task<IdentityResult> DeleteUserAsync(string id);
        Task<List<SelectListItem>> GetRolesAsync();
        Task<string?> GetRolesByIdAsync(string id);

        Task<List<string>> GetVillageNamesAsync(string term);
        Task<List<GenderDto>> GetGenderByPrefixAsync(int prefixID);
        Task<List<MandalDto>> GetMandalByVillageNameAsync(string villageName);
        Task<string> GetNewUHIDAsync();
        Task<string> GetNewOPIDAsync();
        Task<string> GetFormattedUnitNamesAsync(int departmentID);
        Task<List<SelectListItem>> GetDoctorsByUnitAsync(string unitIds);
        Task<string> GetOpIdListAsync(int numIDs);
        Task<OpRegistrationViewModel> BindRevisitDetailsByUHID(string UHID);

        Task<NewPatientsModel> GetNewPatientsAsync();
        Task<bool> SaveDummyAsync(NewPatientsModel model);
        Task<(List<int> departments, List<string> genders)> GetDepartmentIdsAsync(NewPatientsModel model);
        Task<bool> SendNewOpDummy(DateTime visitDate, int departmentId, int unitId, int doctorId, string gender);
        Task<SelectListItem> GetUnitNames(int departmentID);
        Task<bool> SendRevisitOpDummy(string UHID, DateTime visitDate, int departmentId, int unitId, string gender);
        Task<List<SelectListItem>> GetDepartmentsAsync();
        Task<List<SelectListItem>> GetGendersAsync();
        Task<List<BindRevisitOpDummys>> GetOpDetailsByDateAsync(int departmentID, string unitIDs, int genderID, DateTime fromDate, DateTime toDate, int noofEntries);
        Task<bool> SaveDummyAsync(List<int> departments, List<string> genders, DateTime visitDate);
        Task<List<SelectListItem>> GetUnitsAsync(int departmentId, string dayName);

        Task<bool> RegisterAsync(OpRegistrationViewModel viewModel, string userName);
        Task<bool> Revisit_RegistrationAsync(OpRegistrationViewModel viewModel, string userName);
    }
}
