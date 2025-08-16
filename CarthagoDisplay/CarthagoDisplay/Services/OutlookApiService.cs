using CarthagoDisplay.Data;
using CarthagoDisplay.Data.APIResponseModels;
using CarthagoDisplay.Data.SettingsModels;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;

namespace CarthagoDisplay.Services
{
    public static class OutlookApiService
    {
        /// <summary>
        ///     Get the API acces token
        /// </summary>
        /// <param name="outLookApiSettings">Settings for the Outlook API</param>
        /// <returns></returns>
        public static OutlookAPITokenResponse GetAccesToken(OutLookApiSettings outLookApiSettings)
        {
            if (outLookApiSettings != null)
                //look if all the needed fields are filled in
                if (!string.IsNullOrWhiteSpace(outLookApiSettings.Tenant) &&
                    !string.IsNullOrWhiteSpace(outLookApiSettings.ClientId) &&
                    !string.IsNullOrWhiteSpace(outLookApiSettings.ClientSecret))
                {
                    //Reqeust a Acces token to look if the API has adminconsent
                    var client = new RestClient("https://login.microsoftonline.com/" + outLookApiSettings.Tenant +
                                                "/oauth2/v2.0/token")
                    {
                        Timeout = -1
                    };
                    var request = new RestRequest(Method.POST);
                    request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
                    request.AddParameter("client_id", outLookApiSettings.ClientId);
                    request.AddParameter("scope", "https://graph.microsoft.com/.default");
                    request.AddParameter("client_secret", outLookApiSettings.ClientSecret);
                    request.AddParameter("grant_type", "client_credentials");
                    var response = client.Execute(request);


                    //convert to response to a opbject
                    var responseObject = JsonConvert.DeserializeObject<OutlookAPITokenResponse>(response.Content);
                    responseObject.StatusCode = response.StatusCode;

                    return responseObject;
                }

            return new OutlookAPITokenResponse { access_token = null, StatusCode = HttpStatusCode.BadRequest };
        }


        /// <summary>
        ///     Look if the API has adminconsent
        /// </summary>
        /// <param name="outLookApiSettings">Settings for the Outlook API</param>
        /// <returns></returns>
        public static bool IsAuthorized(OutLookApiSettings outLookApiSettings)
        {
            if (outLookApiSettings != null)
            {
                var response = GetAccesToken(outLookApiSettings);

                //If status code is not OK return false
                if (response.StatusCode == HttpStatusCode.OK)
                {
                    var client = new RestClient("https://graph.microsoft.com/beta/users/" +
                                                outLookApiSettings.AdminEmail + "/findRooms")
                    {
                        Timeout = -1
                    };
                    var request = new RestRequest(Method.GET);
                    request.AddHeader("Authorization", "Bearer " + response.access_token);
                    var r = client.Execute(request);
                    if (r.StatusCode == HttpStatusCode.OK) return true;
                }
            }

            return false;
        }


        /// <summary>
        ///     Get the list of rooms
        /// </summary>
        /// <param name="outLookApiSettings">Settings for the Outlook API</param>
        /// <returns></returns>
        public static List<Room> GetRooms(OutLookApiSettings outLookApiSettings)
        {
            var accesToken = GetAccesToken(outLookApiSettings);

            //If status code is not OK return false
            if (accesToken.StatusCode == HttpStatusCode.OK)
            {
                var client = new RestClient("https://graph.microsoft.com/beta/users/" + outLookApiSettings.AdminEmail +
                                            "/findRooms")
                {
                    Timeout = -1
                };
                var request = new RestRequest(Method.GET);
                request.AddHeader("Authorization", "Bearer " + accesToken.access_token);
                var response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.OK)
                    return JsonConvert.DeserializeObject<RoomsRoot>(response.Content).value;
                return new List<Room>();
            }

            return new List<Room>();
        }


        public static List<Room> GetRoomAvailabilityView(List<Room> rooms, OutLookApiSettings outLookApiSettings)
        {
            var accesToken = GetAccesToken(outLookApiSettings);
            if (accesToken.StatusCode == HttpStatusCode.OK)
            {
                var startTime = DateTime.Now.ToString("yyyy-MM-dd") + "T08:00:00";
                var endTime = DateTime.Now.ToString("yyyy-MM-dd") + "T17:00:00";


                var schedules = "";
                foreach (var room in rooms) schedules += "\"" + room.Address + "\",";
                var client = new RestClient("https://graph.microsoft.com/v1.0/users/" + outLookApiSettings.AdminEmail +
                                            "/calendar/getSchedule")
                {
                    Timeout = -1
                };
                var request = new RestRequest(Method.POST);
                request.AddHeader("Authorization", "Bearer " + accesToken.access_token);
                request.AddParameter("application/json",
                    "{\r\n    \"schedules\": [" + schedules + "],\r\n    \"startTime\": {\r\n        \"dateTime\": \"" +
                    startTime +
                    "\",\r\n        \"timeZone\": \"Europe/Berlin\"\r\n    },\r\n    \"endTime\": {\r\n        \"dateTime\": \"" +
                    endTime + "\",\r\n        \"timeZone\": \"Europe/Berlin\"\r\n    }\r\n}",
                    ParameterType.RequestBody);
                var response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.OK)
                {
                    var availabilityResponses =
                        JsonConvert.DeserializeObject<AvailabilityResponseRoot>(response.Content).value;
                    foreach (var availabilityResponse in availabilityResponses)
                        rooms.Single(t => t.Address == availabilityResponse.ScheduleId).AvailabilityView =
                            availabilityResponse.AvailabilityView;
                    return rooms;
                }
            }

            return new List<Room>();
        }


        /// <summary>
        ///     Returns the Id of the given Calander name
        /// </summary>
        /// <param name="Email">Email of the Calander owner</param>
        /// <param name="outLookApiSettings">Settings for the Outlook Api</param>
        /// <returns></returns>
        public static string GetCalanderId(string CalanderName, string Email, OutLookApiSettings outLookApiSettings)
        {
            var accesToken = GetAccesToken(outLookApiSettings);
            if (accesToken.StatusCode == HttpStatusCode.OK)
            {
                var client = new RestClient("https://graph.microsoft.com/v1.0/users/" + Email + "/calendars")
 {
     Timeout = -1
 };
                var request = new RestRequest(Method.GET);
                request.AddHeader("Authorization", "Bearer " + accesToken.access_token);
                var response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.OK)
                {
                    var apiCalandersResponse =
                        JsonConvert.DeserializeObject<ApiCalandersResponseRoot>(response.Content).Value;

                    var calander = apiCalandersResponse.Find(t => t.Name == CalanderName);

                    if (calander != null) return calander.Id;
                }
            }

            return null;
        }

        /// <summary>
        ///     Returns the Id of the given Calander name
        /// </summary>
        /// <param name="outLookApiSettings">Settings for the Outlook API</param>
        /// <returns></returns>
        public static List<Event> GetEvents(OutlookEventsSettings outlookEventsSettings,
            OutLookApiSettings outLookApiSettings)
        {
            var accesToken = GetAccesToken(outLookApiSettings);
            if (accesToken.StatusCode != HttpStatusCode.OK) return null;
            if (outlookEventsSettings == null) return null;
            var newEvents = new List<Event>();
            var client = new RestClient("https://graph.microsoft.com/v1.0/users/" +
                                        outlookEventsSettings.calanderOwnerEmail + "/calendars/" +
                                        outlookEventsSettings.calanderID + "/events")
            {
                Timeout = -1
            };
            var request = new RestRequest(Method.GET);
            request.AddHeader("Authorization", "Bearer " + accesToken.access_token);
            var response = client.Execute(request);

            if (response.StatusCode != HttpStatusCode.OK) return null;
            var events = JsonConvert.DeserializeObject<ApiEventsResponseRoot>(response.Content).Value;

            foreach (var eventItem in events)
                if (!eventItem.IsCancelled)
                    if (ISOWeek.GetWeekOfYear(eventItem.start.dateTime) ==
                        ISOWeek.GetWeekOfYear(DateTime.Now))
                        if (eventItem.start.dateTime.Date >= DateTime.Now.Date)
                        {
                            var ownEmailDomain = outlookEventsSettings.calanderOwnerEmail.Split("@")[1];
                            var isGreeting = eventItem.attendees.Any(attendee => !attendee.emailAddress.address.Contains(ownEmailDomain));

                            var newEvent = new Event
                            {
                                End = eventItem.end.dateTime.ToLocalTime(),
                                Start = eventItem.start.dateTime.ToLocalTime(),
                                Organizer = eventItem.organizer.emailAddress.name,
                                Name = eventItem.Subject,
                                Id = eventItem.Id,
                                IsGreeting = isGreeting,
                                IsBorrel = !string.IsNullOrEmpty(outlookEventsSettings.BorrelEventName) && eventItem.Subject.Contains(outlookEventsSettings.BorrelEventName)
                            };

                            newEvents.Add(newEvent);
                        }

            return newEvents;

        }
    }
}