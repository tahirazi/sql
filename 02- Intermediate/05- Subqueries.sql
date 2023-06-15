--Subqueries in SQL
--Non-Correlated subquery
----A non-corelated subquery can be executed independently of the outer query.
--Correlated subquery
----If the subquery depends on the outer query for its values, then it is called correlated subquery.

--Create some test tables
CREATE TABLE tblProducts
(
 [Id] INT IDENTITY PRIMARY KEY,
 [Name] NVARCHAR(50),
 [Description] NVARCHAR(250)
)

CREATE TABLE tblProductSales1
(
 Id INT PRIMARY KEY IDENTITY,
 ProductId INT FOREIGN KEY REFERENCES tblProducts(Id),
 UnitPrice INT,
 QuantitySold INT
)

--Add some data
INSERT INTO tblProducts VALUES ('TV', '52 inch black color LCD TV')
INSERT INTO tblProducts VALUES ('Laptop', 'Very thin black color acer laptop')
INSERT INTO tblProducts VALUES ('Desktop', 'HP high performance desktop')

INSERT INTO tblProductSales1 VALUES (3, 450, 5)
INSERT INTO tblProductSales1 VALUES (2, 250, 7)
INSERT INTO tblProductSales1 VALUES (3, 450, 4)
INSERT INTO tblProductSales1 VALUES (3, 450, 9)

SELECT * FROM tblProducts
SELECT * FROM tblProductSales1

--Sub query to find product not solded yet
SELECT [Id], [Name], [Description]
FROM tblProducts
WHERE Id NOT IN (SELECT DISTINCT ProductId FROM tblProductSales1) ---- Example of non correlated subquery

--Same query replaced with JOIN

SELECT tblProducts.[Id], [Name], [Description]
FROM tblProducts
LEFT JOIN tblProductSales1
ON tblProducts.Id = tblProductSales1.ProductId
WHERE tblProductSales1.ProductId IS NULL

--Subquery in the where clause
SELECT [Name], 
(
	SELECT SUM(QuantitySold)  FROM tblProductSales1 
	WHERE ProductId = tblProducts.Id					----Example of correlated subquery
) AS TotalQuantity
FROM tblProducts
ORDER BY NAME

--Query with an equivalent join that produces the same result.
SELECT [Name], SUM(QuantitySold) AS TotalQuantity
FROM tblProducts
LEFT JOIN tblProductSales1
ON tblProducts.Id = tblProductSales1.ProductId
GROUP BY [Name]
ORDER BY NAME



