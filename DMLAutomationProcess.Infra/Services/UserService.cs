using DMLAutomationProcess.Domain.Entities;
using DMLAutomationProcess.Domain.Interfaces;
using DMLAutomationProcess.Infra.Dbcontext;
using DMLAutomationProcess.MoDomain.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DMLAutomationProcess.Infra.Services
{
    public class UserService : IUserService
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<ApplicationRole> _roleManager;
        private readonly ApplicationDbContext _context;

        public UserService(UserManager<ApplicationUser> userManager, RoleManager<ApplicationRole> roleManager, ApplicationDbContext context)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _context = context;
        }

        public async Task<List<ApplicationUsersListViewModel>> GetAllUsersAsync()
        {
            var users = await _userManager.Users.ToListAsync();
            var roles = await _roleManager.Roles.ToListAsync();
            var roleNamesToIds = roles.ToDictionary(r => r.Name, r => r.Id);
            var model = new List<ApplicationUsersListViewModel>();

            foreach (var user in users)
            {
                var roleNames = await _userManager.GetRolesAsync(user);
                var roleName = roleNames.FirstOrDefault(r => roleNamesToIds.ContainsKey(r)) ?? "Unknown";

                model.Add(new ApplicationUsersListViewModel
                {
                    Name = user.Name,
                    Id = user.Id,
                    UserName = user.UserName,
                    Email = user.Email,
                    RoleName = roleName
                });
            }

            return model;
        }

        public async Task<ApplicationUser> GetUserByIdAsync(string id)
        {
            return await _userManager.FindByIdAsync(id);
        }

        public async Task<IdentityResult> CreateUserAsync(RegisterViewModel model)
        {
            var user = new ApplicationUser
            {
                Name = model.UserName,
                UserName = model.UserName,
                Email = model.Email
            };

            var result = await _userManager.CreateAsync(user, model.Password);
            if (result.Succeeded)
            {
                var applicationRole = await _roleManager.FindByIdAsync(model.RoleId);
                if (applicationRole != null)
                {
                    await _userManager.AddToRoleAsync(user, applicationRole.Name);
                }
            }

            return result;
        }

        public async Task<IdentityResult> UpdateUserAsync(EditUserViewModel model)
        {
            var user = await _userManager.FindByIdAsync(model.Id);
            if (user != null)
            {
                user.Name = model.UserName;
                user.Email = model.Email;

                var result = await _userManager.UpdateAsync(user);
                if (result.Succeeded)
                {
                    var existingRoles = await _userManager.GetRolesAsync(user);
                    foreach (var role in existingRoles)
                    {
                        await _userManager.RemoveFromRoleAsync(user, role);
                    }

                    var applicationRole = await _roleManager.FindByIdAsync(model.RoleId);
                    if (applicationRole != null)
                    {
                        await _userManager.AddToRoleAsync(user, applicationRole.Name);
                    }
                }

                return result;
            }

            return IdentityResult.Failed(new IdentityError { Description = "User not found." });
        }

        public async Task<IdentityResult> DeleteUserAsync(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user != null)
            {
                return await _userManager.DeleteAsync(user);
            }

            return IdentityResult.Failed(new IdentityError { Description = "User not found." });
        }

        public async Task<List<SelectListItem>> GetRolesAsync()
        {
            return await _roleManager.Roles.Select(r => new SelectListItem
            {
                Text = r.Name,
                Value = r.Id
            }).ToListAsync();
        }

        public async Task<string?> GetRolesByIdAsync(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user != null)
                return (await _userManager.GetRolesAsync(user)).FirstOrDefault();
            return null;
        }

        public async Task<List<string>> GetVillageNamesAsync(string term)
        {
            return await _context.Villages
                .Where(v => v.Name.ToLower().StartsWith(term.ToLower()))
                .Select(v => v.Name)
                .ToListAsync();
        }

        public async Task<List<GenderDto>> GetGenderByPrefixAsync(int prefixID)
        {
            return await _context.Prefixes
                .Where(v => v.PrefixID == prefixID)
                .Include(v => v.Gender)
                .Select(v => new GenderDto
                {
                    genderID = v.GenderID.Value,
                    genderName = v.Gender.Name
                })
                .ToListAsync();
        }

        public async Task<List<MandalDto>> GetMandalByVillageNameAsync(string villageName)
        {
            return await _context.Villages
                .Where(v => v.Name == villageName)
                .Include(v => v.Mandal)
                .ThenInclude(m => m.District)
                .ThenInclude(d => d.State)
                .Select(v => new MandalDto
                {
                    villageID = v.VillageID,
                    pinCode = v.Pincode.ToString(),
                    mandalName = v.Mandal.Name,
                    districtName = v.Mandal.District.Name,
                    stateName = v.Mandal.District.State.Name
                })
                .ToListAsync();
        }
        public async Task<string> GetFormattedUnitNamesAsync(int departmentID)
        {
            // Get the current day name
            var currentDayName = DateTime.Now.ToString("dddd").Substring(0, 3).ToUpper();
            //currentDayName = "TUE";
            var unitNames = await _context.DepartmentDayUnitMappings
                .Where(mapping =>
                    mapping.Departments.DepartmentID == departmentID &&
                    mapping.DaywiseSchedules.Name.Substring(0, 3).ToUpper() == currentDayName
                )
                .OrderBy(mapping => mapping.Units.Name)
                //.Select(mapping => mapping.Units.Name)
                .Select(mapping => new { UnitName = mapping.Units.Name, UnitID = mapping.Units.UnitID })
                .ToListAsync();

            var formattedUnitNames = unitNames.Any()
                ? "UNIT -" + string.Join(" & ", unitNames.Select((unit, index) =>
                    index == 0 ? unit.UnitName.Replace("UNIT -", "").Trim() : unit.UnitName.Replace("UNIT -", "").Trim()))
                : string.Empty;

            // Format Unit IDs: Just join them with commas
            var formattedUnitIds = unitNames.Any()
                ? string.Join(",", unitNames.Select(unit => unit.UnitID.ToString()))
                : string.Empty;

            var formattedUnitNamesAndUnitIds = formattedUnitNames + "^" + formattedUnitIds;

            return formattedUnitNamesAndUnitIds;
        }

        public async Task<string> GetNewUHIDAsync()
        {
            // Get the current date in YYYYMMDD format
            var currentDatePart = DateTime.Now.ToString("yyyyMMdd");

            // Get the maximum UHID for the current date
            var maxUHID = await _context.Patients
                .Where(p => p.UHID.StartsWith(currentDatePart))
                .OrderByDescending(p => p.UHID)
                .Select(p => p.UHID)
                .FirstOrDefaultAsync();

            // Handle the case when no UHID exists for today
            if (maxUHID == null)
            {
                return currentDatePart + "0001";
            }

            // Extract the numeric part from maxUHID
            var numericPart = maxUHID.Substring(8); // XXXX

            if (!int.TryParse(numericPart, out var currentMaxNumber))
            {
                throw new InvalidOperationException("UHID format is not as expected.");
            }

            // Increment the numeric part for today's UHID
            var nextNumber = currentMaxNumber + 1;
            var nextUHIDNumericPart = nextNumber.ToString("D4"); // Pad with leading zeros

            return currentDatePart + nextUHIDNumericPart;
        }

        public async Task<string> GetNewOPIDAsync()
        {
            // Get the current date in "yyMMdd" format
            var currentDatePart = DateTime.Now.ToString("yyMMdd");

            // Get the maximum OPID for the current date
            var maxOPID = await _context.OPRegistrations
                .Where(p => p.OPID.StartsWith("OP." + currentDatePart))
                .OrderByDescending(p => p.OPID)
                .Select(p => p.OPID)
                .FirstOrDefaultAsync();

            // Handle the case when no OPID exists for today
            if (maxOPID == null)
            {
                // Generate OPID for the current day, starting with "0001"
                return "OP." + currentDatePart + "0001";
            }

            // Ensure that the OPID format is as expected
            if (!maxOPID.StartsWith("OP.") || maxOPID.Length != 13)
            {
                throw new InvalidOperationException("OPID format is not as expected.");
            }

            // Extract the numeric part from maxOPID
            var numericPartString = maxOPID.Substring(9); // Extract "0001"

            // Try parsing the numeric part to an integer
            if (!int.TryParse(numericPartString, out var numericPart))
            {
                throw new InvalidOperationException("Numeric part of OPID is not as expected.");
            }

            // Increment the numeric value by 1
            numericPart += 1;

            // Convert the incremented number to a string with leading zeros (assuming 4-digit format)
            var incrementedNumericPartString = numericPart.ToString("D4"); // Pads with leading zeros

            // Generate the new OPID with today's date and incremented number
            var nextOPID = "OP." + currentDatePart + incrementedNumericPartString;

            return nextOPID;
        }

        public async Task<List<SelectListItem>> GetDoctorsByUnitAsync(string unitIds)
        {
            // Split unitIds into a list of integers
            var unitIdList = unitIds.Split(',')
                                     .Select(id => int.Parse(id))
                                     .ToList();

            // Query the database
            var result = await _context.UnitDoctorMappings
                .Where(v => unitIdList.Contains(v.UnitID))  // Use the list of unit IDs for filtering
                .Include(v => v.Doctors)
                .Select(v => new SelectListItem
                {
                    Text = v.Doctors.Name,                // Set Text as the doctor's name
                    Value = v.DoctorID.ToString()         // Set Value as the doctor's ID
                }).OrderBy(a => a.Text)
                .ToListAsync();

            // Return the result as JSON
            return result;
        }

        public async Task<string> GetOpIdListAsync(int numIDs)
        {
            // Define the output parameter
            var outputParameter = new SqlParameter
            {
                ParameterName = "@result",
                SqlDbType = System.Data.SqlDbType.NVarChar,
                Size = -1, // Max size for NVARCHAR
                Direction = System.Data.ParameterDirection.Output
            };

            // Execute the stored procedure
            await _context.Database.ExecuteSqlRawAsync("EXEC GenerateOPIDList @numIDs, @result OUTPUT",
                new SqlParameter("@numIDs", numIDs),
                outputParameter);

            // Retrieve the output value
            return (string)outputParameter.Value;
        }

        public async Task<OpRegistrationViewModel> BindRevisitDetailsByUHID(string UHID)
        {
            if (!string.IsNullOrEmpty(UHID))
            {
                // Create a new instance of the ViewModel
                var opRegistrationViewModel = new OpRegistrationViewModel();

                // Query the Patient by UHID
                var patient = await _context.Patients
                    .Where(x => x.UHID == UHID)
                    .FirstOrDefaultAsync();

                // Query the PatientAddress and OPRegistration for the found patient
                var patientAddress = await _context.PatientAddresses
                    .Where(x => x.PatientID == patient.ID)
                    .FirstOrDefaultAsync();

                var opRegistration = await _context.OPRegistrations
                    .Where(x => x.PatientID == patient.ID).OrderByDescending(a => a.ID)
                    .Include(a => a.Speciality)
                    .Include(a => a.Department)
                    .FirstOrDefaultAsync();

                // Assign the retrieved data to the ViewModel
                opRegistrationViewModel.Patients = patient;
                opRegistrationViewModel.PatientAddresss = patientAddress;
                opRegistration.OPID = await GetNewOPIDAsync();
                opRegistration.VisitDate = DateTime.Now;
                opRegistrationViewModel.OPRegistrations = opRegistration;

                return opRegistrationViewModel;
            }
            else
            {
                return null;
            }
        }

        public async Task<NewPatientsModel> GetNewPatientsAsync()
        {
            return new NewPatientsModel { VisitDate = DateTime.Now };
        }

        public async Task<bool> SaveDummyAsync(NewPatientsModel model)
        {
            var (departments, genders) = await GetDepartmentIdsAsync(model);
            return await SaveDummyAsync(departments, genders, model.VisitDate);
        }

        public async Task<(List<int> departments, List<string> genders)> GetDepartmentIdsAsync(NewPatientsModel model)
        {
            var departments = new List<int>();
            var genders = new List<string>();
            // Implement your logic to get department IDs and genders
            return (departments, genders);
        }

        public async Task<bool> SendNewOpDummy(DateTime visitDate, int departmentId, int unitId, int doctorId, string gender)
        {
            string UHID = await GetNewUHIDAsync();
            string OPID = await GetNewOPIDAsync();
            if (!string.IsNullOrEmpty(UHID) && !string.IsNullOrEmpty(OPID))
            {
                var result = await _context.Database.ExecuteSqlRawAsync(
                    "EXEC NewDPatientOPEntry @UHID = {0}, @OPID = {1}, @VisitDate = {2}, @DepartmentID = {3}, @UnitID = {4}, @DoctorID = {5}, @Gender = {6}",
                    UHID, OPID, visitDate, departmentId, unitId, doctorId, gender
                );
                return result > 0;
            }
            return false;
        }

        public async Task<bool> SendRevisitOpDummy(string UHID, DateTime visitDate, int departmentId, int unitId, string gender)
        {
            string OPID = await GetNewOPIDAsync();
            if (!string.IsNullOrEmpty(UHID) && !string.IsNullOrEmpty(OPID))
            {
                var result = await _context.Database.ExecuteSqlRawAsync(
                    "EXEC RevisitDPatientOPEntry @UHID = {0}, @OPID = {1}, @VisitDate = {2}, @DepartmentID = {3}, @UnitID = {4}, @Gender = {5}",
                    UHID, OPID, visitDate, departmentId, unitId, gender
                );
                return result > 0;
            }
            return false;
        }

        public async Task<List<SelectListItem>> GetDepartmentsAsync()
        {
            return await _context.Departments.Select(d => new SelectListItem
            {
                Text = d.Name,
                Value = d.DepartmentID.ToString()
            }).ToListAsync();
        }

        public async Task<List<SelectListItem>> GetGendersAsync()
        {
            return await _context.Genders.Select(g => new SelectListItem
            {
                Text = g.Name,
                Value = g.GenderID.ToString()
            }).ToListAsync();
        }

        public async Task<List<BindRevisitOpDummys>> GetOpDetailsByDateAsync(int departmentID, string unitIDs, int genderID, DateTime fromDate, DateTime toDate, int noofEntries)
        {
            var bindRevisitOpDummys = await _context.OPRegistrations
                .Where(a => a.DepartmentID == departmentID
                         && a.Patient.GenderID == genderID
                         && a.VisitDate >= fromDate
                         && a.VisitDate <= toDate)
                .GroupBy(a => new { a.PatientID, a.DepartmentID, a.Patient.GenderID })
                .Select(g => new BindRevisitOpDummys
                {
                    SNo = g.FirstOrDefault().ID,
                    UHID = g.FirstOrDefault().Patient.UHID,
                    DepartmentID = departmentID,
                    //UnitID = unitID,
                    DepartmentName = g.FirstOrDefault().Department.Name,
                    GenderName = g.FirstOrDefault().Patient.Gender.Name,
                    Total = g.Count()
                })
                .OrderBy(a => a.SNo)
                .Take(noofEntries)
                .ToListAsync();

            return bindRevisitOpDummys;
        }

        public async Task<bool> SaveDummyAsync(List<int> departments, List<string> genders, DateTime visitDate)
        {
            Random random = new Random();

            foreach (int departmentId in departments)
            {
                // Get the formatted unit names and parse the unit IDs
                var res = await GetFormattedUnitNamesAsync(departmentId);
                string unitIds = res.Split("^")[1];
                var unitIdList = unitIds.Split(',').Select(int.Parse).ToList();

                // Get doctor IDs associated with these units
                var doctorIdList = await _context.UnitDoctorMappings
                    .Where(v => unitIdList.Contains(v.UnitID))
                    .Select(v => v.DoctorID)
                    .ToListAsync();

                // If there are units and doctors, pick random ones
                if (unitIdList.Any() && doctorIdList.Any())
                {
                    int randomUnitId = unitIdList[random.Next(unitIdList.Count)];
                    int randomDoctorId = doctorIdList[random.Next(doctorIdList.Count)];

                    // Send to stored procedure with the random unitId and doctorId
                    await SendNewOpDummy(visitDate, departmentId, randomUnitId, randomDoctorId, genders[departments.IndexOf(departmentId)]);
                }
            }
            return true;
        }

        public async Task<SelectListItem> GetUnitNames(int departmentID)
        {
            // Get the current day name
            var currentDayName = DateTime.Now.ToString("dddd").Substring(0, 3).ToUpper();

            // Query the database
            var unitNames = await _context.DepartmentDayUnitMappings
                .Where(mapping =>
                    mapping.Departments.DepartmentID == departmentID &&
                    mapping.DaywiseSchedules.Name.Substring(0, 3).ToUpper() == currentDayName
                )
                .OrderBy(mapping => mapping.Units.Name)
                .Select(mapping => new
                {
                    UnitName = mapping.Units.Name,
                    UnitID = mapping.Units.UnitID
                })
                .ToListAsync();

            // Concatenate unit names and IDs
            var concatenatedNames = string.Join(" & ", unitNames.Select(u => u.UnitName));
            var concatenatedValues = string.Join(", ", unitNames.Select(u => u.UnitID.ToString()));

            // Create the response
            var response = new SelectListItem
            {
                Text = concatenatedNames,
                Value = concatenatedValues
            };

            // Return JSON response
            return response;
        }

        public async Task<List<SelectListItem>> GetUnitsAsync(int departmentId, string dayName)
        {
            List<SelectListItem> selectListItems = new List<SelectListItem>();

            var units = await _context.DepartmentDayUnitMappings
                .Where(mapping =>
                    mapping.Departments.DepartmentID == departmentId &&
                    mapping.DaywiseSchedules.Name.Substring(0, 3).ToUpper() == dayName
                )
                .OrderBy(mapping => mapping.Units.Name)
                .Select(mapping => new
                {
                    UnitName = mapping.Units.Name,
                    UnitID = mapping.Units.UnitID
                })
                .ToListAsync();

            // Check if there are any units
            if (!units.Any()) return selectListItems;

            var firstUnit = units.First();
            var remainingUnits = units.Skip(1).ToList();

            // Create the formatted output
            var formattedRemainingUnits = string.Join(" & ", remainingUnits.Select(u => u.UnitName.Substring(6))); // Adjust as needed
            var unitNames = remainingUnits.Count > 0 ? $"{firstUnit.UnitName} & {formattedRemainingUnits}" : firstUnit.UnitName;

            // Get the concatenated unit IDs
            var unitIds = string.Join(",", units.Select(u => u.UnitID));

            // Create the response
            var response = new SelectListItem
            {
                Text = unitNames,
                Value = unitIds
            };
            selectListItems.Add(response);

            return selectListItems;
        }

        public async Task<bool> RegisterAsync(OpRegistrationViewModel viewModel, string userName)
        {
            try
            {
                if (viewModel.Patients != null)
                {
                    viewModel.Patients.MiddleName = await Helper.GetCurrentUserId(_context, userName);
                    _context.Patients.Add(viewModel.Patients);
                    await _context.SaveChangesAsync();
                }

                if (viewModel.PatientAddresss != null) // Fixed property name
                {
                    viewModel.PatientAddresss.PatientID = viewModel.Patients?.ID ?? 0; // Assuming PatientID is required for PatientAddress
                    _context.PatientAddresses.Add(viewModel.PatientAddresss);
                    await _context.SaveChangesAsync();
                }

                if (viewModel.OPRegistrations != null)
                {
                    var parameters = new[]
                    {
                    new SqlParameter("@PatientID", viewModel.Patients?.ID),
                    new SqlParameter("@OPID", viewModel.OPRegistrations.OPID),
                    new SqlParameter("@VisitDate", viewModel.OPRegistrations.VisitDate),
                    new SqlParameter("@IsMlcCase", viewModel.OPRegistrations.IsMlcCase.HasValue ? (object)viewModel.OPRegistrations.IsMlcCase.Value : DBNull.Value),
                    new SqlParameter("@IsEmergencyCase", viewModel.OPRegistrations.IsEmergencyCase.HasValue ? (object)viewModel.OPRegistrations.IsEmergencyCase.Value : DBNull.Value),
                    new SqlParameter("@DepartmentID", viewModel.OPRegistrations.DepartmentID.HasValue ? (object)viewModel.OPRegistrations.DepartmentID.Value : DBNull.Value),
                    new SqlParameter("@DoctorID", viewModel.OPRegistrations.DoctorID.HasValue ? (object)viewModel.OPRegistrations.DoctorID.Value : DBNull.Value),
                    new SqlParameter("@SpecialityID", viewModel.OPRegistrations.SpecialityID.HasValue ? (object)viewModel.OPRegistrations.SpecialityID.Value : DBNull.Value),
                    new SqlParameter("@FeeTypeID", viewModel.OPRegistrations.FeeTypeID.HasValue ? (object)viewModel.OPRegistrations.FeeTypeID.Value : DBNull.Value),
                    new SqlParameter("@ReferredBy", viewModel.OPRegistrations.ReferredBy),
                    new SqlParameter("@CreatedDate", viewModel.OPRegistrations.CreatedDate.HasValue ? (object)viewModel.OPRegistrations.CreatedDate.Value : DBNull.Value),
                    new SqlParameter("@IsActive", viewModel.OPRegistrations.IsActive),
                    new SqlParameter("@IsCamp", false),
                    new SqlParameter("@IsType", false)
                };

                    await _context.Database.ExecuteSqlRawAsync(
                        "EXEC InsertOPRegistration @PatientID, @OPID, @VisitDate, @IsMlcCase, @IsEmergencyCase, @DepartmentID, @DoctorID, @SpecialityID, @FeeTypeID, @ReferredBy, @CreatedDate, @IsActive, @IsCamp, @IsType",
                        parameters);
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public async Task<bool> Revisit_RegistrationAsync(OpRegistrationViewModel viewModel, string userName)
        {
            try
            {
                if (viewModel.Patients?.ID != 0)
                {
                    if (viewModel.OPRegistrations != null)
                    {
                        // Create parameters for the stored procedure
                        var parameters = new[]
                        {
                new SqlParameter("@PatientID", viewModel.Patients?.ID),
                new SqlParameter("@OPID", viewModel.OPRegistrations.OPID),
                new SqlParameter("@VisitDate", viewModel.OPRegistrations.VisitDate),
                new SqlParameter("@IsMlcCase", viewModel.OPRegistrations.IsMlcCase.HasValue ? (object)viewModel.OPRegistrations.IsMlcCase.Value : DBNull.Value),
                new SqlParameter("@IsEmergencyCase", viewModel.OPRegistrations.IsEmergencyCase.HasValue ? (object)viewModel.OPRegistrations.IsEmergencyCase.Value : DBNull.Value),
                new SqlParameter("@DepartmentID", viewModel.OPRegistrations.DepartmentID.HasValue ? (object)viewModel.OPRegistrations.DepartmentID.Value : DBNull.Value),
                new SqlParameter("@DoctorID", viewModel.OPRegistrations.DoctorID.HasValue ? (object)viewModel.OPRegistrations.DoctorID.Value : DBNull.Value),
                new SqlParameter("@SpecialityID", viewModel.OPRegistrations.SpecialityID.HasValue ? (object)viewModel.OPRegistrations.SpecialityID.Value : DBNull.Value),
                new SqlParameter("@FeeTypeID", viewModel.OPRegistrations.FeeTypeID.HasValue ? (object)viewModel.OPRegistrations.FeeTypeID.Value : DBNull.Value),
                new SqlParameter("@ReferredBy", viewModel.OPRegistrations.ReferredBy),
                new SqlParameter("@CreatedDate", viewModel.OPRegistrations.CreatedDate.HasValue ? (object)viewModel.OPRegistrations.CreatedDate.Value : DBNull.Value),
                new SqlParameter("@IsActive", viewModel.OPRegistrations.IsActive),
                new SqlParameter("@IsCamp", false),
                new SqlParameter("@IsType", true)
                        };

                        await _context.Database.ExecuteSqlRawAsync(
                           "EXEC InsertOPRegistration @PatientID, @OPID, @VisitDate, @IsMlcCase, @IsEmergencyCase, @DepartmentID, @DoctorID, @SpecialityID, @FeeTypeID, @ReferredBy, @CreatedDate, @IsActive, @IsCamp,@IsType",
                           parameters);
                    }

                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
