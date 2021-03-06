USE [master]
GO
/****** Object:  Database [21 вариант (Компьютеры, программы, установленные программы)]    Script Date: 05.10.2021 0:59:41 ******/
CREATE DATABASE [21 вариант (Компьютеры, программы, установленные программы)]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'21 вариант (Компьютеры, программы, установленные программы)', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\21 вариант (Компьютеры, программы, установленные программы).mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'21 вариант (Компьютеры, программы, установленные программы)_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\21 вариант (Компьютеры, программы, установленные программы)_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [21 вариант (Компьютеры, программы, установленные программы)].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET ARITHABORT OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET  DISABLE_BROKER 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET RECOVERY FULL 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET  MULTI_USER 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET DB_CHAINING OFF 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'21 вариант (Компьютеры, программы, установленные программы)', N'ON'
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET QUERY_STORE = OFF
GO
USE [21 вариант (Компьютеры, программы, установленные программы)]
GO
/****** Object:  Table [dbo].[Computer]    Script Date: 05.10.2021 0:59:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Computer](
	[id_computer] [int] IDENTITY(1,1) NOT NULL,
	[ip] [nchar](39) NOT NULL,
	[user_name] [nvarchar](50) NOT NULL,
	[OS] [nvarchar](20) NOT NULL,
	[year_release] [date] NOT NULL,
 CONSTRAINT [PK_Computers] PRIMARY KEY CLUSTERED 
(
	[id_computer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Established_programs]    Script Date: 05.10.2021 0:59:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Established_programs](
	[id_programs_established] [int] NOT NULL,
	[id_computer] [int] NOT NULL,
	[id_programm] [int] NOT NULL,
	[counter] [int] NOT NULL,
	[application_area] [nvarchar](20) NOT NULL,
	[installation_date] [date] NOT NULL,
	[is_has_updating] [bit] NOT NULL,
 CONSTRAINT [PK_Established_programs] PRIMARY KEY CLUSTERED 
(
	[id_programs_established] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program]    Script Date: 05.10.2021 0:59:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program](
	[id_program] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[version] [nchar](10) NOT NULL,
	[is_has_update] [bit] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[id_program] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 05.10.2021 0:59:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](50) NOT NULL,
	[age] [int] NOT NULL,
	[gender] [nchar](3) NOT NULL,
	[contact_number] [varchar](20) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users_computers]    Script Date: 05.10.2021 0:59:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_computers](
	[id_user_computers] [int] NOT NULL,
	[id_user] [int] NOT NULL,
	[id_computer] [int] NOT NULL,
	[counter] [int] NOT NULL,
	[is_main] [bit] NOT NULL,
 CONSTRAINT [PK_Users_computers_1] PRIMARY KEY CLUSTERED 
(
	[id_user_computers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Established_programs]  WITH CHECK ADD  CONSTRAINT [FK_Established_programs_Computer] FOREIGN KEY([id_computer])
REFERENCES [dbo].[Computer] ([id_computer])
GO
ALTER TABLE [dbo].[Established_programs] CHECK CONSTRAINT [FK_Established_programs_Computer]
GO
ALTER TABLE [dbo].[Established_programs]  WITH CHECK ADD  CONSTRAINT [FK_Established_programs_Program] FOREIGN KEY([id_programm])
REFERENCES [dbo].[Program] ([id_program])
GO
ALTER TABLE [dbo].[Established_programs] CHECK CONSTRAINT [FK_Established_programs_Program]
GO
ALTER TABLE [dbo].[Users_computers]  WITH CHECK ADD  CONSTRAINT [FK_Users_computers_Computer] FOREIGN KEY([id_computer])
REFERENCES [dbo].[Computer] ([id_computer])
GO
ALTER TABLE [dbo].[Users_computers] CHECK CONSTRAINT [FK_Users_computers_Computer]
GO
ALTER TABLE [dbo].[Users_computers]  WITH CHECK ADD  CONSTRAINT [FK_Users_computers_User] FOREIGN KEY([id_user])
REFERENCES [dbo].[User] ([id_user])
GO
ALTER TABLE [dbo].[Users_computers] CHECK CONSTRAINT [FK_Users_computers_User]
GO
USE [master]
GO
ALTER DATABASE [21 вариант (Компьютеры, программы, установленные программы)] SET  READ_WRITE 
GO
