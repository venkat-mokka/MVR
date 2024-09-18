using DMLAutomationProcess.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DMLAutomationProcess.Controllers
{
    public class DoctorController : Controller
    {
        private readonly ApplicationDbContext _context;
        private string? userId = null;
        public DoctorController(ApplicationDbContext context)
        {
            _context = context;
        }
        public async Task<IActionResult> Index()
        {
            userId = await Helper.GetCurrentUserId(_context, User?.Identity?.Name);
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> OPPatients()
        {
            // Query to fetch OP details, including all departments if departmentID is 0
            var opDetailsQuery = _context.OPRegistrations
                .Where(a => a.DepartmentID == 5);

            var OPPatients = await opDetailsQuery
                 .Include(a => a.Doctor)
                .Include(a => a.Department)
                .Include(a => a.Patient)
                    .ThenInclude(p => p.Gender)
                .Include(a => a.Patient)
                .Select(a => new OPConsulation
                {
                    SrNo = a.ID,
                    UHID = a.Patient.UHID,
                    OPID = a.OPID,
                    DoctorName = a.Doctor.Name,
                    DepartmentName = a.Department.Name,
                    PatientName = $"{a.Patient.FirstName} {a.Patient.LastName}",
                    Age = $"{a.Patient.Age}",
                    GenderName = a.Patient.Gender.Name,
                    VisitDate = a.VisitDate,
                    Consulted = "N",
                    PatType = a.IsType == false ? "New" : "Revist"
                }).ToListAsync();

            ViewBag.OPPatients = OPPatients;

            return View();
        }

        [HttpGet]
        public async Task<IActionResult> IPPatients()
        {

            return View();
        }

        [HttpGet]
        public async Task<IActionResult> OTSchedule()
        {

            return View();
        }
    }
}
