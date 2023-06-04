--Functions in SQL

--Scalar valued functions
--01-Find Age by Date of Birth
CREATE FUNCTION GetAgeByBirthDate (@BirthDate DATETIME)
RETURNS NVARCHAR(100)
AS
BEGIN
DECLARE @CurrentDate DATE = GETDATE()
RETURN
		CAST(DATEDIFF(YEAR, @BirthDate, @CurrentDate) AS VARCHAR) + ' Years ' +
		CAST(DATEDIFF(MONTH, @BirthDate, @CurrentDate) % 12 AS VARCHAR) + ' Months ' +
		CAST(DATEDIFF(DAY, DATEADD(MONTH, DATEDIFF(MONTH, @BirthDate, @CurrentDate), @BirthDate), @CurrentDate) AS VARCHAR) + ' Days'
END
--Calling function
SELECT dbo.GetAgeByBirthDate('06-10-1986') AS Age

--Inline table valued function
CREATE FUNCTION GetEmployeeByGender(@Gender NVARCHAR(6))
RETURNS TABLE
RETURN
SELECT * FROM Employees WHERE Gender = @Gender
--Calling function
SELECT * FROM dbo.GetEmployeeByGender('Male')

--Multi statement table valued function
CREATE FUNCTION GetEmployeeByCity(@City NVARCHAR(50))
RETURNS @Table TABLE (Name NVARCHAR(100), Gender NVARCHAR(10), Salary NUMERIC(18,0))
AS
BEGIN
	INSERT INTO @Table SELECT FirstName + ' ' + LastName AS Name, Gender, Salary FROM Employees WHERE City = @City
RETURN
END

--Calling function
SELECT * FROM dbo.GetEmployeeByCity('Lahore')