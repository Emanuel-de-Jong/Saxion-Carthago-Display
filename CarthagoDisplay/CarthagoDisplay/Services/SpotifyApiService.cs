using CarthagoDisplay.Data;
using CarthagoDisplay.Data.APIResponseModels;
using CarthagoDisplay.Data.SettingsModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Net;
using System.Text;

namespace CarthagoDisplay.Services
{
    public static class SpotifyApiService
    {
        /// <summary>
        /// Returns a token for the Spotify API
        /// </summary>
        /// <param name="code">The authentication code</param>
        /// <param name="spotifyApiSettings">The Spotify API Settings</param>
        /// <param name="options">A option object with the Database connection string</param>
        /// <param name="refresh">Ss Refresh token</param>
        /// <returns></returns>
        public static SpotifyApiToken GetAccesToken(string code, SpotifyApiSettings spotifyApiSettings,
            IOptions<ConnectionStrings> options, bool refresh)
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
            optionsBuilder.UseMySql(options.Value.DefaultConnection,
                ServerVersion.AutoDetect(options.Value.DefaultConnection));

            var context = new ApplicationDbContext(optionsBuilder.Options);


            if (spotifyApiSettings.ClientSecret != "" && spotifyApiSettings.ClientID != "" && code != null)
            {
                var client = new RestClient("https://accounts.spotify.com/api/token")
                {
                    Timeout = -1
                };
                var request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
                request.AddParameter("application/x-www-form-urlencoded",
                    refresh
                        ? $"grant_type=refresh_token&refresh_token={code}"
                        : $"grant_type=authorization_code&code={code}&redirect_uri={spotifyApiSettings.RedirectUrl}",
                    ParameterType.RequestBody);
                request.AddHeader("Authorization",
                    "Basic " + EncodeTo64(spotifyApiSettings.ClientID + ":" + spotifyApiSettings.ClientSecret));
                var response = client.Execute(request);

                if (response.StatusCode == HttpStatusCode.OK)
                {
                    var spotifyApiToken = JsonConvert.DeserializeObject<SpotifyApiToken>(response.Content);
                    spotifyApiToken.ExpiresOn = DateTime.Now.AddSeconds(spotifyApiToken.Expires_in);


                    if (context.SpotifyApiToken.Find(4) != null)
                    {
                        var oldToken = context.SpotifyApiToken.Find(4);
                        oldToken.ExpiresOn = spotifyApiToken.ExpiresOn;
                        oldToken.Refresh_token = spotifyApiToken.Refresh_token;
                        oldToken.Access_token = spotifyApiToken.Access_token;
                        context.SpotifyApiToken.Update(oldToken);
                        context.SaveChanges();
                    }
                    else
                    {
                        context.SpotifyApiToken.Add(spotifyApiToken);
                        context.SaveChanges();
                    }

                    context.Dispose();
                    return spotifyApiToken;
                }
            }

            context.Dispose();
            return null;
        }

        /// <summary>
        /// Get the Acces token from the Database
        /// </summary>
        /// <param name="_options">A option object with the Database connection string</param>
        /// <returns></returns>
        public static SpotifyApiToken GetStoredAccesToken(IOptions<ConnectionStrings> _options)
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
            optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                ServerVersion.AutoDetect(_options.Value.DefaultConnection));

            var _context = new ApplicationDbContext(optionsBuilder.Options);


            var spotifyApiSettings = _context.SpotifyApiSettings.Find(1);
            var spotifyApiToken = _context.SpotifyApiToken.Find(4);
            if (spotifyApiToken != null)
                if (spotifyApiToken.ExpiresOn < DateTime.Now)
                {
                    _context.Dispose();
                    return GetAccesToken(spotifyApiToken.Refresh_token, spotifyApiSettings, _options, true);
                }

            _context.Dispose();
            return spotifyApiToken;
        }


        public static string CreatePlaylist(IOptions<ConnectionStrings> _options)
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
            optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                ServerVersion.AutoDetect(_options.Value.DefaultConnection));

            var _context = new ApplicationDbContext(optionsBuilder.Options);
            var spotifyApiSettings = _context.SpotifyApiSettings.Find(1);
            if (spotifyApiSettings != null)
            {
                var apiToken = GetStoredAccesToken(_options);
                if (apiToken != null)
                {
                    var client = new RestClient("https://api.spotify.com/v1/me/playlists")
                    {
                        Timeout = -1
                    };
                    var request = new RestRequest(Method.POST);

                    request.AddJsonBody(new SpotifyApiPlaylistResquest
                    {
                        name = spotifyApiSettings.PlaylistName + DateTime.Now.ToString("dd/MMMM/yyyy"),
                        collaborative = true,
                        @public = false
                    });
                    request.AddHeader("Content-Type", "application/json");
                    request.AddHeader("Authorization", "Bearer " + apiToken.Access_token);

                    var response = client.Execute(request);

                    if (response.StatusCode == HttpStatusCode.Created)
                    {
                        var playlistResponse =
                            JsonConvert.DeserializeObject<SpotifyApiPlaylistResponse>(response.Content);
                        _context.Dispose();
                        return playlistResponse.External_urls.Spotify;
                    }
                }
            }

            _context.Dispose();
            return null;
        }

        public static string EncodeTo64(string toEncode)
        {
            var toEncodeAsBytes
                = Encoding.ASCII.GetBytes(toEncode);

            var returnValue
                = Convert.ToBase64String(toEncodeAsBytes);

            return returnValue;
        }
    }
}