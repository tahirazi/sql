--Derived Table and CTE in SQL
--Derived Table
SELECT Department, TotalEmployees FROM
	(
		SELECT Name AS Department, Departments.Id, COUNT(*) AS TotalEmployees 
		FROM Employees
		JOIN Departments
		ON Employees.Id = Departments.Id
		GROUP BY Departments.Id, Departments.Name
	)
AS EmployeeCount --This is derived table
WHERE TotalEmployees >= 2
GO

--CTE
--CTE used to simplify various classes of SQL Queries for which a derived table was just unsuitable. 
--It is a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. 
--You can also use a CTE in a CREATE view, as part of the view’s SELECT query. 
--In addition, as of SQL Server 2008, you can add a CTE to the new MERGE statement. 

--A CTE is a powerful SQL construct that helps simplify queries. 
--CTEs act as virtual tables (with records and columns) that are created during query execution.
--Query must follows immediately after CTE. If any query in between CTE and used query it'll not be available
--Deleted after the query executes.

--Creating a CTE
WITH EmployeeCounter(DepartmentId, Total)
AS
(
	SELECT DepartmentId, Count(*) AS Total FROM Employees
	GROUP BY DepartmentId
)
SELECT Name, Total
FROM Departments
INNER JOIN EmployeeCounter
ON Departments.Id = EmployeeCounter.DepartmentId
GO

WITH StateWiseUserCounter(State, TotalUsers)
AS
(
	SELECT State, COUNT(UserId) AS TotalUsers 
	FROM UserProfiles
	GROUP BY State
)
SELECT * FROM StateWiseUserCounter
GO

--Creating multiple CTEs
WITH EmployeeCounterFirstThreeDepartments(DepartmentId, Total)
AS
(
	SELECT DepartmentId, Count(*) AS Total FROM Employees WHERE DepartmentId IN (1,2,3)
	GROUP BY DepartmentId
),
EmployeeCounterSecondThreeDepartments(DepartmentId, Total)
AS
(
	SELECT DepartmentId, Count(*) AS Total FROM Employees WHERE DepartmentId IN (4,5,9)
	GROUP BY DepartmentId
)
SELECT * FROM EmployeeCounterFirstThreeDepartments
UNION
SELECT * FROM EmployeeCounterSecondThreeDepartments
GO

--------------------------------------------------Updating a CTE --------------------------------------------
--If a CTE is updated it can update table record also
--Is CTE updateable???
--Yes
--If a CTE is based on one base table
--If CTE is based on more than one table and UPDATE affects only one base table
--No
---If CTE is based on more than one table and UPDATE affects more than one base table

--------------------------------------------------Recursive CTE --------------------------------------------

--ParentChildHierarchy
WITH RecursiveParentChild(Id, Name, Description, ParentId, [Level])
AS
(
	SELECT parent.Id, parent.Name, parent.Description, parent.ParentId, 1 
	FROM ParentChildHierarchy parent
	WHERE parent.ParentId  IS NULL
	UNION ALL
	SELECT child.Id, child.Name, child.Description, child.ParentId, recursiveParent.Level + 1 
	FROM ParentChildHierarchy child
	JOIN RecursiveParentChild recursiveParent
	ON child.ParentId = recursiveParent.Id
)
SELECT empCte.Name AS Employee, empCte.Description, ISNULL(managerCte.Name, 'Super Manager') AS Manager, empCte.[Level] 
FROM RecursiveParentChild empCte
LEFT JOIN RecursiveParentChild managerCte
ON empCte.ParentId = managerCte.Id
