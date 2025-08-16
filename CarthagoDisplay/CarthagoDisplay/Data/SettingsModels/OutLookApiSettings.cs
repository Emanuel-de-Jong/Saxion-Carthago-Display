using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data.SettingsModels
{
    public class OutLookApiSettings
    {
        [Key] public int Id { get; set; }

        public string Tenant { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string RedirectURL { get; set; }
        public bool Authorized { get; set; }

        public string AdminEmail { get; set; }
    }
}