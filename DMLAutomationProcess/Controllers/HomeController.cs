using DMLAutomationProcess.Domain.Entities;
using DMLAutomationProcess.Infra.Dbcontext;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
namespace DMLAutomationProcess.Web.Controllers
{
    //[Authorize]
    public class HomeController : Controller
    {

        private readonly ILogger<HomeController> _logger;
        private readonly ApplicationDbContext _context;
        private readonly TelemetryClient _telemetryClient;
        private readonly IConfiguration _configuration;
        private readonly string _barcodesPath;
        private readonly string _qrcodesPath;
        private readonly string _signaturesPath;

        public HomeController(ILogger<HomeController> logger, ApplicationDbContext context, TelemetryClient telemetryClient, IConfiguration configuration)
        {
            _logger = logger;
            _context = context;
            _telemetryClient = telemetryClient;
            _configuration = configuration;
            var basePath = Directory.GetCurrentDirectory();
            _barcodesPath = Path.Combine(basePath, _configuration["Paths:Barcodes"]);
            _qrcodesPath = Path.Combine(basePath, _configuration["Paths:QRCodes"]);
            _signaturesPath = Path.Combine(basePath, _configuration["Paths:Signatures"]);
        }

        [HttpGet]
        public IActionResult Index()
        {
            //string text = "venkat mokka";
            //GenerateBarcode(text);
            //GenerateQRCode(text);

            return View("Index");
        }

        [HttpGet]
        public IActionResult AccessDenied()
        {
            return View();
        }

       [HttpGet]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public void GenerateBarcode(string content)
        {
            string barcodesPath = Path.Combine(_barcodesPath, content + ".png");
            Helper.GenerateBarcode(content, barcodesPath);
            var readBarcodetext = Helper.ReadBarcode(barcodesPath);
        }

        public void GenerateQRCode(string content)
        {
            string qrcodesPath = Path.Combine(_qrcodesPath, content + ".png");
            Helper.GenerateQrCode(content, qrcodesPath);
            var readQrcodetext = Helper.ReadQrCode(qrcodesPath);
        }

        [HttpPost]
        public IActionResult GetSignature(string base64png)
        {
            var encodedImage = base64png.Split(',')[1];
            var decodedImage = Convert.FromBase64String(encodedImage);

            EnsureDirectoryExists(_signaturesPath);

            var fileName = GenerateUniqueFileName("Signature_", "png");
            var filePath = Path.Combine(_signaturesPath, fileName);

            System.IO.File.WriteAllBytes(filePath, decodedImage);
            return Ok("ok");
        }

        private void EnsureDirectoryExists(string path)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }

        private string GenerateUniqueFileName(string prefix, string extension)
        {
            return $"{prefix}{DateTime.Now:yyyyMMddHHmmss}_{Guid.NewGuid()}.{extension}";
        }
    }
}
