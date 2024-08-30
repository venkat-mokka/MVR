using System.ComponentModel.DataAnnotations;

namespace DMLAutomationProcess.Models
{
    public class ApplicationRoleListViewModel
    {
        public string? Id { get; set; }
        public string? RoleName { get; set; }
        public string? Description { get; set; }
        public int NumberOfUsers { get; set; }
    }

    public class ApplicationUsersListViewModel
    {
        public string? Id { get; set; }
        public string? Name { get; set; }
        public string? UserName { get; set; }
        public string? Email { get; set; }
        public string? RoleName { get; set; }
    }

    public class RolesLists
    {
        public string? Id { get; set; }
        public string? Name { get; set; }
    }

    public class RegisterViewModel
    {
        public string? UserId { get; set; }
        public required string Name { get; set; }
        public required string UserName { get; set; }

        [Display(Name = "Role")]
        public string RoleId { get; set; }

        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        public required string Email { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public required string Password { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public required string ConfirmPassword { get; set; }

    }
}
