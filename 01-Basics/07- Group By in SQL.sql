-- Group By in SQL

--Need to add some columns in table to perform group by
ALTER TABLE UserProfiles
ADD Salary DECIMAL(18,0) NULL,
City NVARCHAR(250) NULL,
[State] NVARCHAR(250) NULL,
Country NVARCHAR(250) NULL

--Simple Group By with aggregate SUM() of Salary by City
SELECT City, SUM(Salary) AS TotalSalary FROM UserProfiles
GROUP BY City

--Group By on Multiple
SELECT State, City, SUM(Salary) AS TotalSalary, COUNT(Id) AS TotalEmployees FROM UserProfiles
GROUP BY State, City
ORDER BY City

--Group By -- Filter with 'WHERE'
SELECT State, City, SUM(Salary) AS TotalSalary, COUNT(Id) AS TotalEmployees FROM UserProfiles
WHERE State = 'Punjab'		--It filters here and then Group
GROUP BY State, City
ORDER BY City

--Group By -- Filter with 'HAVING'
SELECT State, City, SUM(Salary) AS TotalSalary, COUNT(Id) AS TotalEmployees FROM UserProfiles
GROUP BY State, City
HAVING State = 'Sindh'		--It first Group then filters at end
ORDER BY City

--Aggregation on Filter

--We cann't use aggregate function directly in WHERE. If needed we'll use subquery
--We can use aggregate function directly on HAVING
SELECT State, City, SUM(Salary) AS TotalSalary, COUNT(Id) AS TotalEmployees FROM UserProfiles
GROUP BY State, City
HAVING SUM(Salary) > 100000
ORDER BY City


