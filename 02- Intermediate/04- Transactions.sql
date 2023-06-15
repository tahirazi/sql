--Transactions in SQL Server

--A transaction is a group of commands that change the data stored in a database. 
--It is treated as a single unit. 
--It ensures that, either all of the commands succeed, or none of them. 
--If one of the commands in the transaction fails, all of the commands fails, and any data that was modified in the database is rolled back. 
--Transactions maintain the integrity of data in a database.

--Transaction processing steps:
----1. Begin a transaction.
----2. Process database commands.
----3. Check for errors. 
------   If errors occurred
------       rollback the transaction
------   else
------       commit the transaction

---------------------------------- Pre Requisits -----------------------------------------
 --To create table tblMailingAddress
CREATE TABLE tblMailingAddress
(
   AddressId INT NOT NULL PRIMARY KEY,
   EmployeeNumber INT,
   HouseNumber NVARCHAR(50),
   StreetAddress NVARCHAR(50),
   City NVARCHAR(10),
   PostalCode NVARCHAR(50)
)
--To add data into table
INSERT INTO tblMailingAddress VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

--To create table tblPhysicalAddress
CREATE TABLE tblPhysicalAddress
(
 AddressId INT NOT NULL PRIMARY KEY,
 EmployeeNumber INT,
 HouseNumber NVARCHAR(50),
 StreetAddress NVARCHAR(50),
 City NVARCHAR(10),
 PostalCode NVARCHAR(50)
)
--To add data into table
INSERT INTO tblPhysicalAddress VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')
GO

--Create a procedure to update data on both tables
CREATE PROCEDURE spUpdateAddress
AS
BEGIN
 BEGIN TRY
  BEGIN TRANSACTION
   UPDATE tblMailingAddress SET City = 'LONDON' 
   WHERE AddressId = 1 AND EmployeeNumber = 101
   
   UPDATE tblPhysicalAddress SET City = 'LONDON' 
   WHERE AddressId = 1 AND EmployeeNumber = 101
  COMMIT TRANSACTION
  PRINT('Transaction Commited.')
 END TRY
 BEGIN CATCH
  ROLLBACK TRANSACTION
  PRINT('Transaction Rolledback.')
 END CATCH
END
GO

--Execute procedure to see behaviour
spUpdateAddress
SELECT * FROM tblMailingAddress
SELECT * FROM tblPhysicalAddress
GO

--Now make an error on second table inside stored procedure
--Transaction will be rolled back
ALTER PROCEDURE spUpdateAddress
AS
BEGIN
 BEGIN TRY
  BEGIN TRANSACTION
   UPDATE tblMailingAddress SET City = 'LONDON' 
   WHERE AddressId = 1 AND EmployeeNumber = 101
   
   UPDATE tblPhysicalAddress SET City = 'LONDON LONDON'  --Max length exceeded error here
   WHERE AddressId = 1 AND EmployeeNumber = 101
  COMMIT TRANSACTION
  PRINT('Transaction Commited.')
 END TRY
 BEGIN CATCH
  ROLLBACK TRANSACTION
  PRINT('Transaction Rolledback.')
 END CATCH
END
GO

--Execute procedure to see behaviour
spUpdateAddress
SELECT * FROM tblMailingAddress
SELECT * FROM tblPhysicalAddress
GO

-- Transaction Acid Tests
---- A successful transaction must pass the "ACID" test, that is, it must be
------ A - Atomic
------ C - Consistent
------ I - Isolated
------ D - Durable

--Atomic: All statements in the transaction either completed successfully or they were all rolled back.
--Consistent: All data touched by the transaction is left in a logically consistent state. 
----For example, if stock available numbers are decremented from tblProductTable, then, there has to be a related entry in tblProductSales table. The inventory can't just disappear.
--Isolated: The transaction must affect data without interfering with other concurrent transactions, or being interfered with by them. 
----This prevents transactions from making changes to data based on uncommitted information, for example changes to a record that are subsequently rolled back. 
----Most databases use locking to maintain transaction isolation.
--Durable: Once a change is made, it is permanent. 
----If a system error or power failure occurs before a set of commands is complete, 
----those commands are undone and the data is restored to its original state once the system begins running again.