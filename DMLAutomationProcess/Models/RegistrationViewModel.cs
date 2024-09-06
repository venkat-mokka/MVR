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
        public DateTime DateTime { get; set; }
        public string Status { get; set; }
    }

}
