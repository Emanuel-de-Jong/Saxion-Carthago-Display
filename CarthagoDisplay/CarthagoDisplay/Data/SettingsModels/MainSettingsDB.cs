using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data.SettingsModels
{
    public class MainSettingsDB
    {
        [Key] public int Id { get; set; }

        public int SlideTime { get; set; }
    }
}