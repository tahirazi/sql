--Select Statement in SQL

--Simple Select statement
SELECT * FROM UserProfiles

--Filter with WHERE clause
SELECT * FROM UserProfiles WHERE Id = 1

--NOT EQUALS
SELECT * FROM UserProfiles WHERE Age != 23

-- Greater than, less than
SELECT * FROM UserProfiles WHERE Age > 23 AND Age < 30

-- IN Operator
SELECT * FROM UserProfiles WHERE Age IN (23, 28, 29)

-- LIKE Operator with different wild cards
SELECT * FROM UserProfiles WHERE FirstName LIKE 'A%'	-- Starts with 'A' and then any character(s)
SELECT * FROM UserProfiles WHERE FirstName LIKE '%b'	-- Starts with any character(s) and ends on 'b'
SELECT * FROM Users WHERE Email LIKE '%_@_%._%'			--Pattern for email. Minimum one character before and after @ sign then a dot and minimum one character after dot sign
SELECT * FROM Users WHERE Email NOT LIKE '%_@_%._%'		--Pattern for invalid email
SELECT * FROM UserProfiles WHERE FirstName LIKE '[AM]%'	--String starts with characters 'A' or 'M' and ends with any character(s)
SELECT * FROM UserProfiles WHERE FirstName LIKE '[^AM]%'--String not starts with characters 'A' or 'M' and ends with any character(s)

--TOP n
SELECT TOP 3 * FROM UserProfiles

--Order By Clause
SELECT * FROM UserProfiles ORDER BY FirstName DESC					--It's ASC by default
SELECT * FROM UserProfiles ORDER BY FirstName DESC, Address ASC		--Order By multiple columns
SELECT TOP 1 * FROM UserProfiles ORDER BY Age DESC					--Find highest age


