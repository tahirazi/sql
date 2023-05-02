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

