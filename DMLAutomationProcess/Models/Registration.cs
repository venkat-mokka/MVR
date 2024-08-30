using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace DMLAutomationProcess.Models
{
    public class OPRegistration
    {
        [Key]
        public int ID { get; set; }

        [Display(Name = "UHID")]
        [StringLength(20)]
        [Required]
        public string? UHID { get; set; }

        [Display(Name = "OP")]
        [StringLength(20)]
        [Required]
        public string? OPID { get; set; }

        [Display(Name = "VisitDate")]
        [StringLength(20)]
        [Required]
        public DateTime VisitDate { get; set; }

        [Required]
        [Display(Name = "First Name")]
        public string? FirstName { get; set; }

        public string? MiddleName { get; set; }

        [Required]
        [Display(Name = "Last Name")]
        public string? LastName { get; set; }

        public int? Age { get; set; }

        [Display(Name = "Date of Birth")]
        public DateTime? DOB { get; set; }

        [EmailAddress]
        public string? Email { get; set; }

        [Display(Name = "Phone")]
        [StringLength(15)] // Assuming a format for phone numbers
        public string? Phone { get; set; }

        [Display(Name = "Prefix")]
        public int PrefixID { get; set; }

        [Display(Name = "Aadhaar Number")]
        public long? AadhaarNo { get; set; }

        [Display(Name = "ABHA Number")]
        public long? AbhaNo { get; set; }

        [Display(Name = "Patient Type")]
        public int? PatientTypeID { get; set; }

        [Display(Name = "Department")]
        public int? DepartmentID { get; set; }

        [Display(Name = "Speciality")]
        public int? SpecialityID { get; set; }

        [Display(Name = "Doctor")]
        public int? DoctorID { get; set; }

        [Display(Name = "Fee Type")]
        public int? FeeTypeID { get; set; }

        [Display(Name = "Year")]
        public int? YearID { get; set; }

        public DateTime? CreatedDate { get; set; } = DateTime.Now;

        public bool IsActive { get; set; } = true;

        // Navigation properties
        public virtual Prefix? Prefixs { get; set; }
        public virtual PatientType? PatientTypes { get; set; }
        public virtual Department? Departments { get; set; }
        public virtual Speciality? Specialitys { get; set; }
        public virtual Doctor? Doctors { get; set; }
        public virtual FeeType? FeeTypes { get; set; }
        public virtual Year? Years { get; set; }
        public virtual ICollection<ContactDetail> ContactDetails { get; set; }
    }

    public class ContactDetail
    {
        [Key]
        public int ID { get; set; }
        public int? OPRegistrationID { get; set; }
        public string? FatherName { get; set; }
        public string? HusbandName { get; set; }
        public string? Caste { get; set; }
        public bool IsEmergencyCase { get; set; }
        public string? RefBy { get; set; }
        public int? MaritalStatusID { get; set; }
        public int? ReligionID { get; set; }
        public int? BloodGroupID { get; set; }
        public int? IdProofID { get; set; }
        public int? VillageID { get; set; }
        public DateTime? CreatedDate { get; set; } = DateTime.Now;
        public bool IsActive { get; set; } = true;
        public virtual OPRegistration? OPRegistrations { get; set; }
        public virtual MaritalStatus? MaritalStatuss { get; set; }
        public virtual Religion? Religions { get; set; }
        public virtual BloodGroup? BloodGroups { get; set; }
        public virtual IdProof? IdProofs { get; set; }
        public virtual Village? Villages { get; set; }
    }

    public class Prefix
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public int GenderID { get; set; }
        public virtual required Gender Genders { get; set; }
        public virtual required ICollection<OPRegistration> OPRegistrations { get; set; }
    }
    public class Gender
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<Prefix> Prefixs { get; set; }
    }
    public class PatientType
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<OPRegistration> OPRegistrations { get; set; }
    }
    public class Department
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<OPRegistration> OPRegistrations { get; set; }
    }
    public class Speciality
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required Unit Units { get; set; }
    }
    public class Unit
    {
        [Key]
        public int ID { get; set; }
        public int SpecialityID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<Speciality> Speciality { get; set; }
    }
    public class Doctor
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<OPRegistration> OPRegistrations { get; set; }
    }
    public class FeeType
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<OPRegistration> OPRegistrations { get; set; }
    }
    public class Year
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<OPRegistration> OPRegistrations { get; set; }
    }
    public class MaritalStatus
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<ContactDetail> ContactDetails { get; set; }
    }
    public class Religion
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<ContactDetail> ContactDetails { get; set; }
    }
    public class BloodGroup
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<ContactDetail> ContactDetails { get; set; }
    }
    public class IdProof
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public virtual required ICollection<ContactDetail> ContactDetails { get; set; }
    }
    public class Village
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public int Pincode { get; set; }
        public virtual required ICollection<ContactDetail> ContactDetails { get; set; }
        public virtual required ICollection<Mandal> Mandals { get; set; }
    }
    public class Mandal
    {
        [Key]
        public int ID { get; set; }
        public int VillageID { get; set; }
        public required string Name { get; set; }
        public virtual required Village Villages { get; set; }
        public virtual required ICollection<District> Districts { get; set; }
    }

    public class District
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public int MandalID { get; set; }
        public virtual required Mandal Mandals { get; set; }
        public virtual required ICollection<State> States { get; set; }
    }

    public class State
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public int DistrictID { get; set; }
        public virtual required District Districts { get; set; }
        public virtual required ICollection<Country> Countrys { get; set; }
    }
    public class Country
    {
        [Key]
        public int ID { get; set; }
        public required string Name { get; set; }
        public int StateID { get; set; }
        public virtual required State States { get; set; }
    }

    public class City
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
