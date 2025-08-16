using System.Net;

namespace CarthagoDisplay.Data.APIResponseModels
{
    public class OutlookAPITokenResponse
    {
        public string access_token { get; set; }
        public HttpStatusCode StatusCode { get; set; }
    }
}