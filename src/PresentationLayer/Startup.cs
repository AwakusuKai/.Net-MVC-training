using BusinessLogicLayer.Interfaces;
using BusinessLogicLayer.Services;
using DataAccessLayer.Entities;
using DataAccessLayer;
using DataAccessLayer.Interfaces;
using DataAccessLayer.Repositories;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using PresentationLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Project = DataAccessLayer.Entities.Project;
using DataAccessLayer.Configuration;
using Employee = DataAccessLayer.Entities.Employee;
using Task = DataAccessLayer.Entities.Task;
using Status = DataAccessLayer.Entities.Status;
using Microsoft.Extensions.Logging;

namespace PresentationLayer
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<AppConfig>(Configuration.GetSection("ConnectionStrings"));
            services.AddControllersWithViews();
            services.AddTransient<IProjectService, ProjectService>();
            services.AddScoped<IRepository<Project>, ProjectRepository>();
            services.AddTransient<IEmployeeService, EmployeeService>();
            services.AddScoped<IRepository<Employee>, EmployeeRepository>();
            services.AddTransient<ITaskService, TaskService>();
            services.AddScoped<IRepository<Task>, TaskRepository>();
            services.AddTransient<IStatusService, StatusService>();
            services.AddScoped<IRepository<Status>, StatusRepository>();


        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILogger<Startup> logger)
        {

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Project/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Project}/{action=Index}/{id?}");
            });

        }
    }
}
