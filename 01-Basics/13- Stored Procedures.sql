-- Stored Procedures

--SP without parameters
CREATE PROCEDURE spGetEmployees
AS
BEGIN
	SELECT * FROM Employees
END

--Execution of SP
EXEC spGetEmployees

--SP with parameters
CREATE PROCEDURE spGetEmployeesByDepartment
@DepartmentId INT = 0
AS
BEGIN
	SELECT * FROM Employees WHERE DepartmentId = @DepartmentId
END

--Execution of SP
spGetEmployeesByDepartment 2

-- Get text of SP
sp_helptext spGetEmployees

--Encrypted text SP
CREATE PROCEDURE spGetEmployeesByGenderAndDepartment
@Gender NVARCHAR(10),
@DepartmentId INT = 0
WITH ENCRYPTION
AS
BEGIN
	SELECT * FROM Employees WHERE DepartmentId = @DepartmentId AND Gender = @Gender
END

-- Get text of SP
sp_helptext spGetEmployeesByGenderAndDepartment

--Procedure with output parameters
--Return values one or more than one
--Any data type accepted for output parameters
CREATE PROCEDURE spGetEmployeeCountByGender
@Gender NVARCHAR(10),
@TotalCount int OUTPUT
AS
BEGIN
	SELECT @TotalCount = COUNT(Id) FROM Employees WHERE Gender = @Gender
END

--Execution of Output parameterized SP
DECLARE @EmployeeCount AS INT
EXECUTE spGetEmployeeCountByGender 'Male', @EmployeeCount OUT
PRINT @EmployeeCount

--Procedure return values
--Return value is always a single value not more than one
--Data type of return value is always int. Other than int it gives error.
--Usually used for knowing status (Success = 1 and Failure = 0)
CREATE PROC spGetAllEmployeesCout
AS
BEGIN
	RETURN (SELECT COUNT(Id) FROM Employees)
END

--Execution of return value procedure
DECLARE @TotalEmployeesCount AS INT;
EXEC @TotalEmployeesCount = spGetAllEmployeesCout
PRINT @TotalEmployeesCount

--Adventages of SP's

--01- Execution plan retention and resusability
--02- Reduces network traffic
--03- Code reusability and maintainability
--04- Better security
--05- Avoids SQL Injection attack

--Some system defined stored procedures
sp_help spGetEmployeeCountByGender
sp_helptext spGetEmployeeCountByGender
sp_depends Employees

