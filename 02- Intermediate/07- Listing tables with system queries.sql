-- Listing tables with system queries
--01- SYSOBJECTS
----Get all type of objects in database
Select * from SYSOBJECTS
---- Gets the list of tables only
Select * from SYSOBJECTS where XTYPE='U'
----XTYPE column from SYSOBJECTS different types of filters
------IT - Internal table
------P - Stored procedure
------PK - PRIMARY KEY constraint
------S - System table 
------SQ - Service queue
------U - User table
------V - View
----To get the list of different object types (XTYPE) in a database
Select Distinct XTYPE from SYSOBJECTS

--02- SYS.[]
---- Gets the list of tables/views/functions/SP(s)
Select * from  SYS.TABLES
Select * from  SYS.VIEWS
Select * from  SYS.databases

--03- INFORMATION_SCHEMA
---- Gets the list of tables and views
Select * from INFORMATION_SCHEMA.TABLES
Select * from INFORMATION_SCHEMA.VIEWS
Select * from INFORMATION_SCHEMA.COLUMNS
Select * from INFORMATION_SCHEMA.SEQUENCES



