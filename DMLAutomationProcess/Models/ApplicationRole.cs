using Microsoft.AspNetCore.Identity;

namespace DMLAutomationProcess.Models
{
    public class ApplicationRole : IdentityRole
    {
        public string? Description { get; set; }
        public DateTime CreatedDate { get; set; }
        public string? IPAddress { get; set; }
    }
}
