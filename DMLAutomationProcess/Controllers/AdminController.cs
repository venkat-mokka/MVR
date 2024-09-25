using DMLAutomationProcess.Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;
namespace DMLAutomationProcess.Web.Controllers
{
    public class AdminController : Controller
    {
        private readonly IAdminService _adminService;
        private string? userId = null;

        public AdminController(IAdminService adminService)
        {
            _adminService = adminService;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var userId = await _adminService.GetCurrentUserIdAsync(User?.Identity?.Name);
            return View("Index");
        }

        #region Summary & Details Reports

        [HttpGet]
        public async Task<IActionResult> OPSummaryReport()
        {
            ViewBag.Departments = await _adminService.GetDepartmentsAsync();
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> OPSummaryReport(DateTime fromDate, DateTime toDate, int departmentID)
        {
            var opSummary = await _adminService.GetOPSummaryReportAsync(fromDate, toDate, departmentID);
            ViewBag.OPSummaries = opSummary;
            return PartialView("_BindOPSummaryReport");
        }

        [HttpGet]
        public async Task<IActionResult> OPDetailsReport()
        {
            ViewBag.Departments = await _adminService.GetDepartmentsAsync();
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> OPDetailsReport(DateTime fromDate, DateTime toDate, int departmentID)
        {
            var opDetails = await _adminService.GetOPDetailsReportAsync(fromDate, toDate, departmentID);
            ViewBag.OPDeatils = opDetails;
            return PartialView("_BindOPDeatilsReport");
        }

        #endregion
    }
}
