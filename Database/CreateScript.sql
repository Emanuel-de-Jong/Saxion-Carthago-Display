CREATE DATABASE  IF NOT EXISTS `CarthagoDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE [CarthagoDB]
GO
/****** Object:  Table [dbo].[Components]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Components](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Html] [nvarchar](max) NULL,
	[ComponentType] [int] NOT NULL,
	[NumberOfPosts] [int] NOT NULL,
	[Url] [nvarchar](max) NULL,
 CONSTRAINT [PK_Components] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IsBorrel] [bit] NOT NULL,
	[Start] [datetime2](7) NOT NULL,
	[End] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventsSettings]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventsSettings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[calanderOwnerEmail] [nvarchar](max) NULL,
	[calanderName] [nvarchar](max) NULL,
	[calanderID] [nvarchar](max) NULL,
	[BorrelEventName] [nvarchar](max) NULL,
 CONSTRAINT [PK_EventsSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewEmployees]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewEmployees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Picture] [nvarchar](max) NULL,
	[InDienstPer] [datetime2](7) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Role] [nvarchar](max) NULL,
 CONSTRAINT [PK_NewEmployees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OutLookApiSettings]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutLookApiSettings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tenant] [nvarchar](max) NULL,
	[ClientId] [nvarchar](max) NULL,
	[ClientSecret] [nvarchar](max) NULL,
	[RedirectURL] [nvarchar](max) NULL,
	[Authorized] [bit] NOT NULL,
	[AdminEmail] [nvarchar](max) NULL,
 CONSTRAINT [PK_OutLookApiSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageComponents]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageComponents](
	[PageId] [int] NOT NULL,
	[ComponentId] [int] NOT NULL,
	[GridPosition] [int] NOT NULL,
 CONSTRAINT [PK_PageComponents] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC,
	[ComponentId] ASC,
	[GridPosition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Grid] [nvarchar](max) NULL,
	[Index] [int] NOT NULL,
	[PrimaryColor] [nvarchar](max) NULL,
	[SecondaryColor] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[Background] [nvarchar](max) NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](max) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_RoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[NormalizedName] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[Name] [nvarchar](max) NULL,
	[Address] [nvarchar](450) NOT NULL,
	[AvailabilityView] [nvarchar](max) NULL,
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[Address] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpotifyApiSettings]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpotifyApiSettings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RedirectUrl] [nvarchar](max) NULL,
	[PlaylistName] [nvarchar](max) NULL,
	[ClientID] [nvarchar](max) NULL,
	[ClientSecret] [nvarchar](max) NULL,
 CONSTRAINT [PK_SpotifyApiSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpotifyApiToken]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpotifyApiToken](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Access_token] [nvarchar](max) NULL,
	[Refresh_token] [nvarchar](max) NULL,
	[ExpiresOn] [datetime2](7) NOT NULL,
	[Expires_in] [float] NOT NULL,
 CONSTRAINT [PK_SpotifyApiToken] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](max) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[ProviderKey] [nvarchar](450) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](max) NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](max) NULL,
	[NormalizedUserName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[NormalizedEmail] [nvarchar](max) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTokens]    Script Date: 12-Oct-21 13:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Components] ON 

INSERT [dbo].[Components] ([Id], [Name], [Html], [ComponentType], [NumberOfPosts], [Url]) VALUES (7, N'Room', NULL, 0, 0, NULL)
INSERT [dbo].[Components] ([Id], [Name], [Html], [ComponentType], [NumberOfPosts], [Url]) VALUES (8, N'Events', NULL, 1, 0, NULL)
INSERT [dbo].[Components] ([Id], [Name], [Html], [ComponentType], [NumberOfPosts], [Url]) VALUES (9, N'Klok', NULL, 3, 0, NULL)
SET IDENTITY_INSERT [dbo].[Components] OFF
SET IDENTITY_INSERT [dbo].[EventsSettings] ON 

INSERT [dbo].[EventsSettings] ([Id], [calanderOwnerEmail], [calanderName], [calanderID], [BorrelEventName]) VALUES (1, N'', N'', N'', N'')
SET IDENTITY_INSERT [dbo].[EventsSettings] OFF
SET IDENTITY_INSERT [dbo].[OutLookApiSettings] ON 

INSERT [dbo].[OutLookApiSettings] ([Id], [Tenant], [ClientId], [ClientSecret], [RedirectURL], [Authorized], [AdminEmail]) VALUES (1, N'', N'', N'', N'', 0, N'')
SET IDENTITY_INSERT [dbo].[OutLookApiSettings] OFF
SET IDENTITY_INSERT [dbo].[SpotifyApiSettings] ON 

INSERT [dbo].[SpotifyApiSettings] ([Id], [RedirectUrl], [PlaylistName], [ClientID], [ClientSecret]) VALUES (1, N'', N'', N'', N'')
SET IDENTITY_INSERT [dbo].[SpotifyApiSettings] OFF
SET IDENTITY_INSERT [dbo].[SpotifyApiToken] ON 

INSERT [dbo].[SpotifyApiToken] ([Id], [Access_token], [Refresh_token], [ExpiresOn], [Expires_in]) VALUES (4, N'', N'', CAST(N'2021-10-08T14:35:19.0018618' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[SpotifyApiToken] OFF
ALTER TABLE [dbo].[Components] ADD  DEFAULT ((0)) FOR [ComponentType]
GO
ALTER TABLE [dbo].[Components] ADD  DEFAULT ((0)) FOR [NumberOfPosts]
GO
ALTER TABLE [dbo].[NewEmployees] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [InDienstPer]
GO
ALTER TABLE [dbo].[OutLookApiSettings] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Authorized]
GO
ALTER TABLE [dbo].[PageComponents] ADD  DEFAULT ((0)) FOR [GridPosition]
GO
ALTER TABLE [dbo].[Rooms] ADD  DEFAULT (N'') FOR [Address]
GO
ALTER TABLE [dbo].[Rooms] ADD  DEFAULT (N'000000000000000000') FOR [AvailabilityView]
GO
ALTER TABLE [dbo].[SpotifyApiToken] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [Expires_in]
GO
ALTER TABLE [dbo].[PageComponents]  WITH CHECK ADD  CONSTRAINT [FK_PageComponents_Components_ComponentId] FOREIGN KEY([ComponentId])
REFERENCES [dbo].[Components] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PageComponents] CHECK CONSTRAINT [FK_PageComponents_Components_ComponentId]
GO
ALTER TABLE [dbo].[PageComponents]  WITH CHECK ADD  CONSTRAINT [FK_PageComponents_Pages_PageId] FOREIGN KEY([PageId])
REFERENCES [dbo].[Pages] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PageComponents] CHECK CONSTRAINT [FK_PageComponents_Pages_PageId]
GO
