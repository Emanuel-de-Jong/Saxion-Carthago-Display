using System;
using System.Collections.Generic;

namespace CarthagoDisplay.Data.APIResponseModels
{
    public class ApiEventsResponseRoot
    {
        public List<ApiEventsResponse> Value { get; set; }
    }

    public class ApiEventsResponse
    {
        public string Id { get; set; }
        public bool IsCancelled { get; set; }
        public string Subject { get; set; }

        public Recipient organizer { get; set; }

        public EventDate start { get; set; }
        public EventDate end { get; set; }

        public List<Attendee> attendees { get; set; }
    }

    public class Recipient
    {
        public EmailAddress emailAddress { get; set; }
    }

    public class EventDate
    {
        public DateTime dateTime { get; set; }
    }

    public class Status
    {
        public string response { get; set; }
        public DateTime time { get; set; }
    }

    public class EmailAddress
    {
        public string name { get; set; }
        public string address { get; set; }
    }

    public class Attendee
    {
        public string type { get; set; }
        public Status status { get; set; }
        public EmailAddress emailAddress { get; set; }
    }
}