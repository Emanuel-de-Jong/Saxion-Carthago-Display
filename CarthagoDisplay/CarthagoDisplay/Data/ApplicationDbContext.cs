using CarthagoDisplay.Data.APIResponseModels;
using CarthagoDisplay.Data.SettingsModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace CarthagoDisplay.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Component> Components { get; set; }
        public DbSet<Slide> Slides { get; set; }
        public DbSet<SlideComponent> SlideComponents { get; set; }

        public DbSet<OutLookApiSettings> OutLookApiSettings { get; set; }

        public DbSet<Room> Rooms { get; set; }

        public DbSet<OutlookEventsSettings> EventsSettings { get; set; }

        public DbSet<Event> Events { get; set; }

        public DbSet<NewEmployee> NewEmployees { get; set; }

        public DbSet<SpotifyApiSettings> SpotifyApiSettings { get; set; }

        public DbSet<MainSettingsDB> MainSettings { get; set; }
        public DbSet<SpotifyApiToken> SpotifyApiToken { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SlideComponent>()
                .HasKey(bc => new {bc.SlideId, bc.ComponentId, bc.GridPosition});

            modelBuilder.Entity<SlideComponent>()
                .HasOne(bc => bc.Slide)
                .WithMany(b => b.SlideComponents)
                .HasForeignKey(bc => bc.SlideId);

            modelBuilder.Entity<SlideComponent>()
                .HasOne(bc => bc.Component)
                .WithMany(c => c.SlideComponents)
                .HasForeignKey(bc => bc.ComponentId);

            modelBuilder.Entity<IdentityUserLogin<string>>()
                .HasKey(nameof(IdentityUserLogin<string>.UserId), nameof(IdentityUserLogin<string>.ProviderKey));

            modelBuilder.Entity<IdentityUserRole<string>>()
                .HasKey(nameof(IdentityUserRole<string>.UserId), nameof(IdentityUserRole<string>.RoleId));

            modelBuilder.Entity<IdentityUserToken<string>>()
                .HasKey(nameof(IdentityUserToken<string>.UserId), nameof(IdentityUserToken<string>.LoginProvider),
                    nameof(IdentityUserToken<string>.Name));

            modelBuilder.Entity<Room>()
                .Property(b => b.AvailabilityView)
                .HasDefaultValue("000000000000000000");

            modelBuilder.Entity<Component>()
                .Property(b => b.NumberOfPosts)
                .HasDefaultValue("0");
        }
    }
}