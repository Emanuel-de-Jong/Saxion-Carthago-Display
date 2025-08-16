using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using System.Runtime.InteropServices;

namespace CarthagoDisplay
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args)
        {
            return Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                    if (!RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                    {
                        // webBuilder.UseUrls("http://*:80");
                    }
                });
        }
    }
}