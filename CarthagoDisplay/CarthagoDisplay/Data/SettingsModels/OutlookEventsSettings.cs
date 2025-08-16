using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data.SettingsModels
{
    public class OutlookEventsSettings
    {
        [Key] public int Id { get; set; }

        public string calanderOwnerEmail { get; set; }
        public string calanderName { get; set; }

        public string BorrelEventName { get; set; }

        public string calanderID { get; set; }
    }
}