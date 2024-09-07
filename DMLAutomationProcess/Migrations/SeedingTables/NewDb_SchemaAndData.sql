USE [master]
GO
/****** Object:  Database [DDLAutomationProcess]    Script Date: 07-09-2024 21:12:47 ******/
CREATE DATABASE [DDLAutomationProcess]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DDLAutomationProcess', FILENAME = N'C:\Users\VenkateswaraoMokka\AppData\Local\Microsoft\VisualStudio\SSDT\DbUpForDML\DDLAutomationProcess.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DDLAutomationProcess_log', FILENAME = N'C:\Users\VenkateswaraoMokka\AppData\Local\Microsoft\VisualStudio\SSDT\DbUpForDML\DDLAutomationProcess.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DDLAutomationProcess] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DDLAutomationProcess].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DDLAutomationProcess] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [DDLAutomationProcess] SET ANSI_NULLS ON 
GO
ALTER DATABASE [DDLAutomationProcess] SET ANSI_PADDING ON 
GO
ALTER DATABASE [DDLAutomationProcess] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [DDLAutomationProcess] SET ARITHABORT OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DDLAutomationProcess] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DDLAutomationProcess] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [DDLAutomationProcess] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DDLAutomationProcess] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DDLAutomationProcess] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DDLAutomationProcess] SET  MULTI_USER 
GO
ALTER DATABASE [DDLAutomationProcess] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DDLAutomationProcess] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DDLAutomationProcess] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DDLAutomationProcess] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DDLAutomationProcess] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DDLAutomationProcess] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DDLAutomationProcess] SET QUERY_STORE = OFF
GO
USE [DDLAutomationProcess]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgeType]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgeType](
	[AgeTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AgeType] PRIMARY KEY CLUSTERED 
(
	[AgeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Discriminator] [nvarchar](21) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[IPAddress] [nvarchar](max) NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[Discriminator] [nvarchar](21) NOT NULL,
	[UserId] [int] NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[IsActive] [bit] NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
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
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BloodGroup]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloodGroup](
	[BloodGroupID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BloodGroup] PRIMARY KEY CLUSTERED 
(
	[BloodGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DaywiseSchedule]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DaywiseSchedule](
	[DayID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Day] PRIMARY KEY CLUSTERED 
(
	[DayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepartmentDayUnitMapping]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentDayUnitMapping](
	[DepartmentDayUnitMappingID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[DayID] [int] NOT NULL,
	[UnitID] [int] NOT NULL,
 CONSTRAINT [PK_DepartmentDayUnitMapping] PRIMARY KEY CLUSTERED 
(
	[DepartmentDayUnitMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[District]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[District](
	[DistrictID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[StateID] [int] NOT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeeType]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeeType](
	[FeeTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_FeeType] PRIMARY KEY CLUSTERED 
(
	[FeeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IDProofType]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IDProofType](
	[IDProofTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_IDProofType] PRIMARY KEY CLUSTERED 
(
	[IDProofTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mandal]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mandal](
	[MandalID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DistrictID] [int] NOT NULL,
 CONSTRAINT [PK_Mandal] PRIMARY KEY CLUSTERED 
(
	[MandalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaritalStatus]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaritalStatus](
	[MaritalStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MaritalStatus] PRIMARY KEY CLUSTERED 
(
	[MaritalStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewOpDummy]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewOpDummy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UHID] [nvarchar](50) NOT NULL,
	[OPID] [nvarchar](50) NOT NULL,
	[visitDate] [datetime] NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[UnitID] [int] NOT NULL,
	[DoctorID] [int] NOT NULL,
	[Gender] [nvarchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OPRegistration]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OPRegistration](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[OPID] [nvarchar](20) NOT NULL,
	[VisitDate] [datetime2](7) NOT NULL,
	[IsMlcCase] [bit] NULL,
	[IsEmergencyCase] [bit] NULL,
	[DepartmentID] [int] NULL,
	[DoctorID] [int] NULL,
	[SpecialityID] [int] NULL,
	[FeeTypeID] [int] NULL,
	[ReferredBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_OPRegistration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UHID] [nvarchar](20) NOT NULL,
	[AadhaarNo] [bigint] NULL,
	[GenderID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FatherName] [nvarchar](50) NOT NULL,
	[HusbandName] [nvarchar](50) NULL,
	[PrefixID] [int] NOT NULL,
	[MaritalStatusID] [int] NOT NULL,
	[Age] [int] NOT NULL,
	[AgeTypeID] [int] NOT NULL,
	[DOB] [datetime2](7) NULL,
	[MobileNumber] [bigint] NULL,
	[AlternateMobileNumber] [bigint] NULL,
	[Email] [nvarchar](100) NULL,
	[ReligionID] [int] NULL,
	[Caste] [nvarchar](50) NULL,
	[BloodGroupID] [int] NULL,
	[IDProofTypeID] [int] NULL,
	[IDProof] [nvarchar](50) NULL,
	[AbhaNo] [bigint] NULL,
	[PatientTypeID] [int] NULL,
	[VillageID] [int] NULL,
	[CreatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientAddress]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientAddress](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[Village] [nvarchar](100) NOT NULL,
	[Mandal] [nvarchar](100) NOT NULL,
	[District] [nvarchar](100) NOT NULL,
	[State] [nvarchar](100) NOT NULL,
	[PinCode] [int] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_PatientAddress] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientType]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientType](
	[PatientTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PatientType] PRIMARY KEY CLUSTERED 
(
	[PatientTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prefix]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prefix](
	[PrefixID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[GenderID] [int] NULL,
 CONSTRAINT [PK_Prefix] PRIMARY KEY CLUSTERED 
(
	[PrefixID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Religion]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Religion](
	[ReligionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Religion] PRIMARY KEY CLUSTERED 
(
	[ReligionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RevisitOpDummy]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RevisitOpDummy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UHID] [nvarchar](50) NOT NULL,
	[OPID] [nvarchar](50) NOT NULL,
	[visitDate] [datetime] NOT NULL,
	[departmentId] [int] NOT NULL,
	[unitId] [int] NOT NULL,
	[gender] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Speciality]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Speciality](
	[SpecialityID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Speciality] PRIMARY KEY CLUSTERED 
(
	[SpecialityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[State]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[UnitID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitDoctorMapping]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitDoctorMapping](
	[UnitDoctorMappingID] [int] IDENTITY(1,1) NOT NULL,
	[UnitID] [int] NOT NULL,
	[DoctorID] [int] NOT NULL,
 CONSTRAINT [PK_UnitDoctorMapping] PRIMARY KEY CLUSTERED 
(
	[UnitDoctorMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Village]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Village](
	[VillageID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[MandalID] [int] NOT NULL,
	[Pincode] [int] NOT NULL,
 CONSTRAINT [PK_Village] PRIMARY KEY CLUSTERED 
(
	[VillageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240903093142_InitialContext', N'8.0.4')
GO
SET IDENTITY_INSERT [dbo].[AgeType] ON 

INSERT [dbo].[AgeType] ([AgeTypeID], [Name]) VALUES (1, N'Years')
INSERT [dbo].[AgeType] ([AgeTypeID], [Name]) VALUES (2, N'Months')
INSERT [dbo].[AgeType] ([AgeTypeID], [Name]) VALUES (3, N'Days')
SET IDENTITY_INSERT [dbo].[AgeType] OFF
GO
INSERT [dbo].[AspNetRoles] ([Id], [Discriminator], [Description], [CreatedDate], [IPAddress], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'ad550101-3fca-4af4-bf41-6a2cf0072bec', N'ApplicationRole', NULL, CAST(N'2024-08-30T08:30:10.3386152' AS DateTime2), NULL, N'Admin', N'ADMIN', NULL)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ad550101-3fca-4af4-bf41-6a2cf0072bec')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserId], [Name], [CreatedDate], [IsActive], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ApplicationUser', NULL, N'venkat', CAST(N'2024-08-30T08:30:12.7096760' AS DateTime2), 1, N'venkat', N'VENKAT', N'venkat@gmail.com', N'VENKAT@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEFdFfwXm11KI+50x2q377YsYc/hTQSRS8X/1b6KkZ+toQ8L1IgIJDBG34ZIe1posag==', N'WY2XTFLOSDQMZL5NYCICUF5NKUDLEQPE', N'b8ab023c-e5a0-4926-b72c-25eda7b3616b', NULL, 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[BloodGroup] ON 

INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (1, N'Unknown')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (2, N'A+ve')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (3, N'B+ve')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (4, N'AB+ve')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (5, N'O+ve')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (6, N'A-ve')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (7, N'B-ve')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (8, N'AB-ve')
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (9, N'O-ve')
SET IDENTITY_INSERT [dbo].[BloodGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[DaywiseSchedule] ON 

INSERT [dbo].[DaywiseSchedule] ([DayID], [Name]) VALUES (1, N'SUN')
INSERT [dbo].[DaywiseSchedule] ([DayID], [Name]) VALUES (2, N'MON')
INSERT [dbo].[DaywiseSchedule] ([DayID], [Name]) VALUES (3, N'TUE')
INSERT [dbo].[DaywiseSchedule] ([DayID], [Name]) VALUES (4, N'WED')
INSERT [dbo].[DaywiseSchedule] ([DayID], [Name]) VALUES (5, N'THU')
INSERT [dbo].[DaywiseSchedule] ([DayID], [Name]) VALUES (6, N'FRI')
INSERT [dbo].[DaywiseSchedule] ([DayID], [Name]) VALUES (7, N'SAT')
SET IDENTITY_INSERT [dbo].[DaywiseSchedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (1, N'Casualty')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (2, N'Dental')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (3, N'Dvl')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (4, N'Ent')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (5, N'General Medicine')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (6, N'General Surgery')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (7, N'Gynecology')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (8, N'Obstetrics')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (9, N'Ophthalmology')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (10, N'Orthopaedics')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (11, N'Paediatrics')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (12, N'Respiratory Medicine')
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (13, N'Psychiatry')
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[DepartmentDayUnitMapping] ON 

INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (1, 1, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (2, 2, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (3, 3, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (4, 4, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (5, 5, 1, 7)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (6, 6, 1, 7)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (7, 7, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (8, 8, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (9, 9, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (10, 10, 1, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (11, 11, 1, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (12, 12, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (13, 13, 1, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (14, 1, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (15, 2, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (16, 3, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (17, 4, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (18, 5, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (19, 5, 2, 5)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (20, 6, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (21, 6, 2, 5)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (22, 7, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (23, 8, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (24, 9, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (25, 10, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (26, 11, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (27, 12, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (28, 13, 2, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (29, 1, 3, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (30, 2, 3, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (31, 3, 3, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (32, 4, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (33, 5, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (34, 5, 3, 6)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (35, 6, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (36, 6, 3, 6)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (37, 7, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (38, 8, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (39, 9, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (40, 10, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (41, 11, 3, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (42, 12, 3, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (43, 13, 3, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (44, 1, 4, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (45, 2, 4, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (46, 3, 4, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (47, 4, 4, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (48, 5, 4, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (49, 5, 4, 7)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (50, 6, 4, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (51, 6, 4, 7)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (52, 7, 4, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (53, 8, 4, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (54, 9, 4, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (55, 10, 4, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (56, 11, 4, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (57, 12, 4, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (58, 13, 4, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (59, 1, 5, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (60, 2, 5, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (61, 3, 5, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (62, 4, 5, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (63, 5, 5, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (64, 5, 5, 8)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (65, 6, 5, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (66, 6, 5, 8)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (67, 7, 5, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (68, 8, 5, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (69, 9, 5, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (70, 10, 5, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (71, 11, 5, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (72, 12, 5, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (73, 13, 5, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (74, 1, 6, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (75, 2, 6, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (76, 3, 6, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (77, 4, 6, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (78, 5, 6, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (79, 5, 6, 7)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (80, 6, 6, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (81, 6, 6, 7)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (82, 7, 6, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (83, 8, 6, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (84, 9, 6, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (85, 10, 6, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (86, 11, 6, 3)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (87, 12, 6, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (88, 13, 6, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (89, 1, 7, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (90, 2, 7, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (91, 3, 7, 1)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (92, 4, 7, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (93, 5, 7, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (94, 5, 7, 8)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (95, 6, 7, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (96, 6, 7, 8)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (97, 7, 7, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (98, 8, 7, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (99, 9, 7, 2)
GO
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (100, 10, 7, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (101, 11, 7, 4)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (102, 12, 7, 2)
INSERT [dbo].[DepartmentDayUnitMapping] ([DepartmentDayUnitMappingID], [DepartmentID], [DayID], [UnitID]) VALUES (103, 13, 7, 2)
SET IDENTITY_INSERT [dbo].[DepartmentDayUnitMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[District] ON 

INSERT [dbo].[District] ([DistrictID], [Name], [StateID]) VALUES (1, N'Medchal Malkajgiri', 1)
INSERT [dbo].[District] ([DistrictID], [Name], [StateID]) VALUES (2, N'Hyderabad', 1)
INSERT [dbo].[District] ([DistrictID], [Name], [StateID]) VALUES (3, N'Visakhapatnam', 2)
SET IDENTITY_INSERT [dbo].[District] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctor] ON 

INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (2, N'Dr.Thandra Ramoji Babu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (3, N'Dr.Karishma')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (4, N'Dr.Sree Karthik Pratapa')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (5, N'Dr.Sriramula Yamini')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (6, N'Dr.Ketavath Kiran Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (7, N'Dr.Aditya Chakravarthula')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (8, N'Dr.Elabaka Munisahith Sharma')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (9, N'Dr.Thakur Abhijeet Singh')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (10, N'Dr.Damera Mounika')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (11, N'Dr.Satla Rakhesh Goud')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (12, N'Dr.Dontha Mahesh Netha')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (13, N'Dr.Puskoor Tharun')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (14, N'Dr.V Akhila')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (15, N'Dr.Kondu Mounika')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (16, N'Dr.Rajesh Ganta')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (17, N'Dr.Yarlagadda Srinivas Rao')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (18, N'Dr.RamadugUNIT - Venkat Chanakya')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (19, N'Dr.Aluguvelly Suresh Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (20, N'Dr.Pagadala Tejaswi')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (21, N'Dr.Chinthala Navyasree')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (22, N'Dr.Gone Vamshi Krishna')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (23, N'Dr.K Anil Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (24, N'Dr.Sreeperumbuduri Ashok')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (25, N'Dr.Cheripally Rajashekar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (26, N'Dr.G Abhinav Kumar Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (27, N'Dr.Koneru Siri')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (28, N'Dr.Kondle Kranti')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (29, N'Dr.Dugyala Dinesh')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (30, N'Dr.Marepally Nitin Rao')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (31, N'Dr.Bharath S')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (32, N'Dr.Aluru Mithra Vindha')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (33, N'Dr.Vadlamani M S R Srinivas')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (34, N'Dr.Bommidi Kranthi')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (35, N'Dr.Korra Niharika')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (36, N'Dr.Surendhar Guguloth')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (37, N'Dr.Dande Nagendra')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (38, N'Dr.Pothuganti Durga Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (39, N'Dr.Kotha Jyothsnapriya')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (40, N'Dr.Guda Raj Kamal')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (41, N'Dr.Pusarla Naga Sai Laxmi')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (42, N'Dr.Sappidi Nikitha')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (43, N'Dr.Akasapu Bhagavan')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (44, N'Dr.Akila Sree Gowri')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (45, N'Dr.Allada Nagaraju')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (46, N'Dr.Ambi Sambasiva Rao')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (47, N'Dr.Archana Santosh Jain')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (48, N'Dr.Ashok Rao Matety')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (49, N'Dr.B Tejasree')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (50, N'Dr.Baddam Mounika Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (51, N'Dr.Bandari Dheeraj')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (52, N'Dr.Bathula Deepthi')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (53, N'Dr.BattUNIT - VIjayeswar Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (54, N'Dr.Bendram Phaninder Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (55, N'Dr.Bolgam Suvarna')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (56, N'Dr.Bolgam Vijaya Bhasker')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (57, N'Dr.Bommineni Sashidhar Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (58, N'Dr.Buyyani Priyanka')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (59, N'Dr.Challa Pooja Rani')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (60, N'Dr.Chelikani Kavitha')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (61, N'Dr.Chetan Bhavan Mahajan')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (62, N'Dr.Chetaraju Ravikiran')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (63, N'Dr.Chidugulla Suresh Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (64, N'Dr.Chinthala Narsaiah')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (65, N'Dr.Davu Hema')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (66, N'Dr.Devunuri Sravya')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (67, N'Dr.Dinesh Singh Chauhan R')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (68, N'Dr.Sudigali Sunanda')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (69, N'Dr.Alishala Lingam')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (70, N'Dr.Arshad Hussain')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (71, N'Dr.Kusuma Purushotham')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (72, N'Dr.Mahender Muthyapu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (73, N'Dr.Mulukoju Ravindra Chary')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (74, N'Dr.Patnala Vijaya')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (75, N'Dr.Uppu Kishan')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (76, N'Dr.Vamshi Krishna Biroj')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (77, N'Dr.Dubakunta Manjula')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (78, N'Dr.G.Dayanand')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (79, N'Dr.GadagottUNIT - Vaishnavi')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (80, N'Dr.Gadapaga Venkatesh')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (81, N'Dr.Gandra Aravind')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (82, N'Dr.Ganesh Nallagonda')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (83, N'Dr.Ganganamoni Raja Mohan')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (84, N'Dr.Gautam Panduranga')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (85, N'Dr.Gogineni Divya Chowdary')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (86, N'Dr.Gopi Krishna Amaravadi')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (87, N'Dr.Gouthami Padugundla')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (88, N'Dr.Gudiyella Sukumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (89, N'Dr.Gummi Mamatha Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (90, N'Dr.Gundla Vamshi Krishna')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (91, N'Dr.Itha Lingamurthy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (92, N'Dr.Janaswamy Vishwanath')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (93, N'Dr.K Mrudula')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (94, N'Dr.Kamisetty Kishorekumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (95, N'Dr.Kamtala Ramu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (96, N'Dr.Kamuni Narsimloo')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (97, N'Dr.Kandala Shivaraj Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (98, N'Dr.Kandula Venkat')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (99, N'Dr.Kankanampati Venkata Mounika')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (100, N'Dr.Kanmantha Reddy Sriharsha')
GO
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (101, N'Dr.Karumuru Kiran Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (102, N'Dr.Kasturi Ashwin')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (103, N'Dr.Kasturi Swetha')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (104, N'Dr.Katkam Avinash')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (105, N'Dr.Katti Alekya')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (106, N'Dr.Kethawath Kavitha')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (107, N'Dr.Kilambi Srinivas')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (108, N'Dr.Kodidela Jahnavi')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (109, N'Dr.Kolan Sai Raghava Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (110, N'Dr.Kompella Abhijna Rao')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (111, N'Dr.Konatham Hari Babu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (112, N'Dr.Kondaveeti Sai Kanth Sharma')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (113, N'Dr.Kondle Vamshi Krishna')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (114, N'Dr.Koriginja Rajeshwar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (115, N'Dr.Kotagiri Ravikanth')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (116, N'Dr.Kotha Prem Kishore')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (117, N'Dr.Kurimilla Ramesh')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (118, N'Dr.Kusuma Siva Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (119, N'Dr.M Bhagyashree')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (120, N'Dr.Madhava Nachagiri')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (121, N'Dr.Mahadeva Jhansi Mani')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (122, N'Dr.Mahesh Neginhal')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (123, N'Dr.Mamidala Suneeth Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (124, N'Dr.Manchala Karthik')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (125, N'Dr.Manchikatla Ramulu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (126, N'Dr.Manideep Malaka')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (127, N'Dr.Mayakuntla Nitesh Sai')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (128, N'Dr.Memba Bala Vikas Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (129, N'Dr.Mooga Swetcha')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (130, N'Dr.Mundrathi Ravikumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (131, N'Dr.Murali Mohan Gurram')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (132, N'Dr.Nagelli Samuel')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (133, N'Dr.Nakkarkanti Shivakoti Vasu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (134, N'Dr.Nampally Prashanth')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (135, N'Dr.Nathani Arif Aziz')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (136, N'Dr.Nathani Manisha Arif')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (137, N'Dr.Navneeth Servey')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (138, N'Dr.Neelaboina Vasudeva Rayudu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (139, N'Dr.Paka Rajanna Rajender')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (140, N'Dr.Pamulapati Sasidhar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (141, N'Dr.Panchmahalkar Anand')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (142, N'Dr.Penugonda Chandra Sekhar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (143, N'Dr.PesarUNIT - VIjaya Chander Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (144, N'Dr.Pilli Padma')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (145, N'Dr.Polu Sasikanth Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (146, N'Dr.Poosa Suresh Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (147, N'Dr.Poreddi Mahesh Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (148, N'Dr.Produtur Rukmini Reddy')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (149, N'Dr.Raghava Aditya Kalvala')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (150, N'Dr.Rallabandi Penta Chary')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (151, N'Dr.Rama Ashok')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (152, N'Dr.Rathlawath Swapna')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (153, N'Dr.Rodda Suma')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (154, N'Dr.S Kapil Sai')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (155, N'Dr.Saai Ram Thejas B S')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (156, N'Dr.Sainath Reddy Manda')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (157, N'Dr.Shaik Mohammed Anjum')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (158, N'Dr.Siva Sankar Nunna')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (159, N'Dr.Sumitra Devi Adepu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (160, N'Dr.Suresh Dantoor')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (161, N'Dr.Surya Nunavath')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (162, N'Dr.Talla Srinivas')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (163, N'Dr.Talluri Suresh Babu')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (164, N'Dr.Uppu Krishnam Raju')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (165, N'Dr.V Ranjith Kumar Kota')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (166, N'Dr.Valluri Sowmya Choudri')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (167, N'Dr.VamarajUNIT - Venkata Krishna Bharadwaja')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (168, N'Dr.Vanama Lavya Kumar')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (169, N'Dr.Veera Divya')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (170, N'Dr.Vemula Usharani')
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (171, N'Dr.Venkateswar Reddy Vaddula')
SET IDENTITY_INSERT [dbo].[Doctor] OFF
GO
SET IDENTITY_INSERT [dbo].[FeeType] ON 

INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (1, N'Free')
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (2, N'Cash')
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (3, N'Credit')
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (4, N'FeeTypes')
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (5, N'Aarogyasri')
SET IDENTITY_INSERT [dbo].[FeeType] OFF
GO
SET IDENTITY_INSERT [dbo].[Gender] ON 

INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (1, N'Male')
INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (2, N'Female')
INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (3, N'Transgender')
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO
SET IDENTITY_INSERT [dbo].[IDProofType] ON 

INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (1, N'Unknown')
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (2, N'VOTER ID')
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (3, N'PAN CARD')
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (4, N'DRIVING LICENCE')
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (5, N'AAROGYASRI CARD')
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (6, N'RATION CARD')
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (7, N'PASSPORT')
SET IDENTITY_INSERT [dbo].[IDProofType] OFF
GO
SET IDENTITY_INSERT [dbo].[Mandal] ON 

INSERT [dbo].[Mandal] ([MandalID], [Name], [DistrictID]) VALUES (1, N'Medchal', 1)
INSERT [dbo].[Mandal] ([MandalID], [Name], [DistrictID]) VALUES (2, N'Shameerpet', 1)
INSERT [dbo].[Mandal] ([MandalID], [Name], [DistrictID]) VALUES (3, N'Bheemili', 2)
SET IDENTITY_INSERT [dbo].[Mandal] OFF
GO
SET IDENTITY_INSERT [dbo].[MaritalStatus] ON 

INSERT [dbo].[MaritalStatus] ([MaritalStatusID], [Name]) VALUES (1, N'Unknown')
INSERT [dbo].[MaritalStatus] ([MaritalStatusID], [Name]) VALUES (2, N'Married')
INSERT [dbo].[MaritalStatus] ([MaritalStatusID], [Name]) VALUES (3, N'Single')
SET IDENTITY_INSERT [dbo].[MaritalStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[NewOpDummy] ON 

INSERT [dbo].[NewOpDummy] ([ID], [UHID], [OPID], [visitDate], [DepartmentID], [UnitID], [DoctorID], [Gender]) VALUES (1, N'202409070001', N'OP.2409070001', CAST(N'2024-09-07T21:02:44.000' AS DateTime), 5, 8, 142, N'M')
SET IDENTITY_INSERT [dbo].[NewOpDummy] OFF
GO
SET IDENTITY_INSERT [dbo].[OPRegistration] ON 

INSERT [dbo].[OPRegistration] ([ID], [PatientID], [OPID], [VisitDate], [IsMlcCase], [IsEmergencyCase], [DepartmentID], [DoctorID], [SpecialityID], [FeeTypeID], [ReferredBy], [CreatedDate], [IsActive]) VALUES (1, 1, N'OP.2409040001', CAST(N'2024-09-05T07:48:26.0000000' AS DateTime2), NULL, NULL, 5, 19, 1, 1, N'Self', CAST(N'2024-09-05T07:49:38.9333333' AS DateTime2), 1)
INSERT [dbo].[OPRegistration] ([ID], [PatientID], [OPID], [VisitDate], [IsMlcCase], [IsEmergencyCase], [DepartmentID], [DoctorID], [SpecialityID], [FeeTypeID], [ReferredBy], [CreatedDate], [IsActive]) VALUES (2, 1, N'OP.2409050001', CAST(N'2024-09-05T07:51:32.0000000' AS DateTime2), NULL, NULL, 2, 78, 1, 1, N'Self', CAST(N'2024-09-05T07:53:05.9833333' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[OPRegistration] OFF
GO
SET IDENTITY_INSERT [dbo].[Patient] ON 

INSERT [dbo].[Patient] ([ID], [UHID], [AadhaarNo], [GenderID], [FirstName], [MiddleName], [LastName], [FatherName], [HusbandName], [PrefixID], [MaritalStatusID], [Age], [AgeTypeID], [DOB], [MobileNumber], [AlternateMobileNumber], [Email], [ReligionID], [Caste], [BloodGroupID], [IDProofTypeID], [IDProof], [AbhaNo], [PatientTypeID], [VillageID], [CreatedDate]) VALUES (1, N'202409050001', 529801020967, 1, N'Mokka', NULL, N'Venkateswarao', N'Chinna Krishna', NULL, 1, 2, 35, 1, CAST(N'1989-09-05T00:00:00.0000000' AS DateTime2), 9985071515, NULL, NULL, 2, N'BC-B', 2, 1, NULL, NULL, 1, 1, CAST(N'2024-09-05T07:49:38.9287250' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Patient] OFF
GO
SET IDENTITY_INSERT [dbo].[PatientType] ON 

INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (1, N'General')
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (2, N'Camp')
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (3, N'Staff')
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (4, N'Aarogyasri')
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (5, N'Student')
SET IDENTITY_INSERT [dbo].[PatientType] OFF
GO
SET IDENTITY_INSERT [dbo].[Prefix] ON 

INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (1, N'Mr.', 1)
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (2, N'Mrs.', 2)
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (3, N'Miss', 2)
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (4, N'Dr.', 2)
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (5, N'Master', 1)
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (6, N'Baby', 1)
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (7, N'Baby of', NULL)
SET IDENTITY_INSERT [dbo].[Prefix] OFF
GO
SET IDENTITY_INSERT [dbo].[Religion] ON 

INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (1, N'Unknown')
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (2, N'Hindu')
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (3, N'Muslim')
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (4, N'Christian')
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (5, N'Others')
SET IDENTITY_INSERT [dbo].[Religion] OFF
GO
SET IDENTITY_INSERT [dbo].[RevisitOpDummy] ON 

INSERT [dbo].[RevisitOpDummy] ([ID], [UHID], [OPID], [visitDate], [departmentId], [unitId], [gender]) VALUES (1, N'202409050001', N'OP.2409070001', CAST(N'2024-09-07T21:03:18.000' AS DateTime), 5, 4, N'Male')
SET IDENTITY_INSERT [dbo].[RevisitOpDummy] OFF
GO
SET IDENTITY_INSERT [dbo].[Speciality] ON 

INSERT [dbo].[Speciality] ([SpecialityID], [Name]) VALUES (1, N'General medicine - Cardiology')
INSERT [dbo].[Speciality] ([SpecialityID], [Name]) VALUES (4, N'General medicine - Gastroenterology')
INSERT [dbo].[Speciality] ([SpecialityID], [Name]) VALUES (5, N'General Surgery - Urology')
INSERT [dbo].[Speciality] ([SpecialityID], [Name]) VALUES (6, N'Orthopedics - Neuro Surgery')
SET IDENTITY_INSERT [dbo].[Speciality] OFF
GO
SET IDENTITY_INSERT [dbo].[State] ON 

INSERT [dbo].[State] ([StateID], [Name]) VALUES (1, N'Telangana')
INSERT [dbo].[State] ([StateID], [Name]) VALUES (2, N'Andhra Pradesh')
SET IDENTITY_INSERT [dbo].[State] OFF
GO
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (1, N'UNIT - I')
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (2, N'UNIT - II')
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (3, N'UNIT - III')
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (4, N'UNIT - IV')
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (5, N'UNIT - V')
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (6, N'UNIT - VI')
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (7, N'UNIT - VII')
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (8, N'UNIT - VIII')
SET IDENTITY_INSERT [dbo].[Unit] OFF
GO
SET IDENTITY_INSERT [dbo].[UnitDoctorMapping] ON 

INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (1, 1, 2)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (2, 1, 3)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (3, 1, 4)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (4, 1, 5)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (5, 1, 6)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (6, 1, 7)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (7, 1, 13)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (8, 1, 14)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (9, 1, 18)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (10, 1, 20)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (11, 1, 26)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (12, 1, 27)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (13, 1, 29)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (14, 1, 34)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (15, 2, 8)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (16, 2, 10)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (17, 2, 11)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (18, 2, 19)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (19, 2, 21)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (20, 2, 23)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (21, 3, 12)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (22, 3, 15)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (23, 3, 17)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (24, 3, 24)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (25, 3, 25)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (26, 4, 16)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (27, 4, 22)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (28, 4, 28)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (29, 4, 30)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (30, 4, 33)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (31, 5, 31)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (32, 5, 32)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (33, 5, 36)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (34, 6, 92)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (35, 6, 109)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (36, 6, 167)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (37, 6, 88)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (38, 6, 125)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (39, 6, 38)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (40, 6, 41)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (41, 6, 78)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (42, 7, 99)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (43, 7, 111)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (44, 7, 168)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (45, 7, 108)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (46, 7, 128)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (47, 7, 39)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (48, 7, 80)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (49, 7, 112)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (50, 8, 116)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (51, 8, 162)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (52, 8, 171)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (53, 8, 117)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (54, 8, 98)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (55, 8, 100)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (56, 1, 2)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (57, 1, 3)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (58, 1, 4)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (59, 1, 5)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (60, 1, 6)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (61, 1, 7)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (62, 1, 13)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (63, 1, 14)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (64, 1, 18)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (65, 1, 20)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (66, 1, 26)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (67, 1, 27)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (68, 1, 29)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (69, 1, 34)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (70, 2, 8)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (71, 2, 10)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (72, 2, 11)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (73, 2, 19)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (74, 2, 21)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (75, 2, 23)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (76, 3, 12)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (77, 3, 15)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (78, 3, 17)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (79, 3, 24)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (80, 3, 25)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (81, 4, 16)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (82, 4, 22)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (83, 4, 28)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (84, 4, 30)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (85, 4, 33)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (86, 5, 31)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (87, 5, 32)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (88, 1, 85)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (89, 1, 86)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (90, 1, 89)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (91, 1, 94)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (92, 1, 96)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (93, 1, 103)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (94, 1, 104)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (95, 1, 119)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (96, 1, 122)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (97, 1, 123)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (98, 1, 131)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (99, 1, 132)
GO
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (100, 1, 133)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (101, 1, 134)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (102, 1, 137)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (103, 1, 34)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (104, 2, 101)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (105, 2, 102)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (106, 2, 106)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (107, 2, 110)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (108, 2, 115)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (109, 2, 112)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (110, 2, 120)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (111, 2, 126)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (112, 2, 129)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (113, 2, 130)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (114, 3, 87)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (115, 3, 95)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (116, 3, 135)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (117, 3, 143)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (118, 3, 12)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (119, 3, 17)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (120, 3, 24)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (121, 3, 25)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (122, 4, 84)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (123, 4, 91)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (124, 4, 93)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (125, 4, 97)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (126, 4, 107)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (127, 4, 33)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (128, 5, 105)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (129, 5, 118)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (130, 5, 31)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (131, 5, 32)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (132, 5, 90)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (133, 6, 88)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (134, 6, 92)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (135, 6, 125)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (136, 6, 109)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (137, 7, 111)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (138, 7, 99)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (142, 8, 98)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (143, 8, 114)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (144, 1, 138)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (145, 1, 148)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (146, 1, 151)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (147, 1, 155)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (148, 1, 156)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (149, 1, 159)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (150, 1, 160)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (151, 1, 161)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (152, 1, 163)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (153, 1, 164)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (154, 2, 141)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (155, 2, 146)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (156, 2, 154)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (157, 3, 140)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (158, 3, 143)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (159, 3, 144)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (160, 3, 147)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (161, 3, 149)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (162, 3, 157)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (163, 4, 139)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (164, 4, 142)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (165, 4, 152)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (166, 4, 158)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (167, 4, 166)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (168, 4, 169)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (169, 5, 145)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (170, 5, 150)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (171, 5, 165)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (172, 5, 170)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (173, 6, 167)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (174, 6, 88)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (175, 6, 92)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (176, 6, 109)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (182, 8, 98)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (183, 8, 114)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (184, 8, 116)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (185, 8, 117)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (186, 8, 162)
INSERT [dbo].[UnitDoctorMapping] ([UnitDoctorMappingID], [UnitID], [DoctorID]) VALUES (187, 8, 171)
SET IDENTITY_INSERT [dbo].[UnitDoctorMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Village] ON 

INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (1, N'Medchal', 1, 501401)
INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (2, N'Shameerpet', 2, 500078)
INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (3, N'Bheemili', 3, 531162)
SET IDENTITY_INSERT [dbo].[Village] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 07-09-2024 21:12:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 07-09-2024 21:12:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DepartmentDayUnitMapping_DayID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_DepartmentDayUnitMapping_DayID] ON [dbo].[DepartmentDayUnitMapping]
(
	[DayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DepartmentDayUnitMapping_DepartmentID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_DepartmentDayUnitMapping_DepartmentID] ON [dbo].[DepartmentDayUnitMapping]
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DepartmentDayUnitMapping_UnitID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_DepartmentDayUnitMapping_UnitID] ON [dbo].[DepartmentDayUnitMapping]
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_District_StateID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_District_StateID] ON [dbo].[District]
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Mandal_DistrictID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Mandal_DistrictID] ON [dbo].[Mandal]
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_DepartmentID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_DepartmentID] ON [dbo].[OPRegistration]
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_FeeTypeID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_FeeTypeID] ON [dbo].[OPRegistration]
(
	[FeeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_PatientID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_PatientID] ON [dbo].[OPRegistration]
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_SpecialityID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_SpecialityID] ON [dbo].[OPRegistration]
(
	[SpecialityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_AgeTypeID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_AgeTypeID] ON [dbo].[Patient]
(
	[AgeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_BloodGroupID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_BloodGroupID] ON [dbo].[Patient]
(
	[BloodGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_GenderID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_GenderID] ON [dbo].[Patient]
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_IDProofTypeID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_IDProofTypeID] ON [dbo].[Patient]
(
	[IDProofTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_MaritalStatusID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_MaritalStatusID] ON [dbo].[Patient]
(
	[MaritalStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_PatientTypeID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_PatientTypeID] ON [dbo].[Patient]
(
	[PatientTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_PrefixID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_PrefixID] ON [dbo].[Patient]
(
	[PrefixID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_ReligionID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_ReligionID] ON [dbo].[Patient]
(
	[ReligionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_VillageID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_VillageID] ON [dbo].[Patient]
(
	[VillageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Prefix_GenderID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Prefix_GenderID] ON [dbo].[Prefix]
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__RevisitO__AE2CBE1FE7B8543C]    Script Date: 07-09-2024 21:12:47 ******/
ALTER TABLE [dbo].[RevisitOpDummy] ADD UNIQUE NONCLUSTERED 
(
	[OPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UnitDoctorMapping_DoctorID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_UnitDoctorMapping_DoctorID] ON [dbo].[UnitDoctorMapping]
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UnitDoctorMapping_UnitID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_UnitDoctorMapping_UnitID] ON [dbo].[UnitDoctorMapping]
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Village_MandalID]    Script Date: 07-09-2024 21:12:47 ******/
CREATE NONCLUSTERED INDEX [IX_Village_MandalID] ON [dbo].[Village]
(
	[MandalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[DepartmentDayUnitMapping]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentDayUnitMapping_Day_DayID] FOREIGN KEY([DayID])
REFERENCES [dbo].[DaywiseSchedule] ([DayID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DepartmentDayUnitMapping] CHECK CONSTRAINT [FK_DepartmentDayUnitMapping_Day_DayID]
GO
ALTER TABLE [dbo].[DepartmentDayUnitMapping]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentDayUnitMapping_Department_DepartmentID] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DepartmentDayUnitMapping] CHECK CONSTRAINT [FK_DepartmentDayUnitMapping_Department_DepartmentID]
GO
ALTER TABLE [dbo].[DepartmentDayUnitMapping]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentDayUnitMapping_Unit_UnitID] FOREIGN KEY([UnitID])
REFERENCES [dbo].[Unit] ([UnitID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DepartmentDayUnitMapping] CHECK CONSTRAINT [FK_DepartmentDayUnitMapping_Unit_UnitID]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_State_StateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([StateID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_State_StateID]
GO
ALTER TABLE [dbo].[Mandal]  WITH CHECK ADD  CONSTRAINT [FK_Mandal_District_DistrictID] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[District] ([DistrictID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Mandal] CHECK CONSTRAINT [FK_Mandal_District_DistrictID]
GO
ALTER TABLE [dbo].[OPRegistration]  WITH CHECK ADD  CONSTRAINT [FK_OPRegistration_Department_DepartmentID] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[OPRegistration] CHECK CONSTRAINT [FK_OPRegistration_Department_DepartmentID]
GO
ALTER TABLE [dbo].[OPRegistration]  WITH CHECK ADD  CONSTRAINT [FK_OPRegistration_Doctor] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctor] ([DoctorID])
GO
ALTER TABLE [dbo].[OPRegistration] CHECK CONSTRAINT [FK_OPRegistration_Doctor]
GO
ALTER TABLE [dbo].[OPRegistration]  WITH CHECK ADD  CONSTRAINT [FK_OPRegistration_FeeType_FeeTypeID] FOREIGN KEY([FeeTypeID])
REFERENCES [dbo].[FeeType] ([FeeTypeID])
GO
ALTER TABLE [dbo].[OPRegistration] CHECK CONSTRAINT [FK_OPRegistration_FeeType_FeeTypeID]
GO
ALTER TABLE [dbo].[OPRegistration]  WITH CHECK ADD  CONSTRAINT [FK_OPRegistration_Patient_PatientID] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OPRegistration] CHECK CONSTRAINT [FK_OPRegistration_Patient_PatientID]
GO
ALTER TABLE [dbo].[OPRegistration]  WITH CHECK ADD  CONSTRAINT [FK_OPRegistration_Speciality_SpecialityID] FOREIGN KEY([SpecialityID])
REFERENCES [dbo].[Speciality] ([SpecialityID])
GO
ALTER TABLE [dbo].[OPRegistration] CHECK CONSTRAINT [FK_OPRegistration_Speciality_SpecialityID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_AgeType_AgeTypeID] FOREIGN KEY([AgeTypeID])
REFERENCES [dbo].[AgeType] ([AgeTypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_AgeType_AgeTypeID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_BloodGroup_BloodGroupID] FOREIGN KEY([BloodGroupID])
REFERENCES [dbo].[BloodGroup] ([BloodGroupID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_BloodGroup_BloodGroupID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Gender_GenderID] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Gender_GenderID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_IDProofType_IDProofTypeID] FOREIGN KEY([IDProofTypeID])
REFERENCES [dbo].[IDProofType] ([IDProofTypeID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_IDProofType_IDProofTypeID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_MaritalStatus_MaritalStatusID] FOREIGN KEY([MaritalStatusID])
REFERENCES [dbo].[MaritalStatus] ([MaritalStatusID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_MaritalStatus_MaritalStatusID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_PatientType_PatientTypeID] FOREIGN KEY([PatientTypeID])
REFERENCES [dbo].[PatientType] ([PatientTypeID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_PatientType_PatientTypeID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Prefix_PrefixID] FOREIGN KEY([PrefixID])
REFERENCES [dbo].[Prefix] ([PrefixID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Prefix_PrefixID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Religion_ReligionID] FOREIGN KEY([ReligionID])
REFERENCES [dbo].[Religion] ([ReligionID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Religion_ReligionID]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Village_VillageID] FOREIGN KEY([VillageID])
REFERENCES [dbo].[Village] ([VillageID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Village_VillageID]
GO
ALTER TABLE [dbo].[Prefix]  WITH CHECK ADD  CONSTRAINT [FK_Prefix_Gender_GenderID] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
GO
ALTER TABLE [dbo].[Prefix] CHECK CONSTRAINT [FK_Prefix_Gender_GenderID]
GO
ALTER TABLE [dbo].[UnitDoctorMapping]  WITH CHECK ADD  CONSTRAINT [FK_UnitDoctorMapping_Doctor_DoctorID] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctor] ([DoctorID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UnitDoctorMapping] CHECK CONSTRAINT [FK_UnitDoctorMapping_Doctor_DoctorID]
GO
ALTER TABLE [dbo].[UnitDoctorMapping]  WITH CHECK ADD  CONSTRAINT [FK_UnitDoctorMapping_Unit_UnitID] FOREIGN KEY([UnitID])
REFERENCES [dbo].[Unit] ([UnitID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UnitDoctorMapping] CHECK CONSTRAINT [FK_UnitDoctorMapping_Unit_UnitID]
GO
ALTER TABLE [dbo].[Village]  WITH CHECK ADD  CONSTRAINT [FK_Village_Mandal_MandalID] FOREIGN KEY([MandalID])
REFERENCES [dbo].[Mandal] ([MandalID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Village] CHECK CONSTRAINT [FK_Village_Mandal_MandalID]
GO
/****** Object:  StoredProcedure [dbo].[GenerateOPIDList]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateOPIDList]
    @numIDs INT,               -- Number of OPIDs to generate
    @result NVARCHAR(MAX) OUTPUT -- Output parameter for the comma-separated list of OPIDs
AS
BEGIN
    -- Declare variables for OPID generation
    DECLARE @datePrefix NVARCHAR(8);   -- To store the date prefix for OPID
    DECLARE @formattedId NVARCHAR(4);  -- To store the formatted sequence number
    DECLARE @startSequence INT = 1;    -- Starting sequence number
    DECLARE @currentDate DATE = CAST(GETDATE() AS DATE);  -- Current date
    DECLARE @opID NVARCHAR(13);        -- To store the generated OPID

    -- Initialize the result variable
    SET @result = '';

    -- Set the date prefix for OPID in yyMMdd format
    SET @datePrefix = FORMAT(@currentDate, 'yyMMdd');

    -- Loop through the range of sequence numbers to generate the OPIDs
    WHILE @startSequence <= @numIDs
    BEGIN
        -- Format the sequence number with leading zeros (4 digits)
        SET @formattedId = RIGHT('0000' + CAST(@startSequence AS VARCHAR(4)), 4);
        
        -- Generate the OPID
        SET @opID = 'OP.' + @datePrefix + @formattedId;
        
        -- Append the generated OPID to the result, followed by a comma
        SET @result = @result + @opID + ',';
        
        -- Increment the sequence number
        SET @startSequence = @startSequence + 1;
    END

    -- Remove the trailing comma from the result
    SET @result = LEFT(@result, LEN(@result) - 1);

    -- Output the result
    SELECT @result AS OPIDs;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUHIDAndOPID]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetUHIDAndOPID]
AS
BEGIN
    -- Declare variables for UHID and OPID generation
    DECLARE @datePrefix NVARCHAR(8);   -- To store the date prefix for UHID and OPID
    DECLARE @nextId INT;               -- To store the next sequence number
    DECLARE @formattedId NVARCHAR(4);  -- To store the formatted sequence number
    DECLARE @uhID NVARCHAR(12);        -- To store the generated UHID
    DECLARE @opID NVARCHAR(13);        -- To store the generated OPID (length adjusted to account for appended '1')

    -- Get today's date
    DECLARE @tomorrowDate DATE = GETDATE();

    -- Set the date prefix for UHID in yyyyMMdd format
    SET @datePrefix = FORMAT(@tomorrowDate, 'yyyyMMdd');

    -- Calculate the next sequence number for UHID
    -- Extract the numeric part of UHID after the date prefix
    SELECT @nextId = ISNULL(MAX(CAST(SUBSTRING(UHID, LEN(@datePrefix) + 1, LEN(UHID) - LEN(@datePrefix)) AS INT)), 0) + 1
    FROM Patient
    WHERE UHID LIKE @datePrefix + '%';

    -- Format the UHID with zero-padding (4 digits for sequence part)
    SET @formattedId = RIGHT('0000' + CAST(@nextId AS VARCHAR(4)), 4);
    SET @uhID = @datePrefix + @formattedId;

    -- Set the date prefix for OPID in yyMMdd format
    SET @datePrefix = FORMAT(@tomorrowDate, 'yyMMdd');

    -- Generate OPID and append '1' at the end
    SET @opID = 'OP.' + @datePrefix + @formattedId + '1';

    -- Output the results
    SELECT @opID AS OPID, GETDATE() AS VisitDate;
END;

--EXEC GetUHIDAndOPID


GO
/****** Object:  StoredProcedure [dbo].[InsertOPRegistration]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertOPRegistration]
    @PatientID INT,
    @OPID NVARCHAR(20),
    @VisitDate DATETIME,
    @IsMlcCase BIT = NULL,
    @IsEmergencyCase BIT = NULL,
    @DepartmentID INT = NULL,
	@DoctorID INT = NULL,
    @SpecialityID INT = NULL,   
    @FeeTypeID INT = NULL,
    @ReferredBy NVARCHAR(50),
    @CreatedDate DATETIME = NULL,
    @IsActive BIT
AS
BEGIN
    -- Use TRY-CATCH to handle potential errors
    BEGIN TRY
        -- Insert into OPRegistration table
        INSERT INTO OPRegistration (
            PatientID,
            OPID,
            VisitDate,
            IsMlcCase,
            IsEmergencyCase,
            DepartmentID,
			DoctorID,
            SpecialityID,           
            FeeTypeID,
            ReferredBy,
            CreatedDate,
            IsActive
        )
        VALUES (
            @PatientID,
            @OPID,
            @VisitDate,
            @IsMlcCase,
            @IsEmergencyCase,
            @DepartmentID,
			@DoctorID,
            @SpecialityID,           
            @FeeTypeID,
            @ReferredBy,
            @CreatedDate,
            @IsActive
        );

        -- Optional: Return the ID of the inserted record (if you have an identity column)
        SELECT SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        -- Handle errors here (log them, rethrow them, etc.)
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SendNewOpDummy]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SendNewOpDummy]
    @UHID NVARCHAR(50),
    @OPID NVARCHAR(50),
    @visitDate DATETIME,
    @DepartmentID INT,
    @UnitID INT,
    @DoctorID INT,
    @Gender NVARCHAR(1)
AS
BEGIN
    BEGIN TRANSACTION;
    
    -- Insert into the relevant table
    INSERT INTO NewOpDummy (UHID, OPID, visitDate, DepartmentID, UnitID, DoctorID, Gender)
    VALUES (@UHID, @OPID, @visitDate, @DepartmentID, @UnitID, @DoctorID, @Gender);
    
    -- Error handling
    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN -1;
    END
    
    COMMIT TRANSACTION;
    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [dbo].[SendRevisitOpDummy]    Script Date: 07-09-2024 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SendRevisitOpDummy]
    @UHID NVARCHAR(50),
    @OPID NVARCHAR(50),
    @visitDate DATETIME,
    @departmentId INT,
    @unitId INT,
    @gender NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert the record into RevisitOpDummy table
    INSERT INTO RevisitOpDummy (UHID, OPID, visitDate, departmentId, unitId, gender)
    VALUES (@UHID, @OPID, @visitDate, @departmentId, @unitId, @gender);

    -- Optional: Add any additional logic or error handling here
END
GO
USE [master]
GO
ALTER DATABASE [DDLAutomationProcess] SET  READ_WRITE 
GO
