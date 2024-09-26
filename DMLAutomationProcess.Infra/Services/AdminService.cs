using DMLAutomationProcess.Domain.Entities;
using DMLAutomationProcess.Domain.Interfaces;
using DMLAutomationProcess.Infra.Dbcontext;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DMLAutomationProcess.Infra.Services
{
    public class AdminService : IAdminService
    {
        private readonly ApplicationDbContext _context;

        public AdminService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<string> GetCurrentUserIdAsync(string username)
        {
            return await Helper.GetCurrentUserId(_context, username);
        }

        public async Task<List<SelectListItem>> GetDepartmentsAsync()
        {
            return await _context.Departments.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.DepartmentID.ToString()
            }).ToListAsync();
        }

        public async Task<List<OPSummaryReport>> GetOPSummaryReportAsync(DateTime fromDate, DateTime toDate, int departmentID)
        {
            return await _context.OPRegistrations
                .Where(r => r.VisitDate >= fromDate && r.VisitDate <= toDate && (departmentID == 0 || r.DepartmentID == departmentID))
                .GroupBy(r => r.Department)
                .Select(g => new OPSummaryReport
                {
                    DepartmentName = g.Key.Name,
                    NewMale = g.Count(r => r.IsType == false && r.Patient.GenderID == 1),
                    NewFemale = g.Count(r => r.IsType == false && r.Patient.GenderID == 2),
                    NewTotal = g.Count(r => r.IsType == false),
                    OldMale = g.Count(r => r.IsType == true && r.Patient.GenderID == 1),
                    OldFemale = g.Count(r => r.IsType == true && r.Patient.GenderID == 2),
                    OldTotal = g.Count(r => r.IsType == true),
                    GrandTotal = g.Count()
                })
                .OrderBy(result => result.DepartmentName)
                .ToListAsync();
        }

        public async Task<List<OPDeatilsReport>> GetOPDetailsReportAsync(DateTime fromDate, DateTime toDate, int departmentID)
        {
            var opDetailsQuery = _context.OPRegistrations
                .Where(a => a.VisitDate >= fromDate && a.VisitDate <= toDate);

            if (departmentID != 0)
            {
                opDetailsQuery = opDetailsQuery.Where(a => a.DepartmentID == departmentID);
            }

            return await opDetailsQuery
                .Include(a => a.Department)
                .Include(a => a.Patient)
                    .ThenInclude(p => p.Gender)
                .Include(a => a.Patient)
                    .ThenInclude(p => p.Village)
                        .ThenInclude(v => v.Mandal)
                            .ThenInclude(m => m.District)
                .Select(a => new OPDeatilsReport
                {
                    SrNo = a.ID,
                    UHID = a.Patient.UHID,
                    OPID = a.OPID,
                    DepartmentName = a.Department.Name,
                    PatientName = $"{a.Patient.FirstName} {a.Patient.LastName}",
                    Age = $"{a.Patient.Age}/Y",
                    GenderName = a.Patient.Gender.Name,
                    Address = a.Patient.Village.Name != null ?
                              $"{a.Patient.Village.Name} (V), {a.Patient.Village.Mandal.Name} (M), {a.Patient.Village.Mandal.District.Name} (D)" : "",
                    Diagnosis = "", // Populate if available
                    MobileNo = a.Patient.MobileNumber,
                    AadhaarNo = a.Patient.AadhaarNo
                }).ToListAsync();
        }
    }
}
