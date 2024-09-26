using DMLAutomationProcess.Domain.Entities;
using DMLAutomationProcess.Domain.Interfaces;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Identity;

namespace DMLAutomationProcess.Infra.Services
{
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
}
