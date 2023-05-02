--Constraints in SQL

ALTER TABLE UserProfiles ADD
Age INT NULL
GO
--CHECK Constraint
ALTER TABLE UserProfiles 
ADD CONSTRAINT CK_UserProfiles_Age CHECK (Age > 0 AND Age < 200)
GO
SELECT * FROM UserProfiles
--To see how it works
INSERT INTO UserProfiles (FirstName, LastName, Address, UserId, GenderId, Age)
VALUES ('Faran', 'Aqib', 'AJK', 1, 1, -90)
UPDATE UserProfiles SET Age = 23 WHERE Id = 1
UPDATE UserProfiles SET Age = 900 WHERE Id = 2