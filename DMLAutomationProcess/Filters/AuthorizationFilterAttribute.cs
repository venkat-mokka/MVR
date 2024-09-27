using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;

namespace DMLAutomationProcess.Web.Filters
{
    public class AuthorizationFilterAttribute : Attribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            try
            {
                string currentUserRole = Convert.ToString(context.HttpContext.Session.GetString(Constants.UserName));
                if (string.IsNullOrEmpty(currentUserRole))
                {
                    context.Result = new RedirectToRouteResult
                    (
                    new RouteValueDictionary(new
                    {
                        action = "Error",
                        controller = "User"
                    }));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}