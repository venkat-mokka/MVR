using DMLAutomationProcess.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Data;
using static Microsoft.ApplicationInsights.MetricDimensionNames.TelemetryContext;
namespace DMLAutomationProcess.Controllers
{
    public class AdminController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private string? userId = null;

        public AdminController(ApplicationDbContext context, UserManager<ApplicationUser> userManager)
        {
            _context = context;
            _userManager = userManager;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            userId = await Helper.GetCurrentUserId(_context, User?.Identity?.Name);
            return View("Index");
        }

        #region Summary & Details Reports
        [HttpGet]
        public async Task<IActionResult> OPSummaryReport()
        {
            userId = await Helper.GetCurrentUserId(_context, User?.Identity?.Name);
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
                .Where(r => r.VisitDate >= fromDate && r.VisitDate <= toDate && (departmentID == 0 || r.DepartmentID == departmentID))
                .GroupBy(r => r.Department)
                .Select(g => new OPSummaryReport
                {
                    DepartmentName = g.Key.Name,
                    NewMale = g.Count(r => r.IsType == false && r.Patient.GenderID == 1),
                    NewFemale = g.Count(r => r.IsType == false && r.Patient.GenderID == 2),
                    NewTotal = g.Count(r => r.IsType == false), // Combine counts of both genders
                    OldMale = g.Count(r => r.IsType == true && r.Patient.GenderID == 1),
                    OldFemale = g.Count(r => r.IsType == true && r.Patient.GenderID == 2),
                    OldTotal = g.Count(r => r.IsType == true), // Combine counts of both genders
                    GrandTotal = g.Count() // Total registrations (New + Old)
                })
                .OrderBy(result => result.DepartmentName)
                .ToListAsync();

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
                    Address = a.Patient.Village.Name != null ? a.Patient.Village.Name + " (V), " + a.Patient.Village.Mandal.Name + " (M) " + ", " +
                    a.Patient.Village.Mandal.District.Name + " (D) " : "",

                    Diagnosis = "", // Populate if available
                    MobileNo = a.Patient.MobileNumber,
                    AadhaarNo = a.Patient.AadhaarNo
                }).ToListAsync();

            ViewBag.OPDeatils = opDetails;
            return PartialView("_BindOPDeatilsReport");
        }

        #endregion

    }
}
