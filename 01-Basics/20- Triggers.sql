-- Triggers in SQL Server
--Three types of triggers
--1- DML Triggers: Fired automatically in response of DML actions (INSERT, UPDATE, DELETE)
--2- DDL Triggers
--3- Logon Triggers

--DML Triggers has two types
--1.1- After Triggers: Fires after triggering action. INSERT, UPDATE and DELETE statements causes an after trigger to fire after respective statement completed execution
--1.2- Instead of Triggers: Fires instead of triggering action. INSERT, UPDATE and DELETE statements causes an instead of trigger to fire INSTEAD OF respective statement execution

--1.1- After Triggers
--After Insert Trigger
CREATE TRIGGER tr_Employee_ForInsert
ON Employees
FOR INSERT
AS
BEGIN
	DECLARE @Id AS INT, @Name AS NVARCHAR(200)
	SELECT @Id = Id, @Name = FirstName + ' ' + LastName FROM inserted
	INSERT INTO EmployeeLogs VALUES 
	(
		@Id,
		GETDATE(),
		NULL,
		NULL,
		'Insert',
		'Employee Added with Name: ' + @Name + ' ,ID: ' + CAST(@Id AS NVARCHAR(5)) + '. at: ' + CAST(GETDATE() AS NVARCHAR(20))
	)
END
GO

--After Delete Trigger
CREATE TRIGGER tr_Employee_ForDelete
ON Employees
FOR DELETE
AS
BEGIN
	DECLARE @Id AS INT, @Name AS NVARCHAR(200)
	SELECT @Id = Id, @Name = FirstName + ' ' + LastName FROM deleted
	INSERT INTO EmployeeLogs VALUES 
	(
		@Id,
		NULL,
		NULL,
		GETDATE(),
		'Delete',
		'Employee Deleted with Name: ' + @Name + ' ,ID: ' + CAST(@Id AS NVARCHAR(5)) + '. at: ' + CAST(GETDATE() AS NVARCHAR(20))
	)
END
GO

--After UPDATE Trigger
ALTER TRIGGER tr_Employee_ForUpdate
ON Employees
FOR UPDATE
AS
BEGIN
	DECLARE @OldId AS INT, @OldName AS NVARCHAR(200),
	@Id AS INT, @Name AS NVARCHAR(200)
	SELECT @OldId = Id, @OldName = FirstName + ' ' + LastName FROM deleted
	SELECT @Id = Id, @Name = FirstName + ' ' + LastName FROM inserted
	INSERT INTO EmployeeLogs VALUES 
	(
		@Id,
		NULL,
		GETDATE(),
		NULL,
		'Update',
		'Employee Updated with Name: ' + @OldName + ' ,ID: ' + CAST(@OldId AS NVARCHAR(5)) + '. at: ' + CAST(GETDATE() AS NVARCHAR(20)) +
		'To New Info: ' + @Name + ' ,ID: ' + CAST(@Id AS NVARCHAR(5)) + '. at: ' + CAST(GETDATE() AS NVARCHAR(20))
	)
END
GO

--Test after insertion, deletion, updation
INSERT INTO Employees VALUES('Inam', 'Khan', 'Male', 78920, 'Some address', 'Peshawar', 'KPK', 'Pakistan', NULL, 9)
DELETE FROM Employees WHERE Id = 23
SELECT * FROM EmployeeLogs
UPDATE Employees SET FirstName = 'Inam Ul Haq' WHERE Id = 24
SELECT * FROM EmployeeLogs
GO


--1.2- Instead of Triggers
--Create a view for employees
CREATE VIEW vWEmployeeDetails
AS
 SELECT employee.Id, employee.FirstName, employee.LastName, employee.Gender, employee.Salary, employee.Address, employee.City, employee.State, employee.Country, employee.UserId, department.Name
 FROM Employees employee
 JOIN Departments department
 ON employee.DepartmentId = department.Id
 GO

 --Create an Instead Of Insert Trigger for this view (vWEmployeeDetails) to add correct data in underlying table
CREATE TRIGGER tr_vWEmployeeDetails_InsteadOfInsert
ON vwEmployeeDetails
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @DepartmentId INT
	SELECT @DepartmentId = department.Id FROM Departments department
	JOIN inserted
	ON inserted.Name = department.Name
	IF(@DepartmentId IS NULL)
	BEGIN
		RAISERROR('Invalid department name. Statement terminated.', 16, 1)
		RETURN
	END
	INSERT INTO Employees (FirstName, LastName, Gender, Salary, Address, City, State, Country, UserId, DepartmentId) 
	SELECT FirstName, LastName, Gender, Salary, Address, City, State, Country, UserId, @DepartmentId FROM inserted
END
GO

INSERT INTO vwEmployeeDetails (FirstName, LastName, Gender, Salary, Address, City, State, Country, UserId, Name)
VALUES ('Ab', 'De villiers', 'Male', 78920, 'Some address', 'South', 'MNO', 'South Africa', NULL, 'adfdsfsdf')

SELECT * FROM vWEmployeeDetails
GO

--Instead of delete trigger
CREATE TRIGGER tr_vWEmployeeDetails_InsteadOfDelete
ON vwEmployeeDetails
INSTEAD OF DELETE
AS
BEGIN
	DELETE Employees FROM Employees
	JOIN deleted 
	ON Employees.Id = deleted.Id
END
GO


