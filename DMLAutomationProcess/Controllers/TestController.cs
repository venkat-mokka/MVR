//using DMLAutomationProcess.Models;
//using Microsoft.ApplicationInsights;
//using System.Web.Mvc;

//namespace DMLAutomationProcess.Controllers
//{
//    public class TestController : Controller
//    {
//        private readonly ILogger<TestController> _logger;
//        private readonly ApplicationDbContext _context;
//        private readonly TelemetryClient _telemetryClient;
//        private readonly IConfiguration _configuration;
//        public TestController(ILogger<TestController> logger, ApplicationDbContext context, TelemetryClient telemetryClient, IConfiguration configuration)
//        {
//            _logger = logger;
//            _context = context;
//            _telemetryClient = telemetryClient;
//            _configuration = configuration;
//        }
//        [System.Web.Mvc.HttpGet]
//        public System.Web.Mvc.ActionResult GetMandalByVillageID(int VillageID)
//        {
//            List<CollectionDetails> model = _context.Mandals.Where(a => a.VillageID == VillageID).Select(a => new CollectionDetails()
//            {
//                ID = a.MandalID,
//                Name = a.Name
//            }).ToList();

//            if (model != null)
//            {
//                var res = model.Select(a => new System.Web.Mvc.SelectListItem { Text = a.Name, Value = a.ID.ToString() }).ToList();
//                return Json(null, JsonRequestBehavior.AllowGet);
//                //return Json(model);
//            }
//            return Json(null, JsonRequestBehavior.AllowGet);
//        }
//    }
//}
