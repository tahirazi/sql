-- System defined functions
--01- String functions

SELECT ASCII('B') AS ASCI
SELECT CHAR(66) AS Character

--Printing A to Z by converting ASCII to CHAR
DECLARE @Start AS INT = 65
WHILE(@Start <=90)
BEGIN
	PRINT CHAR(@Start)
	SET @Start = @Start + 1
END

--LTRIM() is used to remove white spaces from left side of string
SELECT LTRIM('    HelloWorld    ') AS String
--RTRIM() is used to remove white spaces from right side of string
SELECT RTRIM('    HelloWorld    ') AS String
SELECT RTRIM(LTRIM('    HelloWorld    ')) AS String

--LOWER() is used to make string in lower case
SELECT LOWER('HELLO WORLD') AS LowerString
--UPPER() is used to make string in upper case
SELECT UPPER('hello world') AS UpperString
--REVERSE() is used to reverse input string
SELECT REVERSE('Hello World') AS ReversedString
--LEN() is used to count length of given string
SELECT LEN('HELLO WORLD') AS StringCount

--LEFT() returns string from left side by given number of characters
SELECT LEFT('HelloWorld',5) AS LeftString
--RIGHT() returns string from right side by given number of characters
SELECT RIGHT('HelloWorld',5) AS RightString
--CHARINDEX() is used to find index of given character(s) from a string with optional starting position
SELECT CHARINDEX('w','HelloWorld',1) AS StringIndex
--SUBSTRING() returns part of a string from given string expression
SELECT SUBSTRING('abc@test.com',5,8) AS SubStringValue

--Real time example
SELECT SUBSTRING(Email,CHARINDEX('@', Email)+1, LEN(Email) - CHARINDEX('@', Email)) AS Domain, COUNT(Id) AS TotalUsers
FROM Users
GROUP BY SUBSTRING(Email,CHARINDEX('@', Email)+1, LEN(Email) - CHARINDEX('@', Email))

--REPLICATE() used to replicate text  
SELECT REPLICATE('Text ',3) AS ReplicatedString
--SPACE() used to give spaces between string
SELECT 'Hello' + SPACE(10) + 'World' AS SpacedString
--REPLACE() used to replace given text with other text
SELECT REPLACE(Email, '.com', '.net') AS ChangedDomain FROM Users
--PATINDEX() is used to find index of a pattern in a string
SELECT Email, PATINDEX('%@test.com', Email) AS FirstOccurence FROM Users
SELECT Email, PATINDEX('%@test.com', Email) AS FirstOccurence FROM Users WHERE PATINDEX('%@test.com', Email) > 0

--Masked Email example
SELECT UserName, SUBSTRING(Email, 1,2) + REPLICATE('*', 4) + SUBSTRING(Email, CHARINDEX('@', Email),LEN(Email) - CHARINDEX('@', Email) + 1) AS Email
FROM Users

--STUFF() used to replace a specific portion of a string with another string
SELECT Email, STUFF(Email, 2, 3, '***') AS StuffedEmail FROM Users
--Query to take first charecter of email, make rest characters * till @ sign
SELECT Email, STUFF(Email, 2, CHARINDEX('@', Email) -2,REPLICATE('*', CHARINDEX('@', Email) -2)) AS StuffedEmail FROM Users

