using DMLAutomationProcess.Domain.Interfaces;
using DMLAutomationProcess.Infra.Dbcontext;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace DMLAutomationProcess.Infra.Services
{
    public class DataBindingService : IDataBindingService
    {
        private readonly ApplicationDbContext _context;

        public DataBindingService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<bool> BindDataAsync(DataBindingModel model)
        {
            model.Prefixes = await GetSelectListAsync(_context.Prefixes);
            model.Genders = await GetSelectListAsync(_context.Genders);
            model.PatientTypes = await GetSelectListAsync(_context.PatientTypes);
            model.Departments = await GetSelectListAsync(_context.Departments);
            model.Specialities = await GetSelectListAsync(_context.Specialities);
            model.Doctors = new List<SelectListItem> { new SelectListItem { Text = "", Value = "" } };
            model.FeeTypes = await GetSelectListAsync(_context.FeeTypes);
            model.AgeTypes = await GetSelectListAsync(_context.AgeTypes);
            model.MaritalStatuses = await GetSelectListAsync(_context.MaritalStatuses);
            model.Religions = await GetSelectListAsync(_context.Religions);
            model.BloodGroups = await GetSelectListAsync(_context.BloodGroups);
            model.IdProofs = await GetSelectListAsync(_context.IDProofTypes);

            return true;
        }

        private async Task<List<SelectListItem>> GetSelectListAsync<T>(IQueryable<T> source) where T : class
        {
            var list = await source.ToListAsync();
            var ff = list.Select(r => new SelectListItem
            {
                Text = r.GetType().GetProperty("Name")?.GetValue(r, null)?.ToString() ?? string.Empty,
                Value = r.GetType().GetProperty($"{typeof(T).Name}ID")?.GetValue(r, null)?.ToString() ?? string.Empty
            }).ToList();

            return ff.ToList();
        }
    }
}
