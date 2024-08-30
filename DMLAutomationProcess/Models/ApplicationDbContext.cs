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
        public DbSet<OPRegistration> OPRegistrations { get; set; }
        public DbSet<Prefix> Prefixs { get; set; }
        public DbSet<Gender> Genders { get; set; }
        public DbSet<PatientType> PatientTypes { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<Speciality> Specialitys { get; set; }
        public DbSet<Doctor> Doctors { get; set; }
        public DbSet<FeeType> FeeTypes { get; set; }
        public DbSet<Year> Years { get; set; }

        public DbSet<ContactDetail> ContactDetails { get; set; }
        public DbSet<MaritalStatus> MaritalStatuss { get; set; }
        public DbSet<Religion> Religions { get; set; }
        public DbSet<BloodGroup> BloodGroups { get; set; }
        public DbSet<IdProof> IdProofs { get; set; }
        public DbSet<Village> Villages { get; set; }
        public DbSet<Mandal> Mandals { get; set; }
        public DbSet<District> Districts { get; set; }
        public DbSet<State> States { get; set; }
        public DbSet<Country> Countrys { get; set; }
    }
}
