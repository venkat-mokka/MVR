using DMLAutomationProcess.Domain.Interfaces;
using DMLAutomationProcess.Infra.Services;
using DMLAutomationProcess.Web.Controllers;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
var appConfig = builder.Configuration;

// Add services to the container.
builder.Services.AddControllersWithViews(); // Adds support for MVC with views

// Configure the Entity Framework context to use SQL Server
builder.Services.AddDbContext<DMLAutomationProcess.Infra.Dbcontext.ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"), options => options.CommandTimeout(120)));

// Set up Identity framework with custom ApplicationUser and ApplicationRole
builder.Services.AddIdentity<DMLAutomationProcess.Domain.Entities.ApplicationUser, DMLAutomationProcess.Domain.Entities.ApplicationRole>()
    .AddEntityFrameworkStores<DMLAutomationProcess.Infra.Dbcontext.ApplicationDbContext>()
    .AddDefaultTokenProviders();

// Configure session settings using values from configuration
var sessionTimeOutMinutes = builder.Configuration.GetValue<int>("SessionSettings:IdleTimeoutMinutes");
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(sessionTimeOutMinutes); // Set idle timeout
    options.Cookie.SecurePolicy = CookieSecurePolicy.Always; // Always use secure cookies
    options.Cookie.HttpOnly = true; // Prevent client-side scripts from accessing the cookie
    options.Cookie.SameSite = SameSiteMode.Lax; // Control cookie sharing with cross-site requests
    options.Cookie.IsEssential = true; // Mark cookie as essential
});

// Register application services for dependency injection
builder.Services.AddScoped<IAccountService, AccountService>();
builder.Services.AddScoped<IRoleService, RoleService>();
builder.Services.AddScoped<IDataBindingService, DataBindingService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IAdminService, AdminService>();
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>(); // Provide access to HttpContext

// Configure cookie policy options
builder.Services.Configure<CookiePolicyOptions>(options =>
{
    options.CheckConsentNeeded = context => true; // Check if user consent is needed for non-essential cookies
    options.MinimumSameSitePolicy = SameSiteMode.None; // Set minimum SameSite policy
});

// Set up cookie authentication
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie();

// Register Application Insights for telemetry
builder.Services.AddApplicationInsightsTelemetry(appConfig);

// Configure forwarded headers for reverse proxy scenarios
builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.ForwardedHeaders = ForwardedHeaders.All; // Forward all headers
    options.ForwardedHostHeaderName = "X-Original-Host"; // Set original host header
    options.KnownNetworks.Clear(); // Clear known networks
    options.KnownProxies.Clear(); // Clear known proxies
});

var app = builder.Build();

// Middleware to handle status code pages
app.UseStatusCodePages(async context =>
{
    HttpResponse response = context.HttpContext.Response;
    if (response.StatusCode == 404)
    {
        // Redirect to an Access Denied page for 404 errors
        response.Redirect("/Home/AccessDenied");
    }
    else if (response.StatusCode == 501)
    {
        // Redirect to an Error page for 501 errors
        response.Redirect("/Home/Error");
    }
});

// Middleware pipeline configuration
app.UseHttpsRedirection(); // Redirect HTTP requests to HTTPS
app.UseStaticFiles(); // Serve static files
app.UseRouting(); // Enable routing

app.UseAuthorization(); // Enable authorization middleware
app.UseSession(); // Enable session support

// Configure default route for the application
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Login}/{id?}"); // Set default controller and action

// Run the application
app.Run();
