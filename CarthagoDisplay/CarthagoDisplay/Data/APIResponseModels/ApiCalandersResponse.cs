using System.Collections.Generic;

namespace CarthagoDisplay.Data.APIResponseModels
{
    public class ApiCalandersResponseRoot
    {
        public List<ApiCalandersResponse> Value { get; set; }
    }

    public class ApiCalandersResponse
    {
        public string Id { get; set; }
        public string Name { get; set; }
    }
}