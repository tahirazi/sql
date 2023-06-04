--Temporary tables
--It has two types 

------------------------------------------ 01- Local Temp tables ------------------------------------------ 
--These are visible only to the connection that creates it
--Deleted when the connection is closed.
--Deleted when procedure end execution
CREATE TABLE #TempTable (Id INT, UserName NVARCHAR(30), Password NVARCHAR(100))
INSERT INTO #TempTable VALUES (1,'user01', 'abc')
INSERT INTO #TempTable VALUES (2,'user02', 'def')
INSERT INTO #TempTable VALUES (3,'user03', 'ghi')
SELECT * FROM #TempTable

--Table variables (DECLARE @t TABLE) are visible only to the connection that creates it
--Deleted when the batch or stored procedure ends.
DECLARE @ProductTable TABLE (
    ProductName VARCHAR(MAX) NOT NULL,
    BrandId INT NOT NULL,
    ListPrice DEC(11,2) NOT NULL
);
INSERT INTO @ProductTable VALUES ('Earpads', 1, 100)
INSERT INTO @ProductTable VALUES ('Keyboard', 2, 150)
INSERT INTO @ProductTable VALUES ('Mouse', 3, 120)
SELECT * FROM @ProductTable

------------------------------------------ 02- Global Temp tables ------------------------------------------ 
--Global temporary tables (CREATE TABLE ##t) are visible to everyone
--Deleted when all connections that have referenced them have closed.
CREATE TABLE ##GlobalTempTable (Id INT, UserName NVARCHAR(30), Password NVARCHAR(100))
INSERT INTO ##GlobalTempTable VALUES (1,'user01', 'abc')
INSERT INTO ##GlobalTempTable VALUES (2,'user02', 'def')
INSERT INTO ##GlobalTempTable VALUES (3,'user03', 'ghi')
SELECT * FROM ##GlobalTempTable

--Tempdb permanent tables (USE tempdb CREATE TABLE t) are visible to everyone
--Deleted when the server is restarted.
USE tempdb
GO
CREATE TABLE TemporaryProducts
(
    ProductName VARCHAR(MAX) NOT NULL,
    BrandId INT NOT NULL,
    ListPrice DEC(11,2) NOT NULL
);
INSERT INTO TemporaryProducts VALUES ('Earpads', 1, 100)
INSERT INTO TemporaryProducts VALUES ('Keyboard', 2, 150)
INSERT INTO TemporaryProducts VALUES ('Mouse', 3, 120)
SELECT * FROM TemporaryProducts

--To Drop Tables simply use DROP Command
DROP TABLE #TempTable
DROP TABLE ##GlobalTempTable
DROP TABLE TemporaryProducts