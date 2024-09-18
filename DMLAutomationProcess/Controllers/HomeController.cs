using DMLAutomationProcess.Models;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using ZXing.Common;
using ZXing;
using QRCoder.Core;
using IronBarCode;
using Microsoft.Maui.Storage;
using static System.Net.Mime.MediaTypeNames;
namespace DMLAutomationProcess.Controllers
{
    //[Authorize]
    public class HomeController : Controller
    {

        private readonly ILogger<HomeController> _logger;
        private readonly ApplicationDbContext _context;
        private readonly TelemetryClient _telemetryClient;
        private readonly IConfiguration _configuration;
        private readonly string _barcodesPath = Path.Combine(Directory.GetCurrentDirectory(), "Helpers", "BarCodes");
        private readonly string _qrcodesPath = Path.Combine(Directory.GetCurrentDirectory(), "Helpers", "QRCodes");
        private readonly string _signaturesPath = Path.Combine(Directory.GetCurrentDirectory(), "Helpers", "Signatures");

        public HomeController(ILogger<HomeController> logger, ApplicationDbContext context, TelemetryClient telemetryClient, IConfiguration configuration)
        {
            _logger = logger;
            _context = context;
            _telemetryClient = telemetryClient;
            _configuration = configuration;
        }

        public IActionResult Index()
        {
            //string text = "venkat mokka";
            //GenerateBarcode(text);
            //GenerateQRCode(text);

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
