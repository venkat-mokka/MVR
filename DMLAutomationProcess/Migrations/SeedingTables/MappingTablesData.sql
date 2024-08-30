
INSERT [dbo].[AspNetRoles] ([Id], [Discriminator], [Description], [CreatedDate], [IPAddress], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'ad550101-3fca-4af4-bf41-6a2cf0072bec', N'ApplicationRole', NULL, CAST(N'2024-08-30T08:30:10.3386152' AS DateTime2), NULL, N'Admin', N'ADMIN', NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserId], [Name], [CreatedDate], [IsActive], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ApplicationUser', NULL, N'venkat', CAST(N'2024-08-30T08:30:12.7096760' AS DateTime2), 1, N'venkat', N'VENKAT', N'venkat@gmail.com', N'VENKAT@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEFdFfwXm11KI+50x2q377YsYc/hTQSRS8X/1b6KkZ+toQ8L1IgIJDBG34ZIe1posag==', N'WY2XTFLOSDQMZL5NYCICUF5NKUDLEQPE', N'b8ab023c-e5a0-4926-b72c-25eda7b3616b', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ad550101-3fca-4af4-bf41-6a2cf0072bec')
GO


Select * from AspNetRoles

Select * from AspNetUsers

Select * from AspNetUserRoles

Insert into Genders
Select 'Male'
Insert into Genders
Select 'FeMale'
Insert into Genders
Select 'Transgender'
 
Select * from Genders
 
Insert into Prefixs
Select 'Mr.',1
Insert into Prefixs
Select 'Dr',1
Insert into Prefixs
Select 'Mrs.',2
 
Select * from Prefixs
 
Insert into Years
Select 'Years'
Insert into Years
Select 'Months'
Insert into Years
Select 'Days'
 
Select * from Years
 
Insert into PatientTypes
Select 'General'
Insert into PatientTypes
Select 'Camp'
Insert into PatientTypes
Select 'Staff'
Insert into PatientTypes
Select 'Aarogyasri'
Insert into PatientTypes
Select 'Student'
 
Select * from PatientTypes
 
Insert into Departments
Select 'CASUALTY'
Insert into Departments
Select 'DENTAL'
Insert into Departments
Select 'DVL'
Insert into Departments
Select 'ENT'
Insert into Departments
Select 'GENERAL MEDICINE'
Insert into Departments
Select 'GENERAL SURGERY'
Insert into Departments
Select 'GYNECOLOGY'
Insert into Departments
Select 'OBSTETRICS'
Insert into Departments
Select 'OPHTHALMOLOGY'
Insert into Departments
Select 'ORTHOPAEDICS'
Insert into Departments
Select 'PAEDIATRICS'
Insert into Departments
Select 'RESPIRATORY MEDICINE'
Insert into Departments
Select 'PSYCHIATRY'
 
Select * from Departments