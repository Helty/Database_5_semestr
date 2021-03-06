USE [master]
GO
/****** Object:  Database [22 вариант (Врачи поликлиники, больные, прием больных)]    Script Date: 05.10.2021 1:04:15 ******/
CREATE DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'22 вариант (Врачи поликлиники, больные, прием больных)', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\22 вариант (Врачи поликлиники, больные, прием больных).mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'22 вариант (Врачи поликлиники, больные, прием больных)_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\22 вариант (Врачи поликлиники, больные, прием больных)_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [22 вариант (Врачи поликлиники, больные, прием больных)].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET ARITHABORT OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET  DISABLE_BROKER 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET RECOVERY FULL 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET  MULTI_USER 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET DB_CHAINING OFF 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'22 вариант (Врачи поликлиники, больные, прием больных)', N'ON'
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET QUERY_STORE = OFF
GO
USE [22 вариант (Врачи поликлиники, больные, прием больных)]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 05.10.2021 1:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[id_doctor] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](50) NOT NULL,
	[age] [int] NOT NULL,
	[education] [nvarchar](20) NOT NULL,
	[work_experience] [int] NOT NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[id_doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 05.10.2021 1:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[id_patient] [int] IDENTITY(1,1) NOT NULL,
	[adress] [nvarchar](100) NOT NULL,
	[full_name] [nvarchar](50) NOT NULL,
	[age] [int] NOT NULL,
	[gender] [nchar](3) NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[id_patient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient_reception]    Script Date: 05.10.2021 1:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient_reception](
	[id_patient_reception] [int] IDENTITY(1,1) NOT NULL,
	[id_doctor] [int] NOT NULL,
	[id_patient] [int] NOT NULL,
	[date_reception] [date] NOT NULL,
	[reception_comment] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Patient_reception] PRIMARY KEY CLUSTERED 
(
	[id_patient_reception] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Polyclinic]    Script Date: 05.10.2021 1:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Polyclinic](
	[id_polyclinic] [int] IDENTITY(1,1) NOT NULL,
	[adress] [nvarchar](50) NOT NULL,
	[is_paid] [bit] NOT NULL,
	[contact_number] [nchar](20) NOT NULL,
	[fax] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Polyclinic] PRIMARY KEY CLUSTERED 
(
	[id_polyclinic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Polyclinic_doctors]    Script Date: 05.10.2021 1:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Polyclinic_doctors](
	[id_polyclinic_doctors] [int] IDENTITY(1,1) NOT NULL,
	[id_polyclinic] [int] NOT NULL,
	[id_doctor] [int] NOT NULL,
	[specialization] [nvarchar](25) NOT NULL,
	[counter] [int] NOT NULL,
 CONSTRAINT [PK_Polyclinic_doctors] PRIMARY KEY CLUSTERED 
(
	[id_polyclinic_doctors] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Patient_reception]  WITH CHECK ADD  CONSTRAINT [FK_Patient_reception_Doctor] FOREIGN KEY([id_doctor])
REFERENCES [dbo].[Doctor] ([id_doctor])
GO
ALTER TABLE [dbo].[Patient_reception] CHECK CONSTRAINT [FK_Patient_reception_Doctor]
GO
ALTER TABLE [dbo].[Patient_reception]  WITH CHECK ADD  CONSTRAINT [FK_Patient_reception_Patient] FOREIGN KEY([id_patient])
REFERENCES [dbo].[Patient] ([id_patient])
GO
ALTER TABLE [dbo].[Patient_reception] CHECK CONSTRAINT [FK_Patient_reception_Patient]
GO
ALTER TABLE [dbo].[Polyclinic_doctors]  WITH CHECK ADD  CONSTRAINT [FK_Polyclinic_doctors_Doctor] FOREIGN KEY([id_doctor])
REFERENCES [dbo].[Doctor] ([id_doctor])
GO
ALTER TABLE [dbo].[Polyclinic_doctors] CHECK CONSTRAINT [FK_Polyclinic_doctors_Doctor]
GO
ALTER TABLE [dbo].[Polyclinic_doctors]  WITH CHECK ADD  CONSTRAINT [FK_Polyclinic_doctors_Polyclinic] FOREIGN KEY([id_polyclinic])
REFERENCES [dbo].[Polyclinic] ([id_polyclinic])
GO
ALTER TABLE [dbo].[Polyclinic_doctors] CHECK CONSTRAINT [FK_Polyclinic_doctors_Polyclinic]
GO
USE [master]
GO
ALTER DATABASE [22 вариант (Врачи поликлиники, больные, прием больных)] SET  READ_WRITE 
GO
