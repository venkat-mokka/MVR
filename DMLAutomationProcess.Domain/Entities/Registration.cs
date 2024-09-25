using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DMLAutomationProcess.Domain.Entities
{
    [Table("Patient")]
    public class Patient
    {
        [Key]
        public int ID { get; set; }

        [Required]
        [MaxLength(20)]
        public string UHID { get; set; }

        public long? AadhaarNo { get; set; }

        [Required]
        public int GenderID { get; set; }

        [Required]
        [MaxLength(50)]
        public string FirstName { get; set; }

        [MaxLength(50)]
        public string? MiddleName { get; set; }

        [Required]
        [MaxLength(50)]
        public string LastName { get; set; }

        [MaxLength(50)]
        public string FatherName { get; set; }

        [MaxLength(50)]
        public string? HusbandName { get; set; }

        [Required]
        public int PrefixID { get; set; }

        [Required]
        public int MaritalStatusID { get; set; }

        [Required]
        public int Age { get; set; }

        [Required]
        public int AgeTypeID { get; set; }

        public DateTime? DOB { get; set; }

        public long? MobileNumber { get; set; }

        public long? AlternateMobileNumber { get; set; }

        [MaxLength(100)]
        public string? Email { get; set; }

        public int? ReligionID { get; set; }

        [MaxLength(50)]
        public string? Caste { get; set; }

        public int? BloodGroupID { get; set; }

        public int? IDProofTypeID { get; set; }

        [MaxLength(50)]
        public string? IDProof { get; set; }

        public long? AbhaNo { get; set; }

        public int? PatientTypeID { get; set; }
        public int? VillageID { get; set; }

        public DateTime? CreatedDate { get; set; } = DateTime.Now;

        // Navigation properties
        [ForeignKey("PrefixID")]
        public virtual Prefix? Prefix { get; set; }

        [ForeignKey("GenderID")]
        public virtual Gender? Gender { get; set; }

        [ForeignKey("MaritalStatusID")]
        public virtual MaritalStatus? MaritalStatus { get; set; }

        [ForeignKey("AgeTypeID")]
        public virtual AgeType? AgeType { get; set; }

        [ForeignKey("ReligionID")]
        public virtual Religion? Religion { get; set; }

        [ForeignKey("BloodGroupID")]
        public virtual BloodGroup? BloodGroup { get; set; }

        [ForeignKey("IDProofTypeID")]
        public virtual IDProofType? IDProofType { get; set; }

        [ForeignKey("PatientTypeID")]
        public virtual PatientType? PatientType { get; set; }

        [ForeignKey("VillageID")]
        public virtual Village? Village { get; set; }
    }

    [Table("PatientAddress")]
    public class PatientAddress
    {
        [Key]
        public int ID { get; set; }

        [Required]
        public int PatientID { get; set; }

        [Required]
        [MaxLength(100)]
        public string Village { get; set; }

        [Required]
        [MaxLength(100)]
        public string Mandal { get; set; }

        [Required]
        [MaxLength(100)]
        public string District { get; set; }

        [Required]
        [MaxLength(100)]
        public string State { get; set; }

        [Required]
        public int PinCode { get; set; }

        public DateTime? CreatedDate { get; set; } = DateTime.Now;

        // Navigation property
        [ForeignKey("PatientID")]
        public virtual Patient? Patient { get; set; }
    }

    [Table("OPRegistration")]
    public class OPRegistration
    {
        [Key]
        public int ID { get; set; }

        [Required]
        public int PatientID { get; set; }

        [Required]
        [MaxLength(20)]
        public string OPID { get; set; }

        [Required]
        public DateTime VisitDate { get; set; }

        public bool? IsMlcCase { get; set; }

        public bool? IsEmergencyCase { get; set; }

        public int? DepartmentID { get; set; }
        public int? DoctorID { get; set; }

        public int? SpecialityID { get; set; }

        public int? FeeTypeID { get; set; }

        [Required]
        [MaxLength(50)]
        public string ReferredBy { get; set; }

        public DateTime? CreatedDate { get; set; } = DateTime.Now;

        [Required]
        public bool IsActive { get; set; } = true;

        // Navigation properties
        [ForeignKey("PatientID")]
        public virtual Patient? Patient { get; set; }

        [ForeignKey("DepartmentID")]
        public virtual Department? Department { get; set; }
        [ForeignKey("DoctorID")]
        public virtual Doctor? Doctor { get; set; }

        [ForeignKey("SpecialityID")]
        public virtual Speciality? Speciality { get; set; }

        [ForeignKey("FeeTypeID")]
        public virtual FeeType? FeeType { get; set; }

        public bool? IsCamp { get; set; }
        public bool? IsType { get; set; }
    }

    [Table("Prefix")]
    public class Prefix
    {
        [Key]
        public int PrefixID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public int? GenderID { get; set; }

        // Navigation properties
        [ForeignKey("GenderID")]
        public virtual Gender? Gender { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("Gender")]
    public class Gender
    {
        [Key]
        public int GenderID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<Prefix> Prefixes { get; set; }
    }

    [Table("PatientType")]
    public class PatientType
    {
        [Key]
        public int PatientTypeID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("Department")]
    public class Department
    {
        [Key]
        public int DepartmentID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<OPRegistration> OPRegistrations { get; set; }
        public virtual ICollection<DepartmentDayUnitMapping> DepartmentDayUnitMappings { get; set; }
    }

    [Table("DaywiseSchedule")]
    public class DaywiseSchedule
    {
        [Key]
        public int DayID { get; set; }

        [StringLength(10)]
        public string Name { get; set; }

        // Navigation property
        public virtual ICollection<DepartmentDayUnitMapping> DepartmentDayUnitMappings { get; set; }
    }

    [Table("DepartmentDayUnitMapping")]
    public class DepartmentDayUnitMapping
    {
        [Key]
        public int DepartmentDayUnitMappingID { get; set; }

        [Required]
        public int DepartmentID { get; set; }

        [Required]
        public int DayID { get; set; }

        [Required]
        public int UnitID { get; set; }

        // Navigation properties
        [ForeignKey("DepartmentID")]
        public virtual Department Departments { get; set; }

        [ForeignKey("DayID")]
        public virtual DaywiseSchedule DaywiseSchedules { get; set; }

        [ForeignKey("UnitID")]
        public virtual Unit Units { get; set; }
    }

    [Table("Speciality")]
    public class Speciality
    {
        [Key]
        public int SpecialityID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<OPRegistration> OPRegistrations { get; set; }
    }

    [Table("Unit")]
    public class Unit
    {
        [Key]
        public int UnitID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<DepartmentDayUnitMapping> DepartmentDayUnitMappings { get; set; }
        public virtual ICollection<UnitDoctorMapping> UnitDoctorMappings { get; set; }
    }

    [Table("Doctor")]
    public class Doctor
    {
        [Key]
        public int DoctorID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }
        public virtual ICollection<OPRegistration> OPRegistrations { get; set; }
        public virtual ICollection<UnitDoctorMapping> UnitDoctorMappings { get; set; }
    }

    [Table("UnitDoctorMapping")]
    public class UnitDoctorMapping
    {
        [Key]
        public int UnitDoctorMappingID { get; set; }

        [Required]
        public int UnitID { get; set; }

        [Required]
        public int DoctorID { get; set; }

        // Navigation properties
        [ForeignKey("UnitID")]
        public virtual Unit Units { get; set; }

        [ForeignKey("DoctorID")]
        public virtual Doctor Doctors { get; set; }
    }

    [Table("FeeType")]
    public class FeeType
    {
        [Key]
        public int FeeTypeID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<OPRegistration> OPRegistrations { get; set; }
    }

    [Table("AgeType")]
    public class AgeType
    {
        [Key]
        public int AgeTypeID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("MaritalStatus")]
    public class MaritalStatus
    {
        [Key]
        public int MaritalStatusID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("Religion")]
    public class Religion
    {
        [Key]
        public int ReligionID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("BloodGroup")]
    public class BloodGroup
    {
        [Key]
        public int BloodGroupID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("IDProofType")]
    public class IDProofType
    {
        [Key]
        public int IDProofTypeID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("Village")]
    public class Village
    {
        [Key]
        public int VillageID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public int MandalID { get; set; }

        public int Pincode { get; set; }

        // Navigation properties
        [ForeignKey("MandalID")]
        public virtual Mandal? Mandal { get; set; }

        public virtual ICollection<Patient> Patients { get; set; }
    }

    [Table("Mandal")]
    public class Mandal
    {
        [Key]
        public int MandalID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public int DistrictID { get; set; }

        // Navigation properties
        [ForeignKey("DistrictID")]
        public virtual District? District { get; set; }

        public virtual ICollection<Village> Villages { get; set; }
    }

    [Table("District")]
    public class District
    {
        [Key]
        public int DistrictID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public int StateID { get; set; }

        // Navigation properties
        [ForeignKey("StateID")]
        public virtual State? State { get; set; }

        public virtual ICollection<Mandal> Mandals { get; set; }
    }

    [Table("State")]
    public class State
    {
        [Key]
        public int StateID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        public virtual ICollection<District> Districts { get; set; }
    }
}
