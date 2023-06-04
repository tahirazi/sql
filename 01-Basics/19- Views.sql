--Views
--It's considered as a virtual table
--A saved SQL query

---------------------------------------- Adventages ----------------------------------------
--Reduce complexity of Database schema
--Used to implement rows and columns level security
--Used to present aggregated data and hide detailed data

--CREATE view
CREATE VIEW vWUserWithProfile
AS
SELECT 
	usr.UserName, usr.Email, usr.Password,
	profiles.FirstName, profiles.LastName, profiles.Salary, gender.Name AS Gender
FROM Users usr
INNER JOIN UserProfiles profiles 
ON profiles.UserId = usr.Id
INNER JOIN Gender gender
ON profiles.GenderId = gender.Id
GO
--Selection from view
-- Schema is simple now. Complexity reduced by using view
SELECT * FROM vWUserWithProfile
GO

--View with row level security 
CREATE VIEW vWUserWithProfileByCity
AS
SELECT 
	usr.UserName, usr.Email, usr.Password,
	profiles.FirstName, profiles.LastName, profiles.Salary, gender.Name AS Gender
FROM Users usr
INNER JOIN UserProfiles profiles 
ON profiles.UserId = usr.Id
INNER JOIN Gender gender
ON profiles.GenderId = gender.Id
WHERE City = 'Lahore'
GO
-- Only concerned data retured instead of all
SELECT * FROM vWUserWithProfileByCity
GO

--View with column level security 
CREATE VIEW vWUserWithProfileNonConfidentialOnly
AS
SELECT 
	usr.Email,
	profiles.FirstName, profiles.LastName, gender.Name AS Gender
FROM Users usr
INNER JOIN UserProfiles profiles 
ON profiles.UserId = usr.Id
INNER JOIN Gender gender
ON profiles.GenderId = gender.Id
GO
-- Only non-confidential data retured. 
--Confidetial columns like username, password, salary are removed
SELECT * FROM vWUserWithProfileNonConfidentialOnly
GO

--View with only aggregated Data
CREATE VIEW vWUsersSummaryByState
AS
SELECT 
	profiles.State,
	COUNT(usr.Id) AS TotalUsers
FROM Users usr
INNER JOIN UserProfiles profiles 
ON profiles.UserId = usr.Id
GROUP BY profiles.State
GO
-- Only aggregated data retured
-- Detailed data hidden
SELECT * FROM vWUsersSummaryByState
GO

-------------------------------------- CRUD using views -------------------------------------- 
--Insert, update or delete statement also affect data into underlying table

--Simple View with single table
CREATE VIEW vWUserProfile
AS
SELECT FirstName, LastName, Address, UserId, GenderId, Age, Salary, City, State, Country
FROM UserProfiles
GO

--Insert statement using view
INSERT INTO vWUserProfile VALUES ('MNOPQ', 'RSTVU', 'address', 3, 1, 20, 16000, 'New Youk', 'Albama', 'United States')
GO
SELECT * FROM vWUserProfile

--Update statement using view
UPDATE vWUserProfile SET FirstName = 'JohnyAbc', LastName = 'HeartsDef' WHERE FirstName = 'MNOPQ' AND LastName = 'RSTVU'
GO
SELECT * FROM vWUserProfile

--Delete statement using view
DELETE FROM vWUserProfile  WHERE FirstName = 'JohnyAbc' AND LastName = 'HeartsDef'
GO
SELECT * FROM vWUserProfile
GO

-------------------!! PRECAUTION !!-------------------

--Dont use CRUD on a view that has multiple tables, it may make incorrect data in tables
--Use TRIGGER to achieve CRUD accurately on views
-----------------------------------------------------------------------------------------
--Indexed View
---------------------------- Guildelines for Indexed View ----------------------------
--01- Should be created 'WITH SCHEMABINDING' option.
--02- If select list consists an aggregate function which references and expression and there is possibility for expression to become NULL,
----- then a replacement value should be specified. (e.g. ISNULL(<Expression>, 0))
--03- If GROUP BY is specified, the view select list must contain a COUNT_BIG(*) expression. (e.g. COUNT_BIG(*))
--04- The base table in the view, should be referenced with two part name. (e.g dbo.tableName)

--Example
CREATE VIEW vWProductWithTotalSales
WITH SCHEMABINDING
AS
SELECT
	DisplayName,
	SUM(ISNULL((Quantity * TotalPrice), 0)) AS TotalSales,
	COUNT_BIG(*) AS TotalTransactions
FROM [dbo].[Sales]
INNER JOIN [dbo].[ProductDetails]
ON [dbo].[ProductDetails].Id = [dbo].[Sales].ProductId 
GROUP BY DisplayName
GO

--Creating index on view
CREATE UNIQUE CLUSTERED INDEX IX_vWProductWithTotalSales_Name
ON vWProductWithTotalSales(DisplayName)
GO
--Selection of data in indexed view
SELECT * FROM vWProductWithTotalSales
GO
--This is a materialized view
--It consists of data
--Best for performance on scenarios where no frequent changes in data
-------------------------------------------------------------------------------------------------------

--------------------------------------------View Limitations-------------------------------------------
-- 01- View cannot be parameterized
-- 02- Rules and Defaults cannot be associated with views because these are not real tables, views are virtual
-- 03- ORDER BY clause is invalid in views unless TOP or FOR XML is also specified
-- 04- Views cannot be based on temporary tables