using DMLAutomationProcess.Domain.Entities;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DMLAutomationProcess.Domain.Interfaces
{
    public interface IAccountService
    {
        Task<SignInResult> LoginAsync(LoginViewModel model);
        Task<ApplicationUser> GetUserByNameAsync(string userName);
        Task<IdentityResult> ChangePasswordAsync(ApplicationUser user, string oldPassword, string newPassword);
        Task LogOffAsync();
    }
}
