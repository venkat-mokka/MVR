using Microsoft.Maui.ApplicationModel.Communication;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DMLAutomationProcess.Models
{


    public class OpRegistrationViewModel
    {
        public Patient? Patients { get; set; }
        public PatientAddress? PatientAddresss { get; set; }
        public OPRegistration? OPRegistrations { get; set; }
        public int VillageID { get; set; }
        public int UnitID { get; set; }
        public int GenderID { get; set; }
        [Required]
        public string? VillageName { get; set; }
        [Required]
        public string? MandalName { get; set; }
        [Required]
        public string? DistrictName { get; set; }
        [Required]
        public string? StateName { get; set; }
    }
    public class UHIDAndOPIDDto
    {
        public string NewUHID { get; set; }
        public string NewOPID { get; set; }
        public DateTime VisitDate { get; set; }
    }

}
