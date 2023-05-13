-- Joins in SQL

--Syntax for JOINS
--SELECT		<ColumnsList> 
--FROM			<LeftTableName>
--<JoinType>	<RightTableName>
--ON			<JoinCondition>

--01- INNER JOIN
--It returns only matching records from both tables 
SELECT  usr.Id AS UserId, usr.UserName, usr.Email, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary
FROM Users usr
INNER JOIN UserProfiles userProfile
ON userProfile.UserId = usr.Id

--02- LEFT OUTER JOIN
--It returns mactching records from both tables and Non-Matching records from left table
SELECT  usr.Id AS UserId, usr.UserName, usr.Email, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary
FROM Users usr
LEFT OUTER JOIN UserProfiles userProfile
ON userProfile.UserId = usr.Id

--03- RIGHT OUTER JOIN
--It returns mactching records from both tables and Non-Matching records from right table
SELECT  usr.Id AS UserId, usr.UserName, usr.Email, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary
FROM Users usr
RIGHT OUTER JOIN UserProfiles userProfile
ON userProfile.UserId = usr.Id

--04- FULL OUTER JOIN
--It returns mactching and non-matching records from both tables
SELECT  usr.Id AS UserId, usr.UserName, usr.Email, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary
FROM Users usr
FULL OUTER JOIN UserProfiles userProfile
ON userProfile.UserId = usr.Id

--05- CROSS JOIN
--It returns cartesian product of two tables. We cannot use 'ON' in cross join
SELECT  usr.Id AS UserId, usr.UserName, usr.Email, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary
FROM Users usr
CROSS JOIN UserProfiles userProfile

--WHERE Clause on JOINS

--To get only Non-Mactching rows from Left table
SELECT  usr.Id AS UserId, usr.UserName, usr.Email, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary
FROM Users usr
LEFT JOIN UserProfiles userProfile
ON userProfile.UserId = usr.Id
WHERE userProfile.UserId IS NULL

--To get only Non-Mactching rows from Right table
SELECT  userProfile.UserId, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary, gender.Name AS Gender
FROM UserProfiles userProfile
RIGHT JOIN Gender gender
ON userProfile.GenderId = gender.Id
WHERE userProfile.GenderId IS NULL

--To get only Non-Mactching rows from both table
SELECT  userProfile.UserId, userProfile.FirstName + ' ' + userProfile.LastName AS FullName, userProfile.Address, userProfile.Salary, userProfile.GenderId, gender.Name AS Gender, gender.Id
FROM Gender gender 
FULL JOIN UserProfiles userProfile
ON userProfile.GenderId = gender.Id
WHERE userProfile.GenderId IS NULL OR gender.Id IS NULL


--SELF JOIN
SELECT parentDepartment.Name, childDepartment.Name AS ChildName
FROM Departments parentDepartment
INNER JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

SELECT parentDepartment.Name, childDepartment.Name AS ChildName
FROM Departments parentDepartment
LEFT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

SELECT parentDepartment.Name, childDepartment.Name AS ChildName
FROM Departments parentDepartment
RIGHT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

SELECT parentDepartment.Name, childDepartment.Name AS ChildName
FROM Departments parentDepartment
FULL JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

