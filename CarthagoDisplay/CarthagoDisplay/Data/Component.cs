using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data
{
    public class Component
    {
        public Component()
        {
            SlideComponents = new HashSet<SlideComponent>();
        }

        [Key] public int Id { get; set; }

        [Required] public string Name { get; set; }

        public string? Html { get; set; }
        public string? Url { get; set; }
        public int NumberOfPosts { get; set; }

        public ComponentType ComponentType { get; set; }

        public ICollection<SlideComponent> SlideComponents { get; set; }
    }

    public enum ComponentType
    {
        Rooms,
        Events,
        RSSFeed,
        Klok,
        NewEmployee,
        Custom
    }
}