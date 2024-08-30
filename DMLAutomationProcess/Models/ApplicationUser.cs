using Microsoft.AspNetCore.Identity;

namespace DMLAutomationProcess.Models
{
    public class ApplicationUser : IdentityUser
    {
        public int? UserId { get; set; }
        public required string Name { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool IsActive { get; set; }
    }
}
