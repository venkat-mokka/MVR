using DMLAutomationProcess.Domain.Entities;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DMLAutomationProcess.Domain.Interfaces
{
    public interface IAdminService
    {
        Task<List<SelectListItem>> GetDepartmentsAsync();
        Task<List<OPSummaryReport>> GetOPSummaryReportAsync(DateTime fromDate, DateTime toDate, int departmentID);
        Task<List<OPDeatilsReport>> GetOPDetailsReportAsync(DateTime fromDate, DateTime toDate, int departmentID);
    }
}
