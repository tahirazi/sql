USE [MasteringSql]
GO
--INSERT Statements
INSERT INTO [dbo].[Companies] ([Name] ,[Description])  VALUES ('Azad Mega Mart', 'A Project of Azad Group of Companies.')
INSERT INTO [dbo].[Companies] ([Name] ,[Description])  VALUES ('Standard Aluminum', 'By Izhar Group of companies.')
INSERT INTO [dbo].[Companies] ([Name] ,[Description])  VALUES ('STEPS', 'Academy of learning freelancing, web and graphic designing.')
INSERT INTO [dbo].[Companies] ([Name] ,[Description])  VALUES ('AirCod Technologies', 'An SWI America subcompany for Software Engineering services.')
INSERT INTO [dbo].[Companies] ([Name] ,[Description])  VALUES ('ArhamSoft Pvt. Ltd.', 'Company for software engineering services')
INSERT INTO [dbo].[Companies] ([Name] ,[Description])  VALUES ('SalSoft Inc.', 'Software industry company.')

INSERT INTO Departments VALUES ('Information Systems', 'All services for Information Technology', NULL, 4)
INSERT INTO Departments VALUES ('Web Development', '.NET web development department', 1, 4)
INSERT INTO Departments VALUES ('Mobile Development', 'Flutter mobile development department', 1, 4)
INSERT INTO Departments VALUES ('IT and Networks', 'For IT support and networks.', 1, 4)
INSERT INTO Departments VALUES ('Human Resources', 'An HR services Department', NULL, 4)
INSERT INTO Departments VALUES ('Dummy 1', 'Dummy', NULL, NULL)
INSERT INTO Departments VALUES ('Dummy 2', 'Dummy', NULL, NULL)
INSERT INTO Departments VALUES ('IT', 'IT Department', NULL, 5)
INSERT INTO Departments VALUES ('Networks', 'Under IT Department', 8, 5)
INSERT INTO Departments VALUES ('Development', 'Development', NULL, 5)
INSERT INTO Departments VALUES ('Software Development', 'Under Development Department', NULL, 6)

INSERT INTO Employees VALUES('Majid', 'Hussain', 'Male', 20530, 'Samahni', 'Bhimber', 'AJK', 'Pakistan', NULL, 2)
INSERT INTO Employees VALUES('Imran', 'Umer', 'Male', 30210, 'Iqbal Town', 'Lahore', 'Punjab', 'Pakistan', NULL, 2)
INSERT INTO Employees VALUES('Sajid', 'Ali', 'Male', 67500, 'Johar Town', 'Lahore', 'Punjab', 'Pakistan', NULL, 2)
INSERT INTO Employees VALUES('Usama', 'Mushtaq', 'Male', 56750, 'Gulistan e Johar', 'Karachi', 'Sindh', 'Pakistan', NULL, 2)
INSERT INTO Employees VALUES('Ali', 'Raza', 'Male', 90870, 'Keamari', 'Karachi', 'Sindh', 'Pakistan', NULL, 2)
INSERT INTO Employees VALUES('Sehar', 'Maqsood', 'Female', 40890, 'City town', 'Koetta', 'Balochistan', 'Pakistan', NULL, 2)
INSERT INTO Employees VALUES('Naima', 'Ali', 'Female', 30890, 'Wapda Town', 'Rawalpindi', 'Punjab', 'Pakistan', NULL, 2)
INSERT INTO Employees VALUES('Unaiza', 'Khan', 'Female', 67890, 'Kohe noor city', 'Koetta', 'Balochistan', 'Pakistan', NULL, 5)
INSERT INTO Employees VALUES('Khalid', 'Ahmed', 'Male', 208070, 'Bahria Town', 'Lahore', 'Punjab', 'Pakistan', NULL, 5)
INSERT INTO Employees VALUES('Mohsin', 'Raza', 'Male', 56420, 'Johar Town', 'Lahore', 'Punjab', 'Pakistan', NULL, 3)
INSERT INTO Employees VALUES('Salman', 'Umar', 'Male', 67890, 'Iqbal Town', 'Lahore', 'Punjab', 'Pakistan', NULL, 3)
INSERT INTO Employees VALUES('EMP Dummy 1', '1', 'Dummy', 10, 'A', 'B', 'C', 'Pakistan', NULL, NULL)
INSERT INTO Employees VALUES('EMP Dummy 2', '2', 'Dummy2', 20, 'C', 'D', 'E', 'Pakistan', NULL, NULL)
INSERT INTO Employees VALUES('EMP Dummy 3', '3', 'Other', NULL, 'H', 'N', 'O', 'P', NULL, NULL)
INSERT INTO Employees VALUES('Uzair', 'Khan', 'Male', 50390, 'Some Address', 'Haider Abad', 'Sindh', 'Pakistan', NULL, 9)
INSERT INTO Employees VALUES('Umar', 'Tariq', 'Male', 78920, 'Some address', 'Peshawar', 'KPK', 'Pakistan', NULL, 9)




