namespace CarthagoDisplay.Data.APIResponseModels
{
    public class SpotifyApiPlaylistResponse
    {
        public string Id { get; set; }

        public ExternalUrls External_urls { get; set; }

        public class ExternalUrls
        {
            public string Spotify { get; set; }
        }
    }
}