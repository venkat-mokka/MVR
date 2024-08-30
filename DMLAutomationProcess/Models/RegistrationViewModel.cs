using System.ComponentModel.DataAnnotations;

namespace DMLAutomationProcess.Models
{
    public class RegistrationViewModel
    {
        public string UHID { get; set; }

        public string OPID { get; set; }

        public string FirstName { get; set; }

        public string? MiddleName { get; set; }

        public string LastName { get; set; }

        public int? Age { get; set; }

        public DateTime? DOB { get; set; }

        public string? Email { get; set; }

        public string? Phone { get; set; }

        public int PrefixID { get; set; }

        public long? AadhaarNo { get; set; }

        public long? AbhaNo { get; set; }

        public int? PatientTypeID { get; set; }

        public int? DepartmentID { get; set; }

        public int? SpecialityID { get; set; }

        public int? DoctorID { get; set; }

        public int? FeeTypeID { get; set; }

        public int? YearID { get; set; }
    }
}
