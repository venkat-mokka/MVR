using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.ComponentModel.DataAnnotations;

namespace DMLAutomationProcess.Models
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
        public DbSet<ApplicationRole> ApplicationRoles { get; set; }
        // DbSets for each entity
        public DbSet<Patient> Patients { get; set; }
        public DbSet<PatientAddress> PatientAddresses { get; set; }
        public DbSet<OPRegistration> OPRegistrations { get; set; }
        public DbSet<Prefix> Prefixes { get; set; }
        public DbSet<Gender> Genders { get; set; }
        public DbSet<PatientType> PatientTypes { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<Speciality> Specialities { get; set; }
        public DbSet<DaywiseSchedule> DaywiseSchedules { get; set; }
        public DbSet<Unit> Units { get; set; }
        public DbSet<Doctor> Doctors { get; set; }
        public DbSet<DepartmentDayUnitMapping> DepartmentDayUnitMappings { get; set; }
        public DbSet<UnitDoctorMapping> UnitDoctorMappings { get; set; }
        public DbSet<FeeType> FeeTypes { get; set; }
        public DbSet<AgeType> AgeTypes { get; set; }
        public DbSet<MaritalStatus> MaritalStatuses { get; set; }
        public DbSet<Religion> Religions { get; set; }
        public DbSet<BloodGroup> BloodGroups { get; set; }
        public DbSet<IDProofType> IDProofTypes { get; set; }
        public DbSet<Village> Villages { get; set; }
        public DbSet<Mandal> Mandals { get; set; }
        public DbSet<District> Districts { get; set; }
        public DbSet<State> States { get; set; }
    }
}
