using Microsoft.AspNetCore.Mvc;

namespace DMLAutomationProcess.Controllers
{
    public class AdminController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
