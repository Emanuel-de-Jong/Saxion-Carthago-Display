using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarthagoDisplay.Data
{
    public class Room
    {
        public string Name { get; set; }

        [Key] public string Address { get; set; }

        public string AvailabilityView { get; set; }
    }

    public class RoomsRoot
    {
        public List<Room> value { get; set; }
    }

    public class AvailabilityResponse
    {
        public string AvailabilityView { get; set; }
        public string ScheduleId { get; set; }
    }

    public class AvailabilityResponseRoot
    {
        public List<AvailabilityResponse> value { get; set; }
    }
}