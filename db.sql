USE [master]
GO
/****** Object:  Database [bus_reservation3]    Script Date: 9.1.2013 23:18:58 ******/
CREATE DATABASE [bus_reservation3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bus_reservation3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\bus_reservation3.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'bus_reservation3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\bus_reservation3_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [bus_reservation3] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bus_reservation3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bus_reservation3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bus_reservation3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bus_reservation3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bus_reservation3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bus_reservation3] SET ARITHABORT OFF 
GO
ALTER DATABASE [bus_reservation3] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [bus_reservation3] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [bus_reservation3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bus_reservation3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bus_reservation3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bus_reservation3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bus_reservation3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bus_reservation3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bus_reservation3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bus_reservation3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bus_reservation3] SET  DISABLE_BROKER 
GO
ALTER DATABASE [bus_reservation3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bus_reservation3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bus_reservation3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bus_reservation3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bus_reservation3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bus_reservation3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bus_reservation3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bus_reservation3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [bus_reservation3] SET  MULTI_USER 
GO
ALTER DATABASE [bus_reservation3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bus_reservation3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [bus_reservation3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [bus_reservation3] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [bus_reservation3]
GO
/****** Object:  StoredProcedure [dbo].[getAgentSales]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getAgentSales]
	@AgentID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT DISTINCT(Res.ticket_id), U.user_id, R.fare, Res.status, Res.date AS reservation_date, R.departure_time, T.city_name AS to_city_name, F.city_name AS from_city_name FROM (Routes AS R INNER JOIN Cities AS T ON R.to_city = T.city_id INNER JOIN Cities AS F ON R.from_city = F.city_id), Agents as A, Employees as E, (Users AS U LEFT JOIN Reservations AS Res ON Res.user_id = U.user_id) WHERE E.user_id = U.user_id AND E.agent_id = A.agent_id AND A.agent_id = @AgentID AND res.route_id = R.route_id
END


GO
/****** Object:  StoredProcedure [dbo].[getEmployeeSales]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getEmployeeSales]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT DISTINCT(Res.ticket_id), U.user_id, R.fare, Res.status, Res.date AS reservation_date, R.departure_time, T.city_name AS to_city_name, F.city_name AS from_city_name
 FROM (Routes AS R INNER JOIN Cities AS T ON R.to_city = T.city_id INNER JOIN Cities AS F ON R.from_city = F.city_id), (Users AS U LEFT JOIN Reservations AS Res ON Res.user_id = U.user_id) 
 WHERE Res.user_id = @UserID AND res.route_id = R.route_id
END


GO
/****** Object:  StoredProcedure [dbo].[getTicketInfo]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTicketInfo]
(
	@TicketId int
)
AS
SET NOCOUNT ON
SELECT DISTINCT Res.ticket_id, Res.seat_number, Res.status ,C.first_name, C.last_name, C.phone_number, Res.date AS reservation_date, R.departure_time, T.city_name AS to_city_name, F.city_name AS from_city_name, Res.user_id FROM (Routes AS R INNER JOIN Cities AS T ON R.to_city = T.city_id INNER JOIN Cities AS F ON R.from_city = F.city_id), Customers AS C, Reservations AS Res  WHERE Res.ticket_id = @TicketId AND R.route_id = Res.route_id AND Res.customer_id = C.customer_id 

GO
/****** Object:  Table [dbo].[Agents]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Agents](
	[agent_id] [int] IDENTITY(1,1) NOT NULL,
	[agent_name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[address] [text] NULL,
 CONSTRAINT [PK_Agents] PRIMARY KEY CLUSTERED 
(
	[agent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Bus]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bus](
	[bus_id] [int] IDENTITY(1,1) NOT NULL,
	[bus_name] [varchar](50) NULL,
	[seat_count] [int] NULL,
	[type] [varchar](50) NULL,
	[license_plate] [varchar](50) NULL,
 CONSTRAINT [PK_Bus] PRIMARY KEY CLUSTERED 
(
	[bus_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cities](
	[city_id] [int] NOT NULL,
	[city_name] [varchar](50) NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[birth_date] [date] NULL,
	[gender] [bit] NULL,
	[email] [varchar](50) NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[agent_id] [int] NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[gender] [tinyint] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ticket_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[customer_id] [int] NULL,
	[route_id] [int] NULL,
	[date] [datetime] NULL,
	[status] [smallint] NULL,
	[seat_number] [int] NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Routes]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Routes](
	[route_id] [int] IDENTITY(1,1) NOT NULL,
	[from_city] [int] NULL,
	[to_city] [int] NULL,
	[driver_name] [varchar](50) NULL,
	[fare] [varchar](50) NULL,
	[departure_time] [datetime] NULL,
	[bus_id] [int] NULL,
 CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED 
(
	[route_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[user_level] [int] NULL,
	[sales] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[ReservationView]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReservationView]
AS
SELECT DISTINCT 
                         Res.ticket_id, Res.seat_number, Res.status, C.first_name, C.last_name, C.phone_number, Res.date AS reservation_date, R.departure_time, 
                         T.city_name AS to_city_name, F.city_name AS from_city_name, Res.user_id
FROM            dbo.Reservations AS Res INNER JOIN
                         dbo.Routes AS R INNER JOIN
                         dbo.Cities AS T ON R.to_city = T.city_id INNER JOIN
                         dbo.Cities AS F ON R.from_city = F.city_id ON Res.route_id = R.route_id INNER JOIN
                         dbo.Users AS U ON Res.user_id = U.user_id INNER JOIN
                         dbo.Customers AS C ON Res.customer_id = C.customer_id CROSS JOIN
                         dbo.Employees AS E


GO
SET IDENTITY_INSERT [dbo].[Agents] ON 

INSERT [dbo].[Agents] ([agent_id], [agent_name], [email], [phone_number], [address]) VALUES (3, N'Ahmet', N'Velsda', N'sadk213', N'sdakkas')
INSERT [dbo].[Agents] ([agent_id], [agent_name], [email], [phone_number], [address]) VALUES (4, N'Buca Heykel', N'aksdkas@kdsa.com', N'2131231', N'askdkas')
SET IDENTITY_INSERT [dbo].[Agents] OFF
SET IDENTITY_INSERT [dbo].[Bus] ON 

INSERT [dbo].[Bus] ([bus_id], [bus_name], [seat_count], [type], [license_plate]) VALUES (12, N'Travego', 50, N'Teknobüs', N'07 KK 001')
SET IDENTITY_INSERT [dbo].[Bus] OFF
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (1, N'Adana')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (2, N'Adıyaman')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (3, N'Afyon')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (4, N'Ağrı')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (5, N'Amasya')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (6, N'Ankara')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (7, N'Antalya')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (8, N'Artvin')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (9, N'Aydın')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (10, N'Balıkesir')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (11, N'Bilecik')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (12, N'Bingöl')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (13, N'Bitlis')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (14, N'Bolu')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (15, N'Burdur')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (16, N'Bursa')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (17, N'Çanakkale')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (18, N'Çankırı')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (19, N'Çorum')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (20, N'Denizli')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (21, N'Diyarbakır')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (22, N'Edirne')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (23, N'Elazığ')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (24, N'Erzincan')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (25, N'Erzurum')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (26, N'Eskişehir')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (27, N'Gaziantep')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (28, N'Giresun')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (29, N'Gümüşhane')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (30, N'Hakkari')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (31, N'Hatay')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (32, N'Isparta')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (33, N'Mersin')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (34, N'İstanbul')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (35, N'İzmir')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (36, N'Kars')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (37, N'Kastamonu')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (38, N'Kayseri')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (39, N'Kırklareli')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (40, N'Kırşehir')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (41, N'Kocaeli')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (42, N'Konya')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (43, N'Kütahya')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (44, N'Malatya')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (45, N'Manisa')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (46, N'K.Maraş')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (47, N'Mardin')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (48, N'Muğla')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (49, N'Muş')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (50, N'Nevşehir')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (51, N'Niğde')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (52, N'Ordu')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (53, N'Rize')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (54, N'Sakarya')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (55, N'Samsun')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (56, N'Siirt')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (57, N'Sinop')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (58, N'Sivas')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (59, N'Tekirdağ')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (60, N'Tokat')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (61, N'Trabzon')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (62, N'Tunceli')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (63, N'Şanlıurfa')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (64, N'Uşak')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (65, N'Van')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (66, N'Yozgat')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (67, N'Zonguldak')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (68, N'Aksaray')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (69, N'Bayburt')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (70, N'Karaman')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (71, N'Kırıkkale')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (72, N'Batman')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (73, N'Şırnak')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (74, N'Bartın')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (75, N'Ardahan')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (76, N'Iğdır')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (77, N'Yalova')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (78, N'Karabük')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (79, N'Kilis')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (80, N'Osmaniye')
INSERT [dbo].[Cities] ([city_id], [city_name]) VALUES (81, N'Düzce')
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([customer_id], [first_name], [last_name], [phone_number], [birth_date], [gender], [email], [user_id]) VALUES (14, N'Mehmet', N'Beydogan', N'05312312', CAST(0x1D360B00 AS Date), 0, N'mbbrain@gmail.com', 6)
INSERT [dbo].[Customers] ([customer_id], [first_name], [last_name], [phone_number], [birth_date], [gender], [email], [user_id]) VALUES (15, N'Veli', N'Güler', N'012312', CAST(0xAF360B00 AS Date), 0, N'mbbrain@gmail.com', 7)
INSERT [dbo].[Customers] ([customer_id], [first_name], [last_name], [phone_number], [birth_date], [gender], [email], [user_id]) VALUES (16, N'Ahmet', N'dsa', N'05312312', CAST(0xA3360B00 AS Date), 0, N'mbbrain@gmail.com', 7)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([employee_id], [agent_id], [first_name], [last_name], [email], [phone_number], [gender], [user_id]) VALUES (4, 3, N'Ahmet', N'Yılmaz', N'mbbrain@gmail.com', N'053128688828', 0, 6)
INSERT [dbo].[Employees] ([employee_id], [agent_id], [first_name], [last_name], [email], [phone_number], [gender], [user_id]) VALUES (5, 4, N'BucaHeykel1', N'BucaHeykelSoy', N'askdska@kdsa.com', N'1231231', 0, 7)
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[Reservations] ON 

INSERT [dbo].[Reservations] ([ticket_id], [user_id], [customer_id], [route_id], [date], [status], [seat_number]) VALUES (26, 6, 14, 35, CAST(0x0000A141017B0740 AS DateTime), 1, 17)
INSERT [dbo].[Reservations] ([ticket_id], [user_id], [customer_id], [route_id], [date], [status], [seat_number]) VALUES (27, 7, 15, 35, CAST(0x0000A141017CF370 AS DateTime), 1, 23)
INSERT [dbo].[Reservations] ([ticket_id], [user_id], [customer_id], [route_id], [date], [status], [seat_number]) VALUES (28, 7, 16, 36, CAST(0x0000A141017FB290 AS DateTime), 1, 18)
SET IDENTITY_INSERT [dbo].[Reservations] OFF
SET IDENTITY_INSERT [dbo].[Routes] ON 

INSERT [dbo].[Routes] ([route_id], [from_city], [to_city], [driver_name], [fare], [departure_time], [bus_id]) VALUES (36, 1, 10, N'Ahmet', N'50.00', CAST(0x0000A141017F6C40 AS DateTime), 12)
SET IDENTITY_INSERT [dbo].[Routes] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password], [email], [user_level], [sales]) VALUES (1, N'admin', N'123456', N'admin@varan.com', 3, 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [user_level], [sales]) VALUES (6, N'ahmet', N'123456', N'mbbrain@gmail.com', 1, 1)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [user_level], [sales]) VALUES (7, N'bucaheykel', N'123456', N'askdska@kdsa.com', 1, 2)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [plate]    Script Date: 9.1.2013 23:18:58 ******/
ALTER TABLE [dbo].[Bus] ADD  CONSTRAINT [plate] UNIQUE NONCLUSTERED 
(
	[license_plate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [reservationsDateIndex]    Script Date: 9.1.2013 23:18:58 ******/
CREATE NONCLUSTERED INDEX [reservationsDateIndex] ON [dbo].[Reservations]
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [reservationsIndex]    Script Date: 9.1.2013 23:18:58 ******/
CREATE NONCLUSTERED INDEX [reservationsIndex] ON [dbo].[Reservations]
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers]  WITH NOCHECK ADD  CONSTRAINT [FK_Customers_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Customers] NOCHECK CONSTRAINT [FK_Customers_Users]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Agents] FOREIGN KEY([agent_id])
REFERENCES [dbo].[Agents] ([agent_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Agents]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Users]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Customers]
GO
ALTER TABLE [dbo].[Reservations]  WITH NOCHECK ADD  CONSTRAINT [FK_Reservations_Routes] FOREIGN KEY([route_id])
REFERENCES [dbo].[Routes] ([route_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservations] NOCHECK CONSTRAINT [FK_Reservations_Routes]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Users]
GO
ALTER TABLE [dbo].[Routes]  WITH CHECK ADD  CONSTRAINT [FK_Routes_Bus] FOREIGN KEY([bus_id])
REFERENCES [dbo].[Bus] ([bus_id])
GO
ALTER TABLE [dbo].[Routes] CHECK CONSTRAINT [FK_Routes_Bus]
GO
ALTER TABLE [dbo].[Routes]  WITH NOCHECK ADD  CONSTRAINT [FK_Routes_Cities] FOREIGN KEY([from_city])
REFERENCES [dbo].[Cities] ([city_id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Routes] NOCHECK CONSTRAINT [FK_Routes_Cities]
GO
ALTER TABLE [dbo].[Routes]  WITH CHECK ADD  CONSTRAINT [FK_Routes_Cities1] FOREIGN KEY([to_city])
REFERENCES [dbo].[Cities] ([city_id])
GO
ALTER TABLE [dbo].[Routes] CHECK CONSTRAINT [FK_Routes_Cities1]
GO
/****** Object:  Trigger [dbo].[UPDATE_SALES]    Script Date: 9.1.2013 23:18:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[UPDATE_SALES]
   ON  [dbo].[Reservations]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare @user_id int
	select @user_id = user_id FROM inserted
    UPDATE Users SET Sales = Sales + 1 WHERE user_id = @user_id
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Res"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "R"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 102
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "F"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 102
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "U"
            Begin Extent = 
               Top = 6
               Left = 870
               Bottom = 136
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 1078
               Bottom = 136
               Right = 1248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 102
               Left = 454
               Bottom = 232
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReservationView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReservationView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReservationView'
GO
USE [master]
GO
ALTER DATABASE [bus_reservation3] SET  READ_WRITE 
GO
