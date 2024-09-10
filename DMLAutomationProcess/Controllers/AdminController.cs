using DMLAutomationProcess.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Data;
namespace DMLAutomationProcess.Controllers
{
    public class AdminController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AdminController(ApplicationDbContext context)
        {
            _context = context;
        }

        #region Summary & Details Reports
        [HttpGet]
        public async Task<IActionResult> OPSummaryReport()
        {
            ViewBag.Departments = await _context.Departments.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.DepartmentID.ToString()

            }).ToListAsync();

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> OPSummaryReport(DateTime fromDate, DateTime toDate, int departmentID)
        {
            var OPSummary = await _context.OPRegistrations
                .Where(a => a.DepartmentID == departmentID
                            && a.VisitDate >= fromDate
                            && a.VisitDate <= toDate)
                .Include(a => a.Department)
                .Include(a => a.Patient)
                .ThenInclude(p => p.Gender)
                .GroupBy(a => new { a.PatientID, a.DepartmentID, a.Patient.GenderID })
                .Select(g => new OPSummaryReport
                {
                    DepartmentName = g.FirstOrDefault().Department.Name,
                    GenderName = g.FirstOrDefault().Patient.Gender.Name,
                    Total = g.Count()
                }).ToListAsync();

            ViewBag.OPSummaries = OPSummary;
            return PartialView("_BindOPSummaryReport");
        }

        [HttpGet]
        public async Task<IActionResult> OPDeatilsReport()
        {
            ViewBag.Departments = await _context.Departments.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.DepartmentID.ToString()

            }).ToListAsync();

            return View();
        }
        [HttpPost]
        public async Task<IActionResult> OPDeatilsReport(DateTime fromDate, DateTime toDate, int departmentID)
        {
            // Query to fetch OP details, including all departments if departmentID is 0
            var opDetailsQuery = _context.OPRegistrations
                .Where(a => a.VisitDate >= fromDate && a.VisitDate <= toDate);

            if (departmentID != 0)
            {
                opDetailsQuery = opDetailsQuery.Where(a => a.DepartmentID == departmentID);
            }

            var opDetails = await opDetailsQuery
                .Include(a => a.Department)
                .Include(a => a.Patient)
                    .ThenInclude(p => p.Gender)
                .Include(a => a.Patient)
                    .ThenInclude(p => p.Village)
                        .ThenInclude(v => v.Mandal)
                            .ThenInclude(m => m.District)
                .Select(a => new OPDeatilsReport
                {
                    SrNo = a.ID,
                    UHID = a.Patient.UHID,
                    OPID = a.OPID,
                    DepartmentName = a.Department.Name,
                    PatientName = $"{a.Patient.FirstName} {a.Patient.LastName}",
                    Age = $"{a.Patient.Age}/Y",
                    GenderName = a.Patient.Gender.Name,
                    Address = a.Patient.Village.Name + " (V), " + a.Patient.Village.Mandal.Name + " (M) " + ", " +
                    a.Patient.Village.Mandal.District.Name + " (D) ",

                    Diagnosis = "", // Populate if available
                    MobileNo = a.Patient.MobileNumber,
                    AadhaarNo = a.Patient.AadhaarNo
                }).ToListAsync();

            ViewBag.OPDeatils = opDetails;
            return PartialView("_BindOPDeatilsReport");
        }

        // Helper method to format the address
        private string FormatAddress(string? villageName, string? mandalName, string? districtName)
        {
            var villagePart = !string.IsNullOrEmpty(villageName) ? $"{villageName} (V)" : "N/A";
            var mandalPart = !string.IsNullOrEmpty(mandalName) ? $"{mandalName} (M)" : "N/A";
            var districtPart = !string.IsNullOrEmpty(districtName) ? $"{districtName} (D)" : "N/A";

            return $"{villagePart}, {mandalPart}, {districtPart}";
        }
        #endregion

    }
}
