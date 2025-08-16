using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data.SettingsModels
{
    public class SpotifyApiSettings
    {
        [Key] public int Id { get; set; }

        public string RedirectUrl { get; set; }
        public string PlaylistName { get; set; }
        public string ClientID { get; set; }
        public string ClientSecret { get; set; }
    }
}