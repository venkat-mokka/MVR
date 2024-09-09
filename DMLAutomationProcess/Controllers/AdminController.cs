using Microsoft.AspNetCore.Mvc;

namespace DMLAutomationProcess.Controllers
{
    public class AdminController : Controller
    {
        [HttpGet]
        public IActionResult OPSummaryReport()
        {
            return View();
        }

        [HttpPost]
        public IActionResult OPSummaryReport(DateTime fromDate, DateTime toDate, int departmentID)
        {
            return PartialView("_BindOPSummaryReport");
        }


        [HttpGet]
        public IActionResult OPDeatilsReport()
        {
            return View();
        }

        [HttpPost]
        public IActionResult OPDeatilsReport(DateTime fromDate, DateTime toDate, int departmentID)
        {
            return PartialView("_BindOPDeatilsReport");
        }
    }
}
