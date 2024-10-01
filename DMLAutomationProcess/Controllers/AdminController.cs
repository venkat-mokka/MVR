using DMLAutomationProcess.Domain.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using System.Text;
namespace DMLAutomationProcess.Web.Controllers
{
    //[TypeFilter(typeof(AuthorizationFilterAttribute))]
    public class AdminController : Controller
    {
        private readonly IAdminService _adminService;
        private string? userId = null;
        private readonly IHttpContextAccessor? _httpContextAccessor;

        public AdminController(IAdminService adminService, IHttpContextAccessor? httpContextAccessor)
        {
            _adminService = adminService;
            _httpContextAccessor = httpContextAccessor;
            userId = _httpContextAccessor?.HttpContext?.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
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
