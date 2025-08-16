using System;
using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data
{
    public class Event
    {
        [Key] [MaxLength(155)] public string Id { get; set; }

        public string Name { get; set; }
        public string Organizer { get; set; }
        public bool IsBorrel { get; set; }
        public bool IsGreeting { get; set; }

        public DateTime Start { get; set; }
        public DateTime End { get; set; }
    }
}