using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data
{
    public class Slide
    {
        public Slide()
        {
            SlideComponents = new HashSet<SlideComponent>();
        }

        [Key] public int Id { get; set; }

        [Required] public int Index { get; set; }

        [Required] public string Title { get; set; }

        public string PrimaryColor { get; set; }
        public string SecondaryColor { get; set; }
        public string Background { get; set; }
        public string Grid { get; set; }

        [Required] public bool Disabled { get; set; }

        public ICollection<SlideComponent> SlideComponents { get; set; }
    }
}