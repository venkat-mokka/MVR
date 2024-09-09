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
    public class NewPatientsModel
    {
        public string? UHID { get; set; }
        public string? OPID { get; set; }

        // General Medicine
        public int GeneralMedicineMale { get; set; }
        public int GeneralMedicineFemale { get; set; }

        // Paediatrics
        public int PaediatricsMale { get; set; }
        public int PaediatricsFemale { get; set; }

        // Respiratory Medicine
        public int RespiratoryMedicineMale { get; set; }
        public int RespiratoryMedicineFemale { get; set; }

        // DVL
        public int DVLMale { get; set; }
        public int DVLFemale { get; set; }

        // Psychiatry
        public int PsychiatryMale { get; set; }
        public int PsychiatryFemale { get; set; }

        // General Surgery
        public int GeneralSurgeryMale { get; set; }
        public int GeneralSurgeryFemale { get; set; }

        // Orthopaedics
        public int OrthopaedicsMale { get; set; }
        public int OrthopaedicsFemale { get; set; }

        // Ophthalmology
        public int OphthalmologyMale { get; set; }
        public int OphthalmologyFemale { get; set; }

        // ENT
        public int ENTMale { get; set; }
        public int ENTFemale { get; set; }

        // OBG - Obstetrics and Gynecology
        public int Obstetrics { get; set; }
        public int Gynecology { get; set; }

        // Dental
        public int DentalMale { get; set; }
        public int DentalFemale { get; set; }

        // Casualty
        public int CasualtyMale { get; set; }
        public int CasualtyFemale { get; set; }

        // Other fields
        public int TotalEntries { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy HH:mm:ss}", ApplyFormatInEditMode = true)]
        public DateTime VisitDate { get; set; }
        public string Status { get; set; }
    }

    public class RevistPatientsModel
    {
        public int DepartmentID { get; set; }
        public int RUnitID { get; set; }
        public int FDepartmentID { get; set; }
        public int FUnitID { get; set; }
        public int GenderID { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public string? OPID { get; set; }
        public int NoofEntries { get; set; }
        public int TotalEntries { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy HH:mm:ss}", ApplyFormatInEditMode = true)]
        public DateTime VisitDate { get; set; }
    }

    public class BindRevisitOpDummys
    {
        public int SNo { get; set; }
        public string? UHID { get; set; }
        public int DepartmentID { get; set; }
        public int UnitID { get; set; }
        public string? DepartmentName { get; set; }
        public string? GenderName { get; set; }
        public int? Total { get; set; }
    }

    public class OPDeatilsReport
    {
        public int SrNo { get; set; }
        public string OPID { get; set; }
        public string PatientName { get; set; }
        public int Age { get; set; }
        public string GenderName { get; set; }
        public string Address { get; set; }
        public string PMRN { get; set; }
        // public string Diagnosis { get; set; }
        public string MobileNo { get; set; }
        public string AadhaarNo { get; set; }
    }

    public class OPSummaryReport
    {
        public int DepartmentID { get; set; }
        public string? DepartmentName { get; set; }
        public string PatientType { get; set; }
        public string? GenderName { get; set; }
        public int? Total { get; set; }
    }
}
