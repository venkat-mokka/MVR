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
-- Insert prefixes with associated GenderIDs
DBCC CHECKIDENT ('[Prefix]', RESEED, 0);
GO
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Mr.', 1);
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Mrs.', 2);
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Miss', 2);
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Dr.', 2);
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Master', 1);
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Baby', 1);
INSERT INTO [dbo].[Prefix] (Name, GenderID) VALUES ('Baby of', NULL);

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
INSERT INTO Department (Name)
VALUES
('CASUALTY'),
('DENTAL'),
('DVL'),
('ENT'),
('GENERAL MEDICINE'),
('GENERAL SURGERY'),
('GYNECOLOGY'),
('OBSTETRICS'),
('OPHTHALMOLOGY'),
('ORTHOPAEDICS'),
('PAEDIATRICS'),
('RESPIRATORY MEDICINE'),
('PSYCHIATRY');
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


INSERT INTO Doctor (Name) VALUES ('Dr.Thandra Ramoji Babu');
INSERT INTO Doctor (Name) VALUES ('Dr.Karishma');
INSERT INTO Doctor (Name) VALUES ('Dr.Sree Karthik Pratapa');
INSERT INTO Doctor (Name) VALUES ('Dr.Sriramula Yamini');
INSERT INTO Doctor (Name) VALUES ('Dr.Ketavath Kiran Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Aditya Chakravarthula');
INSERT INTO Doctor (Name) VALUES ('Dr.Elabaka Munisahith Sharma');
INSERT INTO Doctor (Name) VALUES ('Dr.Thakur Abhijeet Singh');
INSERT INTO Doctor (Name) VALUES ('Dr.Damera Mounika');
INSERT INTO Doctor (Name) VALUES ('Dr.Satla Rakhesh Goud');
INSERT INTO Doctor (Name) VALUES ('Dr.Dontha Mahesh Netha');
INSERT INTO Doctor (Name) VALUES ('Dr.Puskoor Tharun');
INSERT INTO Doctor (Name) VALUES ('Dr.V Akhila');
INSERT INTO Doctor (Name) VALUES ('Dr.Kondu Mounika');
INSERT INTO Doctor (Name) VALUES ('Dr.Rajesh Ganta');
INSERT INTO Doctor (Name) VALUES ('Dr.Yarlagadda Srinivas Rao');
INSERT INTO Doctor (Name) VALUES ('Dr.RamadugUNIT - Venkat Chanakya');
INSERT INTO Doctor (Name) VALUES ('Dr.Aluguvelly Suresh Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Pagadala Tejaswi');
INSERT INTO Doctor (Name) VALUES ('Dr.Chinthala Navyasree');
INSERT INTO Doctor (Name) VALUES ('Dr.Gone Vamshi Krishna');
INSERT INTO Doctor (Name) VALUES ('Dr.K Anil Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Sreeperumbuduri Ashok');
INSERT INTO Doctor (Name) VALUES ('Dr.Cheripally Rajashekar');
INSERT INTO Doctor (Name) VALUES ('Dr.G Abhinav Kumar Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Koneru Siri');
INSERT INTO Doctor (Name) VALUES ('Dr.Kondle Kranti');
INSERT INTO Doctor (Name) VALUES ('Dr.Dugyala Dinesh');
INSERT INTO Doctor (Name) VALUES ('Dr.Marepally Nitin Rao');
INSERT INTO Doctor (Name) VALUES ('Dr.Bharath S');
INSERT INTO Doctor (Name) VALUES ('Dr.Aluru Mithra Vindha');
INSERT INTO Doctor (Name) VALUES ('Dr.Vadlamani M S R Srinivas');
INSERT INTO Doctor (Name) VALUES ('Dr.Bommidi Kranthi');
INSERT INTO Doctor (Name) VALUES ('Dr.Korra Niharika');
INSERT INTO Doctor (Name) VALUES ('Dr.Surendhar Guguloth');
INSERT INTO Doctor (Name) VALUES ('Dr.Dande Nagendra');
INSERT INTO Doctor (Name) VALUES ('Dr.Pothuganti Durga Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Kotha Jyothsnapriya');
INSERT INTO Doctor (Name) VALUES ('Dr.Guda Raj Kamal');
INSERT INTO Doctor (Name) VALUES ('Dr.Pusarla Naga Sai Laxmi');
INSERT INTO Doctor (Name) VALUES ('Dr.Sappidi Nikitha');
INSERT INTO Doctor (Name) VALUES ('Dr.Akasapu Bhagavan');
INSERT INTO Doctor (Name) VALUES ('Dr.Akila Sree Gowri');
INSERT INTO Doctor (Name) VALUES ('Dr.Allada Nagaraju');
INSERT INTO Doctor (Name) VALUES ('Dr.Ambi Sambasiva Rao');
INSERT INTO Doctor (Name) VALUES ('Dr.Archana Santosh Jain');
INSERT INTO Doctor (Name) VALUES ('Dr.Ashok Rao Matety');
INSERT INTO Doctor (Name) VALUES ('Dr.B Tejasree');
INSERT INTO Doctor (Name) VALUES ('Dr.Baddam Mounika Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Bandari Dheeraj');
INSERT INTO Doctor (Name) VALUES ('Dr.Bathula Deepthi');
INSERT INTO Doctor (Name) VALUES ('Dr.BattUNIT - VIjayeswar Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Bendram Phaninder Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Bolgam Suvarna');
INSERT INTO Doctor (Name) VALUES ('Dr.Bolgam Vijaya Bhasker');
INSERT INTO Doctor (Name) VALUES ('Dr.Bommineni Sashidhar Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Buyyani Priyanka');
INSERT INTO Doctor (Name) VALUES ('Dr.Challa Pooja Rani');
INSERT INTO Doctor (Name) VALUES ('Dr.Chelikani Kavitha');
INSERT INTO Doctor (Name) VALUES ('Dr.Chetan Bhavan Mahajan');
INSERT INTO Doctor (Name) VALUES ('Dr.Chetaraju Ravikiran');
INSERT INTO Doctor (Name) VALUES ('Dr.Chidugulla Suresh Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Chinthala Narsaiah');
INSERT INTO Doctor (Name) VALUES ('Dr.Davu Hema');
INSERT INTO Doctor (Name) VALUES ('Dr.Devunuri Sravya');
INSERT INTO Doctor (Name) VALUES ('Dr.Dinesh Singh Chauhan R');
INSERT INTO Doctor (Name) VALUES ('Dr.Sudigali Sunanda');
INSERT INTO Doctor (Name) VALUES ('Dr.Alishala Lingam');
INSERT INTO Doctor (Name) VALUES ('Dr.Arshad Hussain');
INSERT INTO Doctor (Name) VALUES ('Dr.Kusuma Purushotham');
INSERT INTO Doctor (Name) VALUES ('Dr.Mahender Muthyapu');
INSERT INTO Doctor (Name) VALUES ('Dr.Mulukoju Ravindra Chary');
INSERT INTO Doctor (Name) VALUES ('Dr.Patnala Vijaya');
INSERT INTO Doctor (Name) VALUES ('Dr.Uppu Kishan');
INSERT INTO Doctor (Name) VALUES ('Dr.Vamshi Krishna Biroj');
INSERT INTO Doctor (Name) VALUES ('Dr.Dubakunta Manjula');
INSERT INTO Doctor (Name) VALUES ('Dr.G.Dayanand');
INSERT INTO Doctor (Name) VALUES ('Dr.GadagottUNIT - Vaishnavi');
INSERT INTO Doctor (Name) VALUES ('Dr.Gadapaga Venkatesh');
INSERT INTO Doctor (Name) VALUES ('Dr.Gandra Aravind');
INSERT INTO Doctor (Name) VALUES ('Dr.Ganesh Nallagonda');
INSERT INTO Doctor (Name) VALUES ('Dr.Ganganamoni Raja Mohan');
INSERT INTO Doctor (Name) VALUES ('Dr.Gautam Panduranga');
INSERT INTO Doctor (Name) VALUES ('Dr.Gogineni Divya Chowdary');
INSERT INTO Doctor (Name) VALUES ('Dr.Gopi Krishna Amaravadi');
INSERT INTO Doctor (Name) VALUES ('Dr.Gouthami Padugundla');
INSERT INTO Doctor (Name) VALUES ('Dr.Gudiyella Sukumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Gummi Mamatha Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Gundla Vamshi Krishna');
INSERT INTO Doctor (Name) VALUES ('Dr.Itha Lingamurthy');
INSERT INTO Doctor (Name) VALUES ('Dr.Janaswamy Vishwanath');
INSERT INTO Doctor (Name) VALUES ('Dr.K Mrudula');
INSERT INTO Doctor (Name) VALUES ('Dr.Kamisetty Kishorekumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Kamtala Ramu');
INSERT INTO Doctor (Name) VALUES ('Dr.Kamuni Narsimloo');
INSERT INTO Doctor (Name) VALUES ('Dr.Kandala Shivaraj Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Kandula Venkat');
INSERT INTO Doctor (Name) VALUES ('Dr.Kankanampati Venkata Mounika');
INSERT INTO Doctor (Name) VALUES ('Dr.Kanmantha Reddy Sriharsha');
INSERT INTO Doctor (Name) VALUES ('Dr.Karumuru Kiran Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Kasturi Ashwin');
INSERT INTO Doctor (Name) VALUES ('Dr.Kasturi Swetha');
INSERT INTO Doctor (Name) VALUES ('Dr.Katkam Avinash');
INSERT INTO Doctor (Name) VALUES ('Dr.Katti Alekya');
INSERT INTO Doctor (Name) VALUES ('Dr.Kethawath Kavitha');
INSERT INTO Doctor (Name) VALUES ('Dr.Kilambi Srinivas');
INSERT INTO Doctor (Name) VALUES ('Dr.Kodidela Jahnavi');
INSERT INTO Doctor (Name) VALUES ('Dr.Kolan Sai Raghava Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Kompella Abhijna Rao');
INSERT INTO Doctor (Name) VALUES ('Dr.Konatham Hari Babu');
INSERT INTO Doctor (Name) VALUES ('Dr.Kondaveeti Sai Kanth Sharma');
INSERT INTO Doctor (Name) VALUES ('Dr.Kondle Vamshi Krishna');
INSERT INTO Doctor (Name) VALUES ('Dr.Koriginja Rajeshwar');
INSERT INTO Doctor (Name) VALUES ('Dr.Kotagiri Ravikanth');
INSERT INTO Doctor (Name) VALUES ('Dr.Kotha Prem Kishore');
INSERT INTO Doctor (Name) VALUES ('Dr.Kurimilla Ramesh');
INSERT INTO Doctor (Name) VALUES ('Dr.Kusuma Siva Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.M Bhagyashree');
INSERT INTO Doctor (Name) VALUES ('Dr.Madhava Nachagiri');
INSERT INTO Doctor (Name) VALUES ('Dr.Mahadeva Jhansi Mani');
INSERT INTO Doctor (Name) VALUES ('Dr.Mahesh Neginhal');
INSERT INTO Doctor (Name) VALUES ('Dr.Mamidala Suneeth Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Manchala Karthik');
INSERT INTO Doctor (Name) VALUES ('Dr.Manchikatla Ramulu');
INSERT INTO Doctor (Name) VALUES ('Dr.Manideep Malaka');
INSERT INTO Doctor (Name) VALUES ('Dr.Mayakuntla Nitesh Sai');
INSERT INTO Doctor (Name) VALUES ('Dr.Memba Bala Vikas Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Mooga Swetcha');
INSERT INTO Doctor (Name) VALUES ('Dr.Mundrathi Ravikumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Murali Mohan Gurram');
INSERT INTO Doctor (Name) VALUES ('Dr.Nagelli Samuel');
INSERT INTO Doctor (Name) VALUES ('Dr.Nakkarkanti Shivakoti Vasu');
INSERT INTO Doctor (Name) VALUES ('Dr.Nampally Prashanth');
INSERT INTO Doctor (Name) VALUES ('Dr.Nathani Arif Aziz');
INSERT INTO Doctor (Name) VALUES ('Dr.Nathani Manisha Arif');
INSERT INTO Doctor (Name) VALUES ('Dr.Navneeth Servey');
INSERT INTO Doctor (Name) VALUES ('Dr.Neelaboina Vasudeva Rayudu');
INSERT INTO Doctor (Name) VALUES ('Dr.Paka Rajanna Rajender');
INSERT INTO Doctor (Name) VALUES ('Dr.Pamulapati Sasidhar');
INSERT INTO Doctor (Name) VALUES ('Dr.Panchmahalkar Anand');
INSERT INTO Doctor (Name) VALUES ('Dr.Penugonda Chandra Sekhar');
INSERT INTO Doctor (Name) VALUES ('Dr.PesarUNIT - VIjaya Chander Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Pilli Padma');
INSERT INTO Doctor (Name) VALUES ('Dr.Polu Sasikanth Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Poosa Suresh Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Poreddi Mahesh Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Produtur Rukmini Reddy');
INSERT INTO Doctor (Name) VALUES ('Dr.Raghava Aditya Kalvala');
INSERT INTO Doctor (Name) VALUES ('Dr.Rallabandi Penta Chary');
INSERT INTO Doctor (Name) VALUES ('Dr.Rama Ashok');
INSERT INTO Doctor (Name) VALUES ('Dr.Rathlawath Swapna');
INSERT INTO Doctor (Name) VALUES ('Dr.Rodda Suma');
INSERT INTO Doctor (Name) VALUES ('Dr.S Kapil Sai');
INSERT INTO Doctor (Name) VALUES ('Dr.Saai Ram Thejas B S');
INSERT INTO Doctor (Name) VALUES ('Dr.Sainath Reddy Manda');
INSERT INTO Doctor (Name) VALUES ('Dr.Shaik Mohammed Anjum');
INSERT INTO Doctor (Name) VALUES ('Dr.Siva Sankar Nunna');
INSERT INTO Doctor (Name) VALUES ('Dr.Sumitra Devi Adepu');
INSERT INTO Doctor (Name) VALUES ('Dr.Suresh Dantoor');
INSERT INTO Doctor (Name) VALUES ('Dr.Surya Nunavath');
INSERT INTO Doctor (Name) VALUES ('Dr.Talla Srinivas');
INSERT INTO Doctor (Name) VALUES ('Dr.Talluri Suresh Babu');
INSERT INTO Doctor (Name) VALUES ('Dr.Uppu Krishnam Raju');
INSERT INTO Doctor (Name) VALUES ('Dr.V Ranjith Kumar Kota');
INSERT INTO Doctor (Name) VALUES ('Dr.Valluri Sowmya Choudri');
INSERT INTO Doctor (Name) VALUES ('Dr.VamarajUNIT - Venkata Krishna Bharadwaja');
INSERT INTO Doctor (Name) VALUES ('Dr.Vanama Lavya Kumar');
INSERT INTO Doctor (Name) VALUES ('Dr.Veera Divya');
INSERT INTO Doctor (Name) VALUES ('Dr.Vemula Usharani');
INSERT INTO Doctor (Name) VALUES ('Dr.Venkateswar Reddy Vaddula');


INSERT INTO Speciality (Name) VALUES
('General medicine - Cardiology')
INSERT INTO Speciality (Name) VALUES
('General medicine - Gastroenterology')
INSERT INTO Speciality (Name) VALUES
('General Surgery - Urology')
INSERT INTO Speciality (Name) VALUES
('Orthopedics - Neuro Surgery'); 

INSERT INTO Day (Name) VALUES 
('SUN'),
('MON'),
('TUE'),
('WED'),
('THU'),
('FRI'),
('SAT');

INSERT INTO Unit (Name)
VALUES 
('UNIT - I'),
('UNIT - II'),
('UNIT - III'),
('UNIT - IV'),
('UNIT - V'),
('UNIT - VI'),
('UNIT - VII'),
('UNIT - VIII');


INSERT INTO DepartmentDayUnitMapping (DepartmentId, DayId, UnitId)
VALUES
-- CASUALTY
(1, 1, 1), -- SUN, UNIT - I
(1, 2, 1), -- MON, UNIT - I
(1, 3, 1), -- TUE, UNIT - I
(1, 4, 1), -- WED, UNIT - I
(1, 5, 1), -- THU, UNIT - I
(1, 6, 1), -- FRI, UNIT - I
(1, 7, 1), -- SAT, UNIT - I

-- DENTAL
(2, 1, 4), -- SUN, UNIT - IV
(2, 2, 4), -- MON, UNIT - IV
(2, 3, 4), -- TUE, UNIT - IV
(2, 4, 4), -- WED, UNIT - IV
(2, 5, 4), -- THU, UNIT - IV
(2, 6, 4), -- FRI, UNIT - IV
(2, 7, 4), -- SAT, UNIT - IV

-- DVL
(3, 1, 1), -- SUN, UNIT - I
(3, 2, 1), -- MON, UNIT - I
(3, 3, 1), -- TUE, UNIT - I
(3, 4, 1), -- WED, UNIT - I
(3, 5, 1), -- THU, UNIT - I
(3, 6, 1), -- FRI, UNIT - I
(3, 7, 1), -- SAT, UNIT - I

-- ENT
(4, 1, 4), -- SUN, UNIT - IV
(4, 2, 4), -- MON, UNIT - IV
(4, 3, 4), -- TUE, UNIT - IV
(4, 4, 4), -- WED, UNIT - IV
(4, 5, 4), -- THU, UNIT - IV
(4, 6, 4), -- FRI, UNIT - IV
(4, 7, 4), -- SAT, UNIT - IV

-- GENERAL MEDICINE
(5, 1, 7), -- SUN, UNIT - VII
(5, 2, 8), -- MON, UNIT - VIII
(5, 3, 8), -- TUE, UNIT - VIII
(5, 4, 3), -- WED, UNIT - III
(5, 5, 4), -- THU, UNIT - IV
(5, 6, 3), -- FRI, UNIT - III
(5, 7, 7), -- SAT, UNIT - VII

-- GENERAL SURGERY
(6, 1, 7), -- SUN, UNIT - VII
(6, 2, 8), -- MON, UNIT - VIII
(6, 3, 8), -- TUE, UNIT - VIII
(6, 4, 3), -- WED, UNIT - III
(6, 5, 4), -- THU, UNIT - IV
(6, 6, 3), -- FRI, UNIT - III
(6, 7, 7), -- SAT, UNIT - VII

-- GYNECOLOGY
(7, 1, 7), -- SUN, UNIT - VII
(7, 2, 8), -- MON, UNIT - VIII
(7, 3, 8), -- TUE, UNIT - VIII
(7, 4, 3), -- WED, UNIT - III
(7, 5, 4), -- THU, UNIT - IV
(7, 6, 3), -- FRI, UNIT - III
(7, 7, 7), -- SAT, UNIT - VII

-- OBSTETRICS
(8, 1, 1), -- SUN, UNIT - I
(8, 2, 1), -- MON, UNIT - I
(8, 3, 1), -- TUE, UNIT - I
(8, 4, 1), -- WED, UNIT - I
(8, 5, 1), -- THU, UNIT - I
(8, 6, 1), -- FRI, UNIT - I
(8, 7, 1), -- SAT, UNIT - I

-- OPHTHALMOLOGY
(9, 1, 1), -- SUN, UNIT - I
(9, 2, 4), -- MON, UNIT - IV
(9, 3, 4), -- TUE, UNIT - IV
(9, 4, 4), -- WED, UNIT - IV
(9, 5, 4), -- THU, UNIT - IV
(9, 6, 4), -- FRI, UNIT - IV
(9, 7, 1), -- SAT, UNIT - I

-- ORTHOPAEDICS
(10, 1, 3), -- SUN, UNIT - III
(10, 2, 3), -- MON, UNIT - III
(10, 3, 3), -- TUE, UNIT - III
(10, 4, 3), -- WED, UNIT - III
(10, 5, 3), -- THU, UNIT - III
(10, 6, 3), -- FRI, UNIT - III
(10, 7, 3), -- SAT, UNIT - III

-- PAEDIATRICS
(11, 1, 4), -- SUN, UNIT - IV
(11, 2, 4), -- MON, UNIT - IV
(11, 3, 4), -- TUE, UNIT - IV
(11, 4, 4), -- WED, UNIT - IV
(11, 5, 4), -- THU, UNIT - IV
(11, 6, 4), -- FRI, UNIT - IV
(11, 7, 4), -- SAT, UNIT - IV

-- RESPIRATORY MEDICINE
(12, 1, 1), -- SUN, UNIT - I
(12, 2, 1), -- MON, UNIT - I
(12, 3, 1), -- TUE, UNIT - I
(12, 4, 1), -- WED, UNIT - I
(12, 5, 1), -- THU, UNIT - I
(12, 6, 1), -- FRI, UNIT - I
(12, 7, 1), -- SAT, UNIT - I

-- PSYCHIATRY
(13, 1, 1), -- SUN, UNIT - I
(13, 2, 1), -- MON, UNIT - I
(13, 3, 1), -- TUE, UNIT - I
(13, 4, 1), -- WED, UNIT - I
(13, 5, 1), -- THU, UNIT - I
(13, 6, 1), -- FRI, UNIT - I
(13, 7, 1); -- SAT, UNIT - I
