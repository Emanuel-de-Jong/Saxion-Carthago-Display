using System;
using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data.APIResponseModels
{
    public class SpotifyApiToken
    {
        [Key] public int Id { get; set; }

        public string Access_token { get; set; }
        public string Refresh_token { get; set; }
        public double Expires_in { get; set; }
        public DateTime ExpiresOn { get; set; }
    }
}