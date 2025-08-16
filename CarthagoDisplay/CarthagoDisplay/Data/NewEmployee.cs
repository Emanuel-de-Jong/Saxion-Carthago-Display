using System;
using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data
{
    public class NewEmployee
    {
        [Key] public int Id { get; set; }

        [Required] public string Title { get; set; }

        [Required] public string Name { get; set; }

        [Required] public string Role { get; set; }

        public string Description { get; set; }

        public string Picture { get; set; }
        public DateTime InDienstPer { get; set; }
    }
}