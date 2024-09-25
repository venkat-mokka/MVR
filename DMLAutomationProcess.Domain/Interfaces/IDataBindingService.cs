using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DMLAutomationProcess.Domain.Interfaces
{
    public interface IDataBindingService
    {
        Task<bool> BindDataAsync(DataBindingModel model);
    }
    public class DataBindingModel
    {
        public List<SelectListItem> Prefixes { get; set; }
        public List<SelectListItem> Genders { get; set; }
        public List<SelectListItem> PatientTypes { get; set; }
        public List<SelectListItem> Departments { get; set; }
        public List<SelectListItem> Specialities { get; set; }
        public List<SelectListItem> Doctors { get; set; }
        public List<SelectListItem> FeeTypes { get; set; }
        public List<SelectListItem> AgeTypes { get; set; }
        public List<SelectListItem> MaritalStatuses { get; set; }
        public List<SelectListItem> Religions { get; set; }
        public List<SelectListItem> BloodGroups { get; set; }
        public List<SelectListItem> IdProofs { get; set; }
    }
}
