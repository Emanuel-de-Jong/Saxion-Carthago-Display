using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarthagoDisplay.Data
{
    public class SlideComponent
    {
        [Key] [Column(Order = 0)] public int SlideId { get; set; }

        [Key] [Column(Order = 1)] public int ComponentId { get; set; }

        public virtual Slide Slide { get; set; }
        public virtual Component Component { get; set; }

        public int GridPosition { get; set; }
    }
}