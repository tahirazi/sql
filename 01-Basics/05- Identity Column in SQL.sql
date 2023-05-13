--Identity Column in SQL

--Insert into identity column
SET IDENTITY_INSERT Users ON
INSERT INTO Users ([Id],[UserName],[Password],[Email]) VALUES (4,'usman','xyz', 'usman@test.com')
SET IDENTITY_INSERT Users OFF

--Re seed identity column
DELETE FROM Users WHERE Id = 4
DBCC CHECKIDENT(Users, RESEED, 3)
INSERT INTO Users VALUES ('usman','xyz', 'usman@test.com')

--Get last generated identity column value

--In current session scope
SELECT SCOPE_IDENTITY()

--In any scope of session
SELECT @@IDENTITY

--By Table
SELECT IDENT_CURRENT('Gender')