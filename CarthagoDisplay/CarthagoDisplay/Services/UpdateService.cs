using CarthagoDisplay.Data;
using CarthagoDisplay.Data.SettingsModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace CarthagoDisplay.Services
{
    public class UpdateService
    {
        private readonly MessageService _messageService;
        private readonly IOptions<ConnectionStrings> _options;

        public UpdateService(IOptions<ConnectionStrings> options, MessageService message)
        {
            _options = options;
            _messageService = message;
        }


        public async void SetupDb()
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
            optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                ServerVersion.AutoDetect(_options.Value.DefaultConnection));

            var context = new ApplicationDbContext(optionsBuilder.Options);

            if (context.MainSettings.Find(1) == null)
            {
                MainSettingsDB settings = new() { SlideTime = 10 };
                context.MainSettings.Add(settings);
            }

            if (context.OutLookApiSettings.Find(1) == null)
            {
                OutLookApiSettings settings = new() { Authorized = false };
                context.OutLookApiSettings.Add(settings);
            }

            if (context.EventsSettings.Find(1) == null)
            {
                OutlookEventsSettings settings = new();
                context.EventsSettings.Add(settings);
            }

            if (context.SpotifyApiSettings.Find(1) == null)
            {
                SpotifyApiSettings settings = new();
                context.SpotifyApiSettings.Add(settings);
            }

            context.SaveChanges();

            if (!await context.Components.Where(T => T.ComponentType == ComponentType.Rooms).AnyAsync())
            {
                Component newComponent = new()
                {
                    Name = "Room",
                    ComponentType = ComponentType.Rooms
                };
                await context.Components.AddAsync(newComponent);
            }

            if (!await context.Components.Where(T => T.ComponentType == ComponentType.Events).AnyAsync())
            {
                Component newComponent = new()
                {
                    Name = "Events",
                    ComponentType = ComponentType.Events
                };
                await context.Components.AddAsync(newComponent);
            }

            if (!await context.Components.Where(T => T.ComponentType == ComponentType.Klok).AnyAsync())
            {
                Component newComponent = new()
                {
                    Name = "Klok",
                    ComponentType = ComponentType.Klok
                };
                await context.Components.AddAsync(newComponent);
            }

            if (!await context.Components.Where(T => T.ComponentType == ComponentType.NewEmployee).AnyAsync())
            {
                Component newComponent = new()
                {
                    Name = "NewEmployee",
                    ComponentType = ComponentType.NewEmployee
                };
                await context.Components.AddAsync(newComponent);
            }

            await context.SaveChangesAsync();
            await context.DisposeAsync();
        }

        public async void UpdateRoomsAvalibility()
        {
            while (true)
            {
                await UpdateRooms();
                var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
                optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                    ServerVersion.AutoDetect(_options.Value.DefaultConnection));

                var _context = new ApplicationDbContext(optionsBuilder.Options);

                var outLookApiSettings = await _context.OutLookApiSettings.FindAsync(1);

                var rooms = await _context.Rooms.ToListAsync();

                var newRooms = OutlookApiService.GetRoomAvailabilityView(rooms, outLookApiSettings);

                foreach (var room in newRooms)
                {
                    var Oldroom = await _context.Rooms.FindAsync(room.Address);
                    if (Oldroom != null) _context.Rooms.Update(Oldroom);
                }

                var test = _context.ChangeTracker;

                await _context.SaveChangesAsync();
                await _context.DisposeAsync();

                _messageService.SendMessage("Update_Rooms");

                Thread.Sleep(5000);
            }
        }

        public async Task UpdateRooms()
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();

            optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                ServerVersion.AutoDetect(_options.Value.DefaultConnection));


            var _context = new ApplicationDbContext(optionsBuilder.Options);

            var outLookApiSettings = _context.OutLookApiSettings.Find(1);
            var rooms = OutlookApiService.GetRooms(outLookApiSettings);
            var roomsinDB = await _context.Rooms.ToListAsync();


            foreach (var room in rooms)
            {
                var Oldroom = await _context.Rooms.FindAsync(room.Address);

                if (Oldroom != null) continue;
                room.AvailabilityView = "000000000000000000";
                _context.Rooms.Add(room);
            }

            await _context.SaveChangesAsync();

            foreach (var room in roomsinDB)
            {
                var oldRoom = rooms.Find(T => T.Address == room.Address);
                if (oldRoom == null) _context.Rooms.Remove(room);
            }

            await _context.SaveChangesAsync();
            await _context.DisposeAsync();
        }

        public async void UpdateEvents()
        {
            while (true)
            {
                var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
                optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                    ServerVersion.AutoDetect(_options.Value.DefaultConnection));

                var _context = new ApplicationDbContext(optionsBuilder.Options);

                var outLookApiSettings = await _context.OutLookApiSettings.FindAsync(1);
                var outlookEventsSettings = await _context.EventsSettings.FindAsync(1);

                var events = OutlookApiService.GetEvents(outlookEventsSettings, outLookApiSettings);
                var eventsInDB = await _context.Events.AsNoTracking().ToListAsync();

                if (events != null)
                {
                    foreach (var newEvent in events)
                    {
                        var oldEvent = await _context.Events.AsNoTracking()
                            .FirstOrDefaultAsync(T => T.Id == newEvent.Id);
                        if (oldEvent == null)
                        {
                            _context.Events.Add(newEvent);
                        }
                        else
                        {
                            ;
                            _context.Events.Update(newEvent);
                        }
                    }

                    await _context.SaveChangesAsync();

                    foreach (var @event in eventsInDB)
                    {
                        var oldEvent = events.Find(T => T.Id == @event.Id);
                        if (oldEvent == null) _context.Events.Remove(@event);
                    }

                    await _context.SaveChangesAsync();
                    await _context.DisposeAsync();

                    _messageService.SendMessage("Update_Events");
                }

                Thread.Sleep(5000);
            }
        }

        public void UpdateRssFeeds()
        {
            while (true)
            {
                _messageService.SendMessage("Update_RSS");
                Thread.Sleep(30000);
            }
        }

        public void UpdateSlider()
        {
            while (true)
            {
                var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
                optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                    ServerVersion.AutoDetect(_options.Value.DefaultConnection));

                var _context = new ApplicationDbContext(optionsBuilder.Options);

                var time = _context.MainSettings.Find(1).SlideTime;


                _messageService.SendMessage("Update_Slide");


                Thread.Sleep(time * 1000);
            }
        }

        public void CheckForBorrel()
        {
            while (true)
            {
                var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
                optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                    ServerVersion.AutoDetect(_options.Value.DefaultConnection));

                var _context = new ApplicationDbContext(optionsBuilder.Options);

                var borrelEvents = _context.Events.Where(t => t.IsBorrel == true).ToList();

                foreach (var item in borrelEvents)
                {
                    var now = DateTime.Now;

                    if (now.Ticks > item.Start.Ticks && now.Ticks < item.End.Ticks)
                    {
                        _messageService.SendMessage("BORREL_SETUP");
                        break;
                    }

                    _messageService.SendMessage("BORREL_FALSE");
                }


                Thread.Sleep(10000);
            }
        }

        public void CheckForGreeting()
        {
            while (true)
            {
                var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
                optionsBuilder.UseMySql(_options.Value.DefaultConnection,
                    ServerVersion.AutoDetect(_options.Value.DefaultConnection));

                var _context = new ApplicationDbContext(optionsBuilder.Options);

                var greetingEvents = _context.Events.Where(t => t.IsGreeting == true).ToList();

                foreach (var item in greetingEvents)
                {
                    var now = DateTime.Now;

                    if (now.Ticks > item.Start.Ticks && now.Ticks < item.End.Ticks)
                    {
                        _messageService.SendMessage("GREETING_TRUE");
                        break;
                    }

                    _messageService.SendMessage("GREETING_FALSE");
                }


                Thread.Sleep(10000);
            }
        }

        public Task Start()
        {
            Thread updateRoomsAvalibilityThread = new(UpdateRoomsAvalibility);
            Thread updateEvents = new(UpdateEvents);
            Thread updateRSS = new(UpdateRssFeeds);
            Thread UpdateSlider = new(this.UpdateSlider);
            Thread LookForBorrel = new(CheckForBorrel);
            Thread LookForGreeting = new(CheckForGreeting);
            updateRoomsAvalibilityThread.Start();
            updateEvents.Start();
            updateRSS.Start();
            UpdateSlider.Start();
            LookForBorrel.Start();
            LookForGreeting.Start();
            return Task.CompletedTask;
        }
    }
}