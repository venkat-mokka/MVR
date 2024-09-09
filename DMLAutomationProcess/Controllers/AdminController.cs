using DMLAutomationProcess.Models;
using Microsoft.ApplicationInsights;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Maui.Graphics;
using System.Data;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;
namespace DMLAutomationProcess.Controllers
{
    public class AdminController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AdminController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> OPSummaryReport()
        {
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
            var bindRevisitOpDummys = await _context.OPRegistrations
                .Where(a => a.DepartmentID == departmentID
                            && a.VisitDate >= fromDate
                            && a.VisitDate <= toDate)
                .Include(a => a.Department)
                .Include(a => a.Patient)
                .ThenInclude(p => p.Gender)
                .GroupBy(a => new { a.PatientID, a.DepartmentID, a.Patient.GenderID })
                .Select(g => new OPSummaryReport
                {
                    DepartmentName = g.FirstOrDefault().Department.Name,
                    GenderName = g.FirstOrDefault().Patient.Gender.Name,
                    Total = g.Count()
                }).ToListAsync();

            ViewBag.bindRevisitOpDummys = bindRevisitOpDummys;
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
            var bindRevisitOpDummys = await _context.OPRegistrations
              .Where(a => a.DepartmentID == departmentID
                          && a.VisitDate >= fromDate
                          && a.VisitDate <= toDate)
              .Include(a => a.Department)
              .Include(a => a.Patient)
              .ThenInclude(p => p.Gender)
              .GroupBy(a => new { a.PatientID, a.DepartmentID, a.Patient.GenderID })
              .Select(g => new OPSummaryReport
              {
                  DepartmentName = g.FirstOrDefault().Department.Name,
                  GenderName = g.FirstOrDefault().Patient.Gender.Name,
                  Total = g.Count()
              }).ToListAsync();
            ViewBag.bindRevisitOpDummys = bindRevisitOpDummys;
            return PartialView("_BindOPDeatilsReport");
        }
    }
}
