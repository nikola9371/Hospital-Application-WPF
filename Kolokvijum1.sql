USE [master]
GO
/****** Object:  Database [Kolokvijum1]    Script Date: 4/5/2021 1:55:17 AM ******/
CREATE DATABASE [Kolokvijum1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Kolokvijum1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Kolokvijum1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Kolokvijum1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Kolokvijum1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Kolokvijum1] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Kolokvijum1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Kolokvijum1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Kolokvijum1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Kolokvijum1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Kolokvijum1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Kolokvijum1] SET ARITHABORT OFF 
GO
ALTER DATABASE [Kolokvijum1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Kolokvijum1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Kolokvijum1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Kolokvijum1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Kolokvijum1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Kolokvijum1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Kolokvijum1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Kolokvijum1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Kolokvijum1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Kolokvijum1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Kolokvijum1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Kolokvijum1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Kolokvijum1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Kolokvijum1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Kolokvijum1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Kolokvijum1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Kolokvijum1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Kolokvijum1] SET RECOVERY FULL 
GO
ALTER DATABASE [Kolokvijum1] SET  MULTI_USER 
GO
ALTER DATABASE [Kolokvijum1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Kolokvijum1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Kolokvijum1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Kolokvijum1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Kolokvijum1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Kolokvijum1', N'ON'
GO
ALTER DATABASE [Kolokvijum1] SET QUERY_STORE = OFF
GO
USE [Kolokvijum1]
GO
/****** Object:  Table [dbo].[Odeljenje]    Script Date: 4/5/2021 1:55:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Odeljenje](
	[OdeljenjeID] [int] NOT NULL,
	[Naziv] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Odeljenje] PRIMARY KEY CLUSTERED 
(
	[OdeljenjeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pacijent]    Script Date: 4/5/2021 1:55:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pacijent](
	[IDPacijent] [int] NOT NULL,
	[Ime] [nvarchar](max) NOT NULL,
	[Prezime] [nvarchar](max) NOT NULL,
	[Prioritet] [int] NOT NULL,
	[BrDana] [int] NULL,
	[OdeljenjeID] [int] NOT NULL,
	[SobaID] [int] NOT NULL,
 CONSTRAINT [PK_Pacijent] PRIMARY KEY CLUSTERED 
(
	[IDPacijent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Soba]    Script Date: 4/5/2021 1:55:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Soba](
	[SobaID] [int] NOT NULL,
	[OdeljenjeID] [int] NOT NULL,
	[Sprat] [int] NOT NULL,
 CONSTRAINT [PK_Soba] PRIMARY KEY CLUSTERED 
(
	[SobaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Odeljenje] ([OdeljenjeID], [Naziv]) VALUES (1, N'Odeljenje1')
INSERT [dbo].[Odeljenje] ([OdeljenjeID], [Naziv]) VALUES (2, N'Odeljenje2')
INSERT [dbo].[Odeljenje] ([OdeljenjeID], [Naziv]) VALUES (3, N'Odeljenje3')
INSERT [dbo].[Odeljenje] ([OdeljenjeID], [Naziv]) VALUES (4, N'Odeljenje4')
INSERT [dbo].[Pacijent] ([IDPacijent], [Ime], [Prezime], [Prioritet], [BrDana], [OdeljenjeID], [SobaID]) VALUES (1, N'Neko1', N'Nekic1', 4, 5, 4, 4)
INSERT [dbo].[Pacijent] ([IDPacijent], [Ime], [Prezime], [Prioritet], [BrDana], [OdeljenjeID], [SobaID]) VALUES (2, N'Neko2', N'Nekic2', 2, 4, 2, 2)
INSERT [dbo].[Pacijent] ([IDPacijent], [Ime], [Prezime], [Prioritet], [BrDana], [OdeljenjeID], [SobaID]) VALUES (3, N'Neko3', N'Nekic3', 3, 3, 4, 3)
INSERT [dbo].[Pacijent] ([IDPacijent], [Ime], [Prezime], [Prioritet], [BrDana], [OdeljenjeID], [SobaID]) VALUES (4, N'Neko4', N'Nekic4', 1, 2, 3, 3)
INSERT [dbo].[Pacijent] ([IDPacijent], [Ime], [Prezime], [Prioritet], [BrDana], [OdeljenjeID], [SobaID]) VALUES (5, N'Neko5', N'Nekic5', 2, 1, 1, 1)
INSERT [dbo].[Pacijent] ([IDPacijent], [Ime], [Prezime], [Prioritet], [BrDana], [OdeljenjeID], [SobaID]) VALUES (6, N'Novi6', N'Novic6', 2, NULL, 1, 1)
INSERT [dbo].[Pacijent] ([IDPacijent], [Ime], [Prezime], [Prioritet], [BrDana], [OdeljenjeID], [SobaID]) VALUES (7, N'Neko7', N'Nekic7', 2, NULL, 1, 1)
INSERT [dbo].[Soba] ([SobaID], [OdeljenjeID], [Sprat]) VALUES (1, 1, 1)
INSERT [dbo].[Soba] ([SobaID], [OdeljenjeID], [Sprat]) VALUES (2, 2, 2)
INSERT [dbo].[Soba] ([SobaID], [OdeljenjeID], [Sprat]) VALUES (3, 3, 3)
INSERT [dbo].[Soba] ([SobaID], [OdeljenjeID], [Sprat]) VALUES (4, 4, 4)
ALTER TABLE [dbo].[Pacijent]  WITH CHECK ADD  CONSTRAINT [FK_Pacijent_Odeljenje] FOREIGN KEY([OdeljenjeID])
REFERENCES [dbo].[Odeljenje] ([OdeljenjeID])
GO
ALTER TABLE [dbo].[Pacijent] CHECK CONSTRAINT [FK_Pacijent_Odeljenje]
GO
ALTER TABLE [dbo].[Pacijent]  WITH CHECK ADD  CONSTRAINT [FK_Pacijent_Soba] FOREIGN KEY([SobaID])
REFERENCES [dbo].[Soba] ([SobaID])
GO
ALTER TABLE [dbo].[Pacijent] CHECK CONSTRAINT [FK_Pacijent_Soba]
GO
ALTER TABLE [dbo].[Soba]  WITH CHECK ADD  CONSTRAINT [FK_Soba_Odeljenje] FOREIGN KEY([OdeljenjeID])
REFERENCES [dbo].[Odeljenje] ([OdeljenjeID])
GO
ALTER TABLE [dbo].[Soba] CHECK CONSTRAINT [FK_Soba_Odeljenje]
GO
USE [master]
GO
ALTER DATABASE [Kolokvijum1] SET  READ_WRITE 
GO
