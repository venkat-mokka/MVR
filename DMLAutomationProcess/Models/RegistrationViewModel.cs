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
        [Required]
        public string? UnitName { get; set; }
        //[Required]
        //public int DoctorID { get; set; }
        public string UnitIds { get; set; }
    }
    public class UHIDAndOPIDDto
    {
        public string NewUHID { get; set; }
        public string NewOPID { get; set; }
        public DateTime VisitDate { get; set; }
    }

}
