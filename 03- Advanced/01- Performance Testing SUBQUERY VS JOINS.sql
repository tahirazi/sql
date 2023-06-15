--Performance Testing SUBQUERY VS JOINS

--Creating tables with large data

-- If Table exists drop the tables
IF (EXISTS (SELECT * 
            FROM information_schema.tables 
            WHERE table_name = 'tblProductSales'))
BEGIN
 DROP TABLE tblProductSales
END

IF (EXISTS (SELECT * 
            FROM information_schema.tables 
            WHERE table_name = 'tblProducts'))
BEGIN
 DROP TABLE tblProducts
END

-- Recreate tables
CREATE TABLE tblProducts
(
 [Id] INT IDENTITY PRIMARY KEY,
 [Name] NVARCHAR(50),
 [Description] NVARCHAR(250)
)

CREATE TABLE tblProductSales
(
 Id INT PRIMARY KEY IDENTITY,
 ProductId INT FOREIGN KEY REFERENCES tblProducts(Id),
 UnitPrice INT,
 QuantitySold INT
)

--Insert Sample data into tblProducts table
DECLARE @Id INT
SET @Id = 1

WHILE(@Id <= 400000)
BEGIN
 INSERT INTO tblProducts VALUES('Product - ' + CAST(@Id AS NVARCHAR(20)), 
 'Product - ' + CAST(@Id AS NVARCHAR(20)) + ' Description')
 
 PRINT @Id
 SET @Id = @Id + 1
END

-- Declare variables to hold a random ProductId, 
-- UnitPrice and QuantitySold
DECLARE @RandomProductId INT
DECLARE @RandomUnitPrice INT
DECLARE @RandomQuantitySold INT

-- Declare and set variables to generate a 
-- random ProductId between 1 and 100000
DECLARE @UpperLimitForProductId INT
DECLARE @LowerLimitForProductId INT

SET @LowerLimitForProductId = 1
SET @UpperLimitForProductId = 100000

-- Declare and set variables to generate a 
-- random UnitPrice between 1 and 100
DECLARE @UpperLimitForUnitPrice INT
DECLARE @LowerLimitForUnitPrice INT

SET @LowerLimitForUnitPrice = 1
SET @UpperLimitForUnitPrice = 100

-- Declare and set variables to generate a 
-- random QuantitySold between 1 and 10
DECLARE @UpperLimitForQuantitySold INT
DECLARE @LowerLimitForQuantitySold INT

SET @LowerLimitForQuantitySold = 1
SET @UpperLimitForQuantitySold = 10

--Insert Sample data into tblProductSales table
DECLARE @Counter INT
SET @Counter = 1

WHILE(@Counter <= 950000)
BEGIN
 SELECT @RandomProductId = ROUND(((@UpperLimitForProductId - @LowerLimitForProductId) * RAND() + @LowerLimitForProductId), 0)
 SELECT @RandomUnitPrice = ROUND(((@UpperLimitForUnitPrice - @LowerLimitForUnitPrice) * RAND() + @LowerLimitForUnitPrice), 0)
 SELECT @RandomQuantitySold = ROUND(((@UpperLimitForQuantitySold - @LowerLimitForQuantitySold) * RAND() + @LowerLimitForQuantitySold), 0)
 
 INSERT INTO tblProductsales 
 VALUES(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

 PRINT @Counter
 SET @Counter = @Counter + 1
END

--To check inserted data
SELECT * FROM tblProducts
SELECT * FROM tblProductSales

--Clear query and execution plan cache
CHECKPOINT; 
GO 
DBCC DROPCLEANBUFFERS; -- Clears query cache
Go
DBCC FREEPROCCACHE; -- Clears execution plan cache
GO

--According to MSDN, in sql server, in most cases, there is usually no performance difference between queries that uses sub-queries and equivalent queries using joins.

--With Subquery
--1 seconds 99,993 records
SELECT Id, Name, Description
FROM tblProducts
WHERE ID IN
(
 SELECT ProductId FROM tblProductSales
)

--According to MSDN, in some cases where existence must be checked, a join produces better performance. 
----Otherwise, the nested query must be processed for each result of the outer query. 
----In such cases, a join approach would yield better results.

-- 2 Seconds 300,007 rows
SELECT Id, Name, [Description]
FROM tblProducts
WHERE Not Exists(SELECT * FROM tblProductSales WHERE ProductId = tblProducts.Id)

-- 2 Seconds 300,007 rows
SELECT tblProducts.Id, Name, [Description]
FROM tblProducts
LEFT JOIN tblProductSales
ON tblProducts.Id = tblProductSales.ProductId
WHERE tblProductSales.ProductId IS NULL 