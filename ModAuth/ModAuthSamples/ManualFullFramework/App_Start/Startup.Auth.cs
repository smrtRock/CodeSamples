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
                    ClientId = "94bd8f5b-0a79-445a-9ae2-dbfcf2d5c3dc",
                    Authority = "https://login.microsoftonline.com/smrtrock.com"
                });
        }
    }
}