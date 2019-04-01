using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OpenIdConnect;
using Owin;

namespace ManualFullFramework.App_Start
{
    public partial class Startup
    {
        public void COnfigureAuth(IAppBuilder app)
        {
            app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);
            app.UseCookieAuthentication(new CookieAuthenticationOptions());
            app.UseOpenIdConnectAuthentication(
                new OpenIdConnectAuthenticationOptions
                {
                    ClientId = "4229dd83-7065-4a9f-b1e8-f2df7d25485a",
                    Authority = "https://login.microsoftonline.com/"
                });
        }
    }
}