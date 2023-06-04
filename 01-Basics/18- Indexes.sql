--Indexes
--If no index exists system will perform table scan to reterieve data. It's very slow and performance compromising.
--Purpose is fast searching and improve performance

--Clustered Index
--Index that arrange rows physically in the memory in sorted order
--By default primary key is clustered index
--Only one clustered index of a table at one time

--Simple Index : It's one column index
--CREATE Index
CREATE  INDEX IX_Employees_Salary ON Employees(Salary)

--To see help index text
sp_helpindex 'Employees'

--Composite Index : Index combined with multiple columns
CREATE  INDEX IX_Employees_CountryStateCity ON Employees(Country ASC, State ASC, City ASC)

--Unique Index
--Created with UNIQUE Keyword
--If try to create on columns that have duplicate records, then unique index not be created and give error.
CREATE UNIQUE INDEX UQ_IX_Users_Email ON Users(Email)
sp_helpindex 'Users'

---------------------------------Adventages on Areas -----------------------------------

--SELECT statement with WHERE clause
SELECT * FROM Employees WHERE Salary > 2000 AND Salary <=10000
--Similarly
--DELETE AND UPDATE statements
--ORDER BY statements
--GROUP BY statements

---------------------------------Disadventages -----------------------------------------

--Required more disk space because indexes saved separatly from original table
--INSERT, UPDATE, DELETE may be slow on large tables, because each DML query also updates all indexes along with data