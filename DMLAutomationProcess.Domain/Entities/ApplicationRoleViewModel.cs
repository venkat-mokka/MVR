using System.ComponentModel.DataAnnotations;

namespace DMLAutomationProcess.Domain.Entities
{
    public class ApplicationRoleViewModel
    {
        public string Id { get; set; }
        [Display(Name = "Role Name")]
        public required string RoleName { get; set; }
    }
}
