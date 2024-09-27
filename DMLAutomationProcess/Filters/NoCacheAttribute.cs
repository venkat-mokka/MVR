using Microsoft.AspNetCore.Mvc.Filters;

namespace DMLAutomationProcess.Web.Filters
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public sealed class NoCacheAttribute : ActionFilterAttribute
    {
        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {
            filterContext.HttpContext.Response.GetTypedHeaders().CacheControl =
                    new Microsoft.Net.Http.Headers.CacheControlHeaderValue()
                    {
                        NoStore = true,
                        NoCache = true,
                    };

            base.OnResultExecuting(filterContext);
        }
    }
}
