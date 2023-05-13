-- Using COALESCE()

SELECT Id, COALESCE(FirstName, MiddleName, LastName) AS Name FROM TestTable

--To see difference
SELECT * FROM TestTable