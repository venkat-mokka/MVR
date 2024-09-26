using DMLAutomationProcess.Domain.Interfaces;
using DMLAutomationProcess.Infra.Services;
using DMLAutomationProcess.Web.Controllers;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
var appConfig = builder.Configuration;

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddDbContext<DMLAutomationProcess.Infra.Dbcontext.ApplicationDbContext>(options =>
             options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"), options => options.CommandTimeout(120)));

builder.Services.AddIdentity<DMLAutomationProcess.Domain.Entities.ApplicationUser, DMLAutomationProcess.Domain.Entities.ApplicationRole>()
    .AddEntityFrameworkStores<DMLAutomationProcess.Infra.Dbcontext.ApplicationDbContext>()
    .AddDefaultTokenProviders();

builder.Services.AddScoped<IRoleService, RoleService>();
builder.Services.AddScoped<IDataBindingService, DataBindingService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IAccountService, AccountService>();
builder.Services.AddScoped<IAdminService, AdminService>();

builder.Services.AddApplicationInsightsTelemetry(appConfig);

var app = builder.Build();

//// Configure the HTTP request pipeline.
//if (!app.Environment.IsDevelopment())
//{
//    app.UseExceptionHandler("/Home/Error");
//    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
//    app.UseHsts();
//}

app.UseStatusCodePages(async context =>
{
    HttpResponse response = context.HttpContext.Response;
    if (response.StatusCode == 404)
    {
        // Alternatively, redirect to a view:
        response.Redirect("/Home/AccessDenied");
    }
    else if (response.StatusCode == 501)
    {
        // Alternatively, redirect to a view:
         response.Redirect("/Home/Error");
    }
});

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Login}/{id?}");

app.Run();
