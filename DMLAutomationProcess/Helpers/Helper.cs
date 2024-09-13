//using DMLAutomationProcess.Models;
//using Microsoft.AspNetCore.Identity;
//using System.Net.Mail;

//public class Helper
//{
//    private readonly UserManager<ApplicationUser> _userManager;
//    public Helper(UserManager<ApplicationUser> userManager)
//    {
//        _userManager = userManager;
//    }

//    public async Task<int?> GetCurrentUserId(string userId)
//    {
//        ApplicationUser user = await _userManager?.FindByIdAsync(userId);
//        if (user != null)
//        {
//            return user?.UserId;
//        }
//        return null;
//    }

//}