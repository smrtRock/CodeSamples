using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OpenIdConnect;
using Owin;

namespace ManualFullFramework
{
    public partial class Startup
    {
        public  void ConfigureAuth(IAppBuilder app)
        {
            app.SetDefaultSignInAsAuthenticationType(
                CookieAuthenticationDefaults.AuthenticationType);
            app.UseCookieAuthentication(new CookieAuthenticationOptions());
            app.UseOpenIdConnectAuthentication(
                new OpenIdConnectAuthenticationOptions
                {
                    ClientId = "dfd129bf-063d-4d8e-96c1-5c209c111682",
                    Authority = "https://login.microsoftonline.com/smrtrock.com"
                });
        }
    }
}