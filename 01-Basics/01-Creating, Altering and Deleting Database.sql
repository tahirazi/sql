--Creating a database
CREATE DATABASE MasteringSql
--Selection of created Database Name
SELECT name FROM sys.databases WHERE name IN ('MasteringSql')

--Alter Database
ALTER DATABASE MasteringSql Modify name = MasteringS
EXEC sp_renamedb 'MasteringSql','MasteringS'
--To put DB in single user mode
--If other users connected it'll not give error before drop
ALTER DATABASE MasteringSql SET SINGLE_USER ROLLBACK IMMEDIATE --Rollback other connected user(s) transaction(s) immediately and close connection

--Drop Database
DROP DATABASE MasteringSql

--If other user using database it cannot be dropped
--Currently in use database cannot be dropped (In same user query)
--SYSTEM Database cannot be dropped