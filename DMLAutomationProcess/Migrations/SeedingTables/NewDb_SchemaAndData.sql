USE [master]
GO
/****** Object:  Database [Database]    Script Date: 02-09-2024 17:46:26 ******/
CREATE DATABASE [Database]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Database', FILENAME = N'C:\Users\VenkateswaraoMokka\Database.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Database_log', FILENAME = N'C:\Users\VenkateswaraoMokka\Database_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Database] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Database].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Database] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Database] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Database] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Database] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Database] SET ARITHABORT OFF 
GO
ALTER DATABASE [Database] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Database] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Database] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Database] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Database] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Database] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Database] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Database] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Database] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Database] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Database] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Database] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Database] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Database] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Database] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Database] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Database] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Database] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Database] SET  MULTI_USER 
GO
ALTER DATABASE [Database] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Database] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Database] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Database] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Database] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Database] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Database] SET QUERY_STORE = OFF
GO
USE [Database]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AgeType]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[BloodGroup]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[District]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Doctor]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[FeeType]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Gender]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[IDProofType]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Mandal]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[MaritalStatus]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[OPRegistration]    Script Date: 02-09-2024 17:46:26 ******/
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
	[SpecialityID] [int] NULL,
	[DoctorID] [int] NULL,
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
/****** Object:  Table [dbo].[Patient]    Script Date: 02-09-2024 17:46:26 ******/
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
	[CreatedDate] [datetime2](7) NULL,
	[PrefixID] [int] NULL,
	[VillageID] [int] NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientAddress]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[PatientType]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Prefix]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Religion]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Speciality]    Script Date: 02-09-2024 17:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Speciality](
	[SpecialityID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[UnitID] [int] NOT NULL,
 CONSTRAINT [PK_Speciality] PRIMARY KEY CLUSTERED 
(
	[SpecialityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[State]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Unit]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  Table [dbo].[Village]    Script Date: 02-09-2024 17:46:26 ******/
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
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240902024742_InitialContext', N'8.0.4')
GO
SET IDENTITY_INSERT [dbo].[AgeType] ON 
GO
INSERT [dbo].[AgeType] ([AgeTypeID], [Name]) VALUES (1, N'Years')
GO
INSERT [dbo].[AgeType] ([AgeTypeID], [Name]) VALUES (2, N'Months')
GO
INSERT [dbo].[AgeType] ([AgeTypeID], [Name]) VALUES (3, N'Days')
GO
SET IDENTITY_INSERT [dbo].[AgeType] OFF
GO
INSERT [dbo].[AspNetRoles] ([Id], [Discriminator], [Description], [CreatedDate], [IPAddress], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'ad550101-3fca-4af4-bf41-6a2cf0072bec', N'ApplicationRole', NULL, CAST(N'2024-08-30T08:30:10.3386152' AS DateTime2), NULL, N'Admin', N'ADMIN', NULL)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ad550101-3fca-4af4-bf41-6a2cf0072bec')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserId], [Name], [CreatedDate], [IsActive], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ApplicationUser', NULL, N'venkat', CAST(N'2024-08-30T08:30:12.7096760' AS DateTime2), 1, N'venkat', N'VENKAT', N'venkat@gmail.com', N'VENKAT@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEFdFfwXm11KI+50x2q377YsYc/hTQSRS8X/1b6KkZ+toQ8L1IgIJDBG34ZIe1posag==', N'WY2XTFLOSDQMZL5NYCICUF5NKUDLEQPE', N'b8ab023c-e5a0-4926-b72c-25eda7b3616b', NULL, 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[BloodGroup] ON 
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (1, N'Unknown')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (2, N'A+ve')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (3, N'B+ve')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (4, N'AB+ve')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (5, N'O+ve')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (6, N'A-ve')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (7, N'B-ve')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (8, N'AB-ve')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [Name]) VALUES (9, N'O-ve')
GO
SET IDENTITY_INSERT [dbo].[BloodGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (1, N'CASUALTY')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (2, N'DENTAL')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (3, N'DVL')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (4, N'ENT')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (5, N'GENERAL MEDICINE')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (6, N'GENERAL SURGERY')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (7, N'GYNECOLOGY')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (8, N'OBSTETRICS')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (9, N'OPHTHALMOLOGY')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (10, N'ORTHOPAEDICS')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (11, N'PAEDIATRICS')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (12, N'RESPIRATORY MEDICINE')
GO
INSERT [dbo].[Department] ([DepartmentID], [Name]) VALUES (13, N'PSYCHIATRY')
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[District] ON 
GO
INSERT [dbo].[District] ([DistrictID], [Name], [StateID]) VALUES (1, N'Medchal Malkajgiri', 1)
GO
INSERT [dbo].[District] ([DistrictID], [Name], [StateID]) VALUES (2, N'Hyderabad', 1)
GO
INSERT [dbo].[District] ([DistrictID], [Name], [StateID]) VALUES (3, N'Visakhapatnam', 2)
GO
SET IDENTITY_INSERT [dbo].[District] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctor] ON 
GO
INSERT [dbo].[Doctor] ([DoctorID], [Name]) VALUES (1, N'Gopi Krishna')
GO
SET IDENTITY_INSERT [dbo].[Doctor] OFF
GO
SET IDENTITY_INSERT [dbo].[FeeType] ON 
GO
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (1, N'Free')
GO
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (2, N'Cash')
GO
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (3, N'Credit')
GO
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (4, N'FeeTypes')
GO
INSERT [dbo].[FeeType] ([FeeTypeID], [Name]) VALUES (5, N'Aarogyasri')
GO
SET IDENTITY_INSERT [dbo].[FeeType] OFF
GO
SET IDENTITY_INSERT [dbo].[Gender] ON 
GO
INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (1, N'Male')
GO
INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (2, N'Female')
GO
INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (3, N'Transgender')
GO
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO
SET IDENTITY_INSERT [dbo].[IDProofType] ON 
GO
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (1, N'Unknown')
GO
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (2, N'VOTER ID')
GO
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (3, N'PAN CARD')
GO
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (4, N'DRIVING LICENCE')
GO
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (5, N'AAROGYASRI CARD')
GO
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (6, N'RATION CARD')
GO
INSERT [dbo].[IDProofType] ([IDProofTypeID], [Name]) VALUES (7, N'PASSPORT')
GO
SET IDENTITY_INSERT [dbo].[IDProofType] OFF
GO
SET IDENTITY_INSERT [dbo].[Mandal] ON 
GO
INSERT [dbo].[Mandal] ([MandalID], [Name], [DistrictID]) VALUES (1, N'Medchal', 1)
GO
INSERT [dbo].[Mandal] ([MandalID], [Name], [DistrictID]) VALUES (2, N'Shameerpet', 1)
GO
INSERT [dbo].[Mandal] ([MandalID], [Name], [DistrictID]) VALUES (3, N'Bheemili', 3)
GO
SET IDENTITY_INSERT [dbo].[Mandal] OFF
GO
SET IDENTITY_INSERT [dbo].[MaritalStatus] ON 
GO
INSERT [dbo].[MaritalStatus] ([MaritalStatusID], [Name]) VALUES (1, N'Unknown')
GO
INSERT [dbo].[MaritalStatus] ([MaritalStatusID], [Name]) VALUES (2, N'Married')
GO
INSERT [dbo].[MaritalStatus] ([MaritalStatusID], [Name]) VALUES (3, N'Single')
GO
SET IDENTITY_INSERT [dbo].[MaritalStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[OPRegistration] ON 
GO
INSERT [dbo].[OPRegistration] ([ID], [PatientID], [OPID], [VisitDate], [IsMlcCase], [IsEmergencyCase], [DepartmentID], [SpecialityID], [DoctorID], [FeeTypeID], [ReferredBy], [CreatedDate], [IsActive]) VALUES (2, 7, N'OP.2409020001', CAST(N'2024-09-02T17:35:42.0000000' AS DateTime2), NULL, NULL, 1, 1, 1, 1, N'Gopi', NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[OPRegistration] OFF
GO
SET IDENTITY_INSERT [dbo].[Patient] ON 
GO
INSERT [dbo].[Patient] ([ID], [UHID], [AadhaarNo], [GenderID], [FirstName], [MiddleName], [LastName], [FatherName], [HusbandName], [MaritalStatusID], [Age], [AgeTypeID], [DOB], [MobileNumber], [AlternateMobileNumber], [Email], [ReligionID], [Caste], [BloodGroupID], [IDProofTypeID], [IDProof], [AbhaNo], [PatientTypeID], [CreatedDate], [PrefixID], [VillageID]) VALUES (7, N'202409020001', 529801020967, 1, N'Mokka', NULL, N'Venkateswarao', N'Chinna Krishna', NULL, 2, 35, 1, CAST(N'1989-09-02T00:00:00.0000000' AS DateTime2), 9985071515, NULL, NULL, 2, N'BC-B', 2, 1, NULL, NULL, 1, CAST(N'2024-09-02T17:36:51.4722966' AS DateTime2), 2, 1)
GO
SET IDENTITY_INSERT [dbo].[Patient] OFF
GO
SET IDENTITY_INSERT [dbo].[PatientAddress] ON 
GO
INSERT [dbo].[PatientAddress] ([ID], [PatientID], [Village], [Mandal], [District], [State], [PinCode], [CreatedDate]) VALUES (1, 7, N'Medchal', N'Medchal', N'Medchal Malkajgiri', N'Telangana', 501401, NULL)
GO
SET IDENTITY_INSERT [dbo].[PatientAddress] OFF
GO
SET IDENTITY_INSERT [dbo].[PatientType] ON 
GO
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (1, N'General')
GO
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (2, N'Camp')
GO
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (3, N'Staff')
GO
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (4, N'Aarogyasri')
GO
INSERT [dbo].[PatientType] ([PatientTypeID], [Name]) VALUES (5, N'Student')
GO
SET IDENTITY_INSERT [dbo].[PatientType] OFF
GO
SET IDENTITY_INSERT [dbo].[Prefix] ON 
GO
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (2, N'Mr.', 1)
GO
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (3, N'Mrs.', 2)
GO
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (4, N'Miss', 2)
GO
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (5, N'Dr.', 2)
GO
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (6, N'Master', 1)
GO
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (7, N'Baby', 1)
GO
INSERT [dbo].[Prefix] ([PrefixID], [Name], [GenderID]) VALUES (8, N'Baby of', NULL)
GO
SET IDENTITY_INSERT [dbo].[Prefix] OFF
GO
SET IDENTITY_INSERT [dbo].[Religion] ON 
GO
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (1, N'Unknown')
GO
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (2, N'Hindu')
GO
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (3, N'Muslim')
GO
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (4, N'Christian')
GO
INSERT [dbo].[Religion] ([ReligionID], [Name]) VALUES (5, N'Others')
GO
SET IDENTITY_INSERT [dbo].[Religion] OFF
GO
SET IDENTITY_INSERT [dbo].[Speciality] ON 
GO
INSERT [dbo].[Speciality] ([SpecialityID], [Name], [UnitID]) VALUES (1, N'General surgery', 1)
GO
SET IDENTITY_INSERT [dbo].[Speciality] OFF
GO
SET IDENTITY_INSERT [dbo].[State] ON 
GO
INSERT [dbo].[State] ([StateID], [Name]) VALUES (1, N'Telangana')
GO
INSERT [dbo].[State] ([StateID], [Name]) VALUES (2, N'Andhra Pradesh')
GO
SET IDENTITY_INSERT [dbo].[State] OFF
GO
SET IDENTITY_INSERT [dbo].[Unit] ON 
GO
INSERT [dbo].[Unit] ([UnitID], [Name]) VALUES (1, N'CASUALTY 1- Unit')
GO
SET IDENTITY_INSERT [dbo].[Unit] OFF
GO
SET IDENTITY_INSERT [dbo].[Village] ON 
GO
INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (1, N'Medchal', 1, 501401)
GO
INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (2, N'Shameerpet', 2, 500078)
GO
INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (3, N'Bheemili', 3, 531162)
GO
INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (4, N'Malkajgiri', 1, 501404)
GO
INSERT [dbo].[Village] ([VillageID], [Name], [MandalID], [Pincode]) VALUES (5, N'Medipally', 1, 500092)
GO
SET IDENTITY_INSERT [dbo].[Village] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 02-09-2024 17:46:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 02-09-2024 17:46:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_District_StateID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_District_StateID] ON [dbo].[District]
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Mandal_DistrictID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Mandal_DistrictID] ON [dbo].[Mandal]
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_DepartmentID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_DepartmentID] ON [dbo].[OPRegistration]
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_DoctorID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_DoctorID] ON [dbo].[OPRegistration]
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_FeeTypeID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_FeeTypeID] ON [dbo].[OPRegistration]
(
	[FeeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_PatientID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_PatientID] ON [dbo].[OPRegistration]
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OPRegistration_SpecialityID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_OPRegistration_SpecialityID] ON [dbo].[OPRegistration]
(
	[SpecialityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_AgeTypeID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_AgeTypeID] ON [dbo].[Patient]
(
	[AgeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_BloodGroupID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_BloodGroupID] ON [dbo].[Patient]
(
	[BloodGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_GenderID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_GenderID] ON [dbo].[Patient]
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_IDProofTypeID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_IDProofTypeID] ON [dbo].[Patient]
(
	[IDProofTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_MaritalStatusID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_MaritalStatusID] ON [dbo].[Patient]
(
	[MaritalStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_PatientTypeID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_PatientTypeID] ON [dbo].[Patient]
(
	[PatientTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_PrefixID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_PrefixID] ON [dbo].[Patient]
(
	[PrefixID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_ReligionID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_ReligionID] ON [dbo].[Patient]
(
	[ReligionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_VillageID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Patient_VillageID] ON [dbo].[Patient]
(
	[VillageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PatientAddress_PatientID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_PatientAddress_PatientID] ON [dbo].[PatientAddress]
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Prefix_GenderID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Prefix_GenderID] ON [dbo].[Prefix]
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Speciality_UnitID]    Script Date: 02-09-2024 17:46:26 ******/
CREATE NONCLUSTERED INDEX [IX_Speciality_UnitID] ON [dbo].[Speciality]
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Village_MandalID]    Script Date: 02-09-2024 17:46:26 ******/
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
ALTER TABLE [dbo].[OPRegistration]  WITH CHECK ADD  CONSTRAINT [FK_OPRegistration_Doctor_DoctorID] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctor] ([DoctorID])
GO
ALTER TABLE [dbo].[OPRegistration] CHECK CONSTRAINT [FK_OPRegistration_Doctor_DoctorID]
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
ALTER TABLE [dbo].[PatientAddress]  WITH CHECK ADD  CONSTRAINT [FK_PatientAddress_Patient_PatientID] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientAddress] CHECK CONSTRAINT [FK_PatientAddress_Patient_PatientID]
GO
ALTER TABLE [dbo].[Prefix]  WITH CHECK ADD  CONSTRAINT [FK_Prefix_Gender_GenderID] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Prefix] CHECK CONSTRAINT [FK_Prefix_Gender_GenderID]
GO
ALTER TABLE [dbo].[Speciality]  WITH CHECK ADD  CONSTRAINT [FK_Speciality_Unit_UnitID] FOREIGN KEY([UnitID])
REFERENCES [dbo].[Unit] ([UnitID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Speciality] CHECK CONSTRAINT [FK_Speciality_Unit_UnitID]
GO
ALTER TABLE [dbo].[Village]  WITH CHECK ADD  CONSTRAINT [FK_Village_Mandal_MandalID] FOREIGN KEY([MandalID])
REFERENCES [dbo].[Mandal] ([MandalID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Village] CHECK CONSTRAINT [FK_Village_Mandal_MandalID]
GO
/****** Object:  StoredProcedure [dbo].[GetUHIDAndOPID]    Script Date: 02-09-2024 17:46:26 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUHIDAndOPIDs]    Script Date: 02-09-2024 17:46:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetUHIDAndOPIDs]
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
    SELECT @uhID AS NewUHID, @opID AS NewOPID, GETDATE() AS VisitDate;
END;

GO
/****** Object:  StoredProcedure [dbo].[InsertOPRegistration]    Script Date: 02-09-2024 17:46:26 ******/
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
    @SpecialityID INT = NULL,
    @DoctorID INT = NULL,
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
            SpecialityID,
            DoctorID,
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
            @SpecialityID,
            @DoctorID,
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
USE [master]
GO
ALTER DATABASE [Database] SET  READ_WRITE 
GO
