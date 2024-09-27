using Microsoft.EntityFrameworkCore;
using IronBarCode;
using QRCoder.Core;
using System.Drawing;
using Microsoft.Maui.ApplicationModel;
using System.Drawing.Imaging;
using static QRCoder.Core.QRCodeGenerator;
using DMLAutomationProcess.Infra.Dbcontext;

public static class Helper
{
    public static async Task<string?> GetCurrentUserId(ApplicationDbContext _context, string? userName)
    {
        var userId = await _context.Users.Where(a => a.UserName == userName).Select(a => a.Id).FirstOrDefaultAsync();
        if (userId != null)
        {
            return userId;
        }
        return null;
    }

    public static void GenerateBarcode(string text, string filePath)
    {
        var barcode = BarcodeWriter.CreateBarcode(text, BarcodeEncoding.Code128, 300, 100);
        barcode.SaveAsPng(filePath);
    }

    public static string? ReadBarcode(string filePath)
    {
        var barcodeResult = BarcodeReader.Read(filePath);
        return barcodeResult?.FirstOrDefault()?.Value;
    }
    public static void GenerateQrCode(string text, string filePath)
    {

        // Ensure the input text is valid
        if (string.IsNullOrEmpty(text))
        {
            throw new ArgumentException("Text for QR code cannot be null or empty.", nameof(text));
        }
        // Initialize QR Code Generator
        using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
        {
            // Create the QR code with the given error correction level
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(text, QRCodeGenerator.ECCLevel.Q);

            // Create the QR code image with the specified pixel size
            using (QRCode qrCode = new QRCode(qrCodeData))
            using (Bitmap qrCodeImage = qrCode.GetGraphic(20))
            {
                // Save the QR code image to the provided file path
                using (var stream = new MemoryStream())
                {
                    qrCodeImage.Save(stream, ImageFormat.Png);
                    File.WriteAllBytes(filePath, stream.ToArray());
                }
            }
        }
        //var qrCode = QRCodeWriter.CreateQrCode(text, 300); // You can adjust size (300x300 here)
        //qrCode.SaveAsPng(filePath);
    }

    public static string? ReadQrCode(string filePath)
    {
        var qrCodeResult = BarcodeReader.Read(filePath);
        return qrCodeResult?.FirstOrDefault()?.Value;
    }
}

public static class Constants
{
    public const string UserName = "UserName";
    public const string EmailOTP = "email";
}
