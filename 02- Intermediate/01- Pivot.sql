--Pivot in SQL
--Pivot is an sql server operator that can be used to turn unique values from one column, into multiple columns in the output, there by effectively rotating a table.
SELECT SalesAgent, ISNULL(Pakistan,0) AS Pakistan, ISNULL(India,0) AS India, ISNULL(UK,0) AS UK
FROM
(
	SELECT SalesAgent, SalesCountry, SalesAmount FROM AgentSales
)
AS SourceTable
PIVOT
(
	SUM(SalesAmount)
	FOR SalesCountry
	IN (Pakistan, India, UK)
)
AS PivotTable

--Below is sample table and sample data to insert
--Sample Table
CREATE TABLE [dbo].[AgentSales]
	(
		[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
		[SalesAgent] [nvarchar](150) NOT NULL,
		[SalesCountry] [nvarchar](150) NOT NULL,
		[SalesAmount] [decimal](18, 2) NULL
	)

--Dummy data
INSERT INTO AgentSales VALUES ('Imran Ali', 'Pakistan', 2345)
INSERT INTO AgentSales VALUES ('Usman Khawaja', 'Pakistan', 1245)
INSERT INTO AgentSales VALUES ('Sultan Karim', 'Pakistan', 3445)
INSERT INTO AgentSales VALUES ('Imran Ali', 'Pakistan', 6754)
INSERT INTO AgentSales VALUES ('Virider Kumar', 'India', 7854)
INSERT INTO AgentSales VALUES ('Narindra Modi', 'India', 7765)
INSERT INTO AgentSales VALUES ('Bihari Singh', 'India', 3256)
INSERT INTO AgentSales VALUES ('Tom Jane', 'UK', 9988)
INSERT INTO AgentSales VALUES ('John Doe', 'UK', 8876)
INSERT INTO AgentSales VALUES ('Tim Bransnon', 'UK', 9087)
INSERT INTO AgentSales VALUES ('Farooq Haider', 'Pakistan', 2267)
INSERT INTO AgentSales VALUES ('Imran Ali', 'India', 6543)
INSERT INTO AgentSales VALUES ('Imran Ali', 'UK', 8790)