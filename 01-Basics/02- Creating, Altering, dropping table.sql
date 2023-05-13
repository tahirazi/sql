--Basic Working with a table

--CREATE TABLE
CREATE TABLE Users 
(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	UserName NVARCHAR(150) NOT NULL,
	Password NVARCHAR(150) NOT NULL,
	Email NVARCHAR(200) NOT NULL
)

CREATE TABLE Gender 
(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Name NVARCHAR(50) NOT NULL,
)

CREATE TABLE UserProfiles
(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(150) NOT NULL,	
	LastName NVARCHAR(150) NOT NULL,	
	Address NVARCHAR(150) NOT NULL,
	UserId INT NOT NULL,
	GenderId INT NULL
)

INSERT INTO Gender VALUES ('Male')
INSERT INTO Gender VALUES ('Female')
INSERT INTO Gender VALUES ('Unknown')

INSERT INTO Users VALUES ('ali', '123', 'ali@test.com')
INSERT INTO Users VALUES ('ahmed', 'abc', 'ahmed@test.com')
INSERT INTO Users VALUES ('Maha', 'mno', 'maha@test.com')

--ALTER TABLE add default constraint
ALTER TABLE UserProfiles 
ADD CONSTRAINT Default_UserProfiles_GenderId
DEFAULT 3 FOR GenderId

INSERT INTO UserProfiles (FirstName, LastName, Address, UserId, GenderId)
VALUES ('Ali', 'Raza', 'Johar Town, Lahore, Pakistan', 1, 1)
INSERT INTO UserProfiles (FirstName, LastName, Address, UserId, GenderId)
VALUES ('Ahmed', 'Abbas', 'Wapda Town, Rawalpindi, Pakistan', 2)
INSERT INTO UserProfiles (FirstName, LastName, Address, UserId, GenderId)
VALUES ('Maha', 'Siddiqui', 'Iqbal Town, Karachi, Pakistan', 3, 2)

--DROPPING A CONSTRAINT
ALTER TABLE UserProfiles 
DROP CONSTRAINT Default_UserProfiles_GenderId

--Company Table
CREATE TABLE Companies
(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(250) NOT NULL,
	[Description] NVARCHAR(250) NULL
)

--Department Table
CREATE TABLE Departments
(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(250) NOT NULL,
	[Description] NVARCHAR(250) NULL,
	ParentId INT NULL,
	CompanyId INT NULL
)

--Employee Table
CREATE TABLE Employees
(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(150) NOT NULL,	
	LastName NVARCHAR(150) NOT NULL,	
	Gender NVARCHAR(10) NOT NULL,
	Salary NUMERIC(18,2) NULL,
	Address NVARCHAR(150) NOT NULL,
	City NVARCHAR(150) NOT NULL,
	State NVARCHAR(150) NOT NULL,
	Country NVARCHAR(150) NOT NULL,
	UserId INT NULL,
	DepartmentId INT NULL
)

--Test Table
CREATE TABLE [dbo].[TestTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
 CONSTRAINT [PK_TestTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


