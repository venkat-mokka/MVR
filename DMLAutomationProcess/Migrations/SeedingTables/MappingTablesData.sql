INSERT [dbo].[AspNetRoles] ([Id], [Discriminator], [Description], [CreatedDate], [IPAddress], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'ad550101-3fca-4af4-bf41-6a2cf0072bec', N'ApplicationRole', NULL, CAST(N'2024-08-30T08:30:10.3386152' AS DateTime2), NULL, N'Admin', N'ADMIN', NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserId], [Name], [CreatedDate], [IsActive], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ApplicationUser', NULL, N'venkat', CAST(N'2024-08-30T08:30:12.7096760' AS DateTime2), 1, N'venkat', N'VENKAT', N'venkat@gmail.com', N'VENKAT@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAEFdFfwXm11KI+50x2q377YsYc/hTQSRS8X/1b6KkZ+toQ8L1IgIJDBG34ZIe1posag==', N'WY2XTFLOSDQMZL5NYCICUF5NKUDLEQPE', N'b8ab023c-e5a0-4926-b72c-25eda7b3616b', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'74022576-3acd-4f31-91a9-d7204122cc97', N'ad550101-3fca-4af4-bf41-6a2cf0072bec')
GO


Select * from AspNetRoles

Select * from AspNetUsers

Select * from AspNetUserRoles

-- Insert into Gender
INSERT INTO [dbo].[Gender] (Name) VALUES ('Male')
INSERT INTO [dbo].[Gender] (Name) VALUES ('Female')
INSERT INTO [dbo].[Gender] (Name) VALUES ('Transgender')
GO

-- Insert into Prefix
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Mr.', 1)
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Dr', 1)
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Mrs.', 2)
GO

-- Insert into AgeType
INSERT INTO [dbo].[AgeType] (Name) VALUES ('Years')
INSERT INTO [dbo].[AgeType] (Name) VALUES ('Months')
INSERT INTO [dbo].[AgeType] (Name) VALUES ('Days')
GO

-- Insert into PatientType
INSERT INTO [dbo].[PatientType] (Name) VALUES ('General')
INSERT INTO [dbo].[PatientType] (Name) VALUES ('Camp')
INSERT INTO [dbo].[PatientType] (Name) VALUES ('Staff')
INSERT INTO [dbo].[PatientType] (Name) VALUES ('Aarogyasri')
INSERT INTO [dbo].[PatientType] (Name) VALUES ('Student')
GO

-- Insert into Department
INSERT INTO [dbo].[Department] (Name) VALUES ('CASUALTY')
INSERT INTO [dbo].[Department] (Name) VALUES ('DENTAL')
INSERT INTO [dbo].[Department] (Name) VALUES ('DVL')
INSERT INTO [dbo].[Department] (Name) VALUES ('ENT')
INSERT INTO [dbo].[Department] (Name) VALUES ('GENERAL MEDICINE')
INSERT INTO [dbo].[Department] (Name) VALUES ('GENERAL SURGERY')
INSERT INTO [dbo].[Department] (Name) VALUES ('GYNECOLOGY')
INSERT INTO [dbo].[Department] (Name) VALUES ('OBSTETRICS')
INSERT INTO [dbo].[Department] (Name) VALUES ('OPHTHALMOLOGY')
INSERT INTO [dbo].[Department] (Name) VALUES ('ORTHOPAEDICS')
INSERT INTO [dbo].[Department] (Name) VALUES ('PAEDIATRICS')
INSERT INTO [dbo].[Department] (Name) VALUES ('RESPIRATORY MEDICINE')
INSERT INTO [dbo].[Department] (Name) VALUES ('PSYCHIATRY')
GO

-- Insert into FeeType
INSERT INTO [dbo].[FeeType] (Name) VALUES ('Free')
INSERT INTO [dbo].[FeeType] (Name) VALUES ('Cash')
INSERT INTO [dbo].[FeeType] (Name) VALUES ('Credit')
INSERT INTO [dbo].[FeeType] (Name) VALUES ('FeeTypes')
INSERT INTO [dbo].[FeeType] (Name) VALUES ('Aarogyasri')
GO

-- Insert into MaritalStatus
INSERT INTO [dbo].[MaritalStatus] (Name) VALUES ('Unknown')
INSERT INTO [dbo].[MaritalStatus] (Name) VALUES ('Married')
INSERT INTO [dbo].[MaritalStatus] (Name) VALUES ('Single')
GO

-- Insert into Religion
INSERT INTO [dbo].[Religion] (Name) VALUES ('Unknown')
INSERT INTO [dbo].[Religion] (Name) VALUES ('Hindu')
INSERT INTO [dbo].[Religion] (Name) VALUES ('Muslim')
INSERT INTO [dbo].[Religion] (Name) VALUES ('Christian')
INSERT INTO [dbo].[Religion] (Name) VALUES ('Others')
GO

-- Insert into BloodGroup
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('Unknown')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('A+ve')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('B+ve')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('AB+ve')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('O+ve')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('A-ve')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('B-ve')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('AB-ve')
INSERT INTO [dbo].[BloodGroup] (Name) VALUES ('O-ve')
GO

-- Insert into IdProof
INSERT INTO [dbo].IDProofType (Name) VALUES ('Unknown')
INSERT INTO [dbo].IDProofType (Name) VALUES ('VOTER ID')
INSERT INTO [dbo].IDProofType (Name) VALUES ('PAN CARD')
INSERT INTO [dbo].IDProofType (Name) VALUES ('DRIVING LICENCE')
INSERT INTO [dbo].IDProofType (Name) VALUES ('AAROGYASRI CARD')
INSERT INTO [dbo].IDProofType (Name) VALUES ('RATION CARD')
INSERT INTO [dbo].IDProofType (Name) VALUES ('PASSPORT')
GO

-- Insert States
INSERT INTO [State] (Name) VALUES ('Telangana');
INSERT INTO [State] (Name) VALUES ('Andhra Pradesh');

-- Insert Districts
-- Assuming StateID 1 corresponds to 'Telangana' and StateID 2 to 'Andhra Pradesh'
INSERT INTO [District] (Name, StateID) VALUES ('Medchal Malkajgiri', 1);
INSERT INTO [District] (Name, StateID) VALUES ('Hyderabad', 1);
INSERT INTO [District] (Name, StateID) VALUES ('Visakhapatnam', 2); -- Example for Andhra Pradesh

-- Insert Mandals
-- Assuming DistrictID 1 corresponds to 'Medchal Malkajgiri' and DistrictID 2 to 'Hyderabad'
INSERT INTO [Mandal] (Name, DistrictID) VALUES ('Medchal', 1);
INSERT INTO [Mandal] (Name, DistrictID) VALUES ('Shameerpet', 1);
INSERT INTO [Mandal] (Name, DistrictID) VALUES ('Bheemili', 2); -- Example for Hyderabad


-- Insert Villages
-- Assuming MandalID 1 corresponds to 'Medchal' and MandalID 2 to 'Shameerpet'
INSERT INTO [Village] (Name, MandalID, Pincode) VALUES ('Medchal', 1, 501401);
INSERT INTO [Village] (Name, MandalID, Pincode) VALUES ('Shameerpet', 2, 500078);
INSERT INTO [Village] (Name, MandalID, Pincode) VALUES ('Bheemili', 3, 531162); -- Example for Bheemili


INSERT INTO Doctor (Name) VALUES
('Gopi Krishna');  

INSERT INTO Unit (Name) VALUES
('CASUALTY 1- Unit');  

INSERT INTO Speciality (Name, UnitID) VALUES
('General surgery', 1); 
