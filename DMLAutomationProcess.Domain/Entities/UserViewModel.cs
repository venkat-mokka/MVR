using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
namespace DMLAutomationProcess.MoDomain.Entities
{
    public class UserViewModel
    {
        public string? Id { get; set; }
        public required string UserName { get; set; }
        [DataType(DataType.Password)]
        public required string Password { get; set; }
        [Display(Name = "Confirm Password")]
        [DataType(DataType.Password)]
        public required string ConfirmPassword { get; set; }
        public required string Name { get; set; }
        public string Email { get; set; }
        public List<SelectListItem> ApplicationRoles { get; set; }
        [Display(Name = "Role")]
        public string ApplicationRoleId { get; set; }
    }

    public class GenderDto
    {
        public int genderID { get; set; }
        public string genderName { get; set; }
    }
    public class MandalDto
    {
        public int villageID { get; set; }
        public string pinCode { get; set; }
        public string mandalName { get; set; }
        public string districtName { get; set; }
        public string stateName { get; set; }
    }

}
