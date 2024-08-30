using System.ComponentModel.DataAnnotations;

namespace DMLAutomationProcess.Models
{
    public class OpRegistrationViewModel
    {
        public OPRegistration OPRegistrations { get; set; }

        public ContactDetail ContactDetails { get; set; }
        public int UnitID { get; set; }
        public int MandalID { get; set; }
        public int GenderID { get; set; }
        public int DistrictID { get; set; }
        public int StateID { get; set; }
        public int CountryID { get; set; }
    }
}
