using DMLAutomationProcess.Models;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace DMLAutomationProcess.Controllers
{
    //[Authorize]
    public class HomeController : Controller
    {

        private readonly ILogger<HomeController> _logger;
        private readonly ApplicationDbContext _context;
        private readonly TelemetryClient _telemetryClient;
        private readonly IConfiguration _configuration;
        private readonly List<TenantDetails>? _tenantDetails;
        private readonly List<AzureSearch>? _azureSearches;
        public HomeController(ILogger<HomeController> logger, ApplicationDbContext context, TelemetryClient telemetryClient, IConfiguration configuration)
        {
            _logger = logger;
            _context = context;
            _telemetryClient = telemetryClient;
            _configuration = configuration;
        }


        //[Authorize(Roles = "Admin,User")]
        public IActionResult Index()
        {
            return View("Index");
        }
        public IActionResult AccessDenied()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }

    public interface ITenant
    {
        public string TenantId { get; set; }
        public string ReadConnnectionString { get; set; }

        public string WriteConnnectionString { get; set; }

        public string LogConnectionString { get; set; }

        public List<AzureSearch>? AzureSearches { get; set; }
    }

    public class Tenant : ITenant
    {
        public Tenant() { }
        public Tenant(string tenantId, string readConnectionString, string writeConnectionString, string logConnectionString, List<AzureSearch> azureSearches)
        {
            TenantId = tenantId;
            ReadConnnectionString = readConnectionString;
            WriteConnnectionString = writeConnectionString;
            LogConnectionString = logConnectionString;
            AzureSearches = azureSearches;
        }
        public string TenantId { get; set; }
        public string ReadConnnectionString { get; set; }
        public string WriteConnnectionString { get; set; }

        public string LogConnectionString { get; set; }
        public List<AzureSearch>? AzureSearches { get; set; }
    }

    public class TenantDetails
    {
        public string TenantId { get; set; }
        public string ReadConnnectionString { get; set; }
        public string WriteConnnectionString { get; set; }
        public string LogConnectionString { get; set; }
        public List<AzureSearch> AzureSearch { get; set; }
    }

    public class AzureSearch
    {
        public string IndexDefinition { get; set; }
        public string AzureEndpoint { get; set; }
        public string AzureApiKey { get; set; }
        public string AzureIndexName { get; set; }
        public string SqlFallbackConnectionString { get; set; }
        public string SearchTableName { get; set; }
        public bool SqlFallbackEnabled { get; set; }
    }
}
