using System;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using ProyectoServicioSocial.Data;

[assembly: HostingStartup(typeof(ProyectoServicioSocial.Areas.Identity.IdentityHostingStartup))]
namespace ProyectoServicioSocial.Areas.Identity
{
    public class IdentityHostingStartup : IHostingStartup
    {
        public void Configure(IWebHostBuilder builder)
        {
            //builder.ConfigureServices((context, services) => {
            //    services.AddDbContext<ServicioSocialContext>(options =>
            //        options.UseSqlServer(
            //            context.Configuration.GetConnectionString("UsersContextConnection")));

            //    //services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            //    //  .AddEntityFrameworkStores<UsersContext>();
            //    services.AddDefaultIdentity<IdentityUser>().AddRoles<IdentityRole>().AddEntityFrameworkStores<ServicioSocialContext>();


            }
        }
    }
