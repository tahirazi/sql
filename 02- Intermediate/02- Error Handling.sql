--Error Handling in SQL

--Error handling before SQL server 2005
--By using '@@Error' global variable
 
---------------------------------- Pre Requisits -----------------------------------------
 --To create tblProduct
CREATE TABLE tblProduct
(
 ProductId INT NOT NULL PRIMARY KEY,
 Name NVARCHAR(50),
 UnitPrice INT,
 QtyAvailable INT
)

--Load data into tblProduct
INSERT INTO tblProduct VALUES (1, 'Laptops', 2340, 100)
INSERT INTO tblProduct VALUES (2, 'Desktops', 3467, 50)

--To create tblProductSales
CREATE TABLE tblProductSales
(
 ProductSalesId INT PRIMARY KEY,
 ProductId INT,
 QuantitySold INT
)
GO

--Stored procedure
--Problem in below SP is, transaction is always committed. Even, if there is an error somewhere, between updating tblProduct and tblProductSales table. 
CREATE PROCEDURE spSellProduct
@ProductId INT,
@QuantityToSell INT
AS
BEGIN
 -- Check the stock available, for the product we want to sell
 DECLARE @StockAvailable INT
 SELECT @StockAvailable = QtyAvailable 
 FROM tblProduct WHERE ProductId = @ProductId
 
 -- Throw an error to the calling application, if enough stock is not available
 IF(@StockAvailable < @QuantityToSell)
   BEGIN
  RAISERROR('Not enough stock available',16,1)
   End
 -- If enough stock available
 ELSE
   BEGIN
    BEGIN TRAN
         -- First reduce the quantity available
  UPDATE tblProduct SET QtyAvailable = (QtyAvailable - @QuantityToSell)
  WHERE ProductId = @ProductId
  
  Declare @MaxProductSalesId int
  -- Calculate MAX ProductSalesId  
  SELECT @MaxProductSalesId = CASE WHEN 
          MAX(ProductSalesId) IS NULL 
          THEN 0 ELSE MAX(ProductSalesId) END 
         FROM tblProductSales
  -- Increment @MaxProductSalesId by 1, so we don't get a primary key violation
  SET @MaxProductSalesId = @MaxProductSalesId + 1
  INSERT INTO tblProductSales VALUES(@MaxProductSalesId, @ProductId, @QuantityToSell)
    COMMIT TRAN
   END
END
GO

--Solution of problem is to handle error properly
CREATE PROCEDURE spSellProductCorrected
@ProductId INT,
@QuantityToSell INT
AS
BEGIN
 -- Check the stock available, for the product we want to sell
 DECLARE @StockAvailable INT
 SELECT @StockAvailable = QtyAvailable 
 FROM tblProduct WHERE ProductId = @ProductId
 
 -- Throw an error to the calling application, if enough stock is not available
 IF(@StockAvailable < @QuantityToSell)
   BEGIN
  RAISERROR('Not enough stock available',16,1)
   END
 -- If enough stock available
 ELSE
   BEGIN
    BEGIN TRAN
         -- First reduce the quantity available
  UPDATE tblProduct SET QtyAvailable = (QtyAvailable - @QuantityToSell)
  WHERE ProductId = @ProductId
  
  DECLARE @MaxProductSalesId INT
  -- Calculate MAX ProductSalesId  
  SELECT @MaxProductSalesId = CASE WHEN 
          MAX(ProductSalesId) IS NULL 
          THEN 0 ELSE MAX(ProductSalesId) END 
         FROM tblProductSales
  -- Increment @MaxProductSalesId by 1, so we don't get a primary key violation
  SET @MaxProductSalesId = @MaxProductSalesId + 1
  INSERT INTO tblProductSales VALUES(@MaxProductSalesId, @ProductId, @QuantityToSell)
  IF(@@ERROR <> 0)
  BEGIN
   ROLLBACK TRAN
   PRINT 'Transaction Rolled Back'
  END
  ELSE
  BEGIN
   COMMIT TRAN 
   PRINT 'Transaction Committed'
  END
   END
END

--Now check behaviours of both procedures
SELECT * FROM tblProduct
SELECT * FROM tblProductSales

EXEC spSellProduct 1, 10			--Make an error in SP and then execute. Transaction will not be rolled back.
SELECT * FROM tblProduct
SELECT * FROM tblProductSales


EXEC spSellProductCorrected 1, 8	--Make an error in SP and then execute. It will rollback transaction properly.
SELECT * FROM tblProduct
SELECT * FROM tblProductSales

------------------------------------------ Problems with @@Error variable -------------------------------------------------

-- @@ERROR is cleared and reset on each statement execution. 
-- Need to check it immediately following the statement being verified, or need to save it to a local variable that can be checked later.

--Examples
-- Data insertion with primary key voilation
INSERT INTO tblProduct VALUES (2, 'Mobile Phone', 1500, 100)
IF(@@ERROR <> 0)
 PRINT 'Error Occurred'
ELSE
 PRINT 'No Errors'

 --Again data insertion with primary key voilation
INSERT INTO tblProduct VALUES (2, 'Mobile Phone', 1500, 100)
--At this point @@ERROR will have a NON ZERO value 
SELECT * FROM tblProduct
--At this point @@ERROR gets reset to ZERO, because the 
--select statement successfully executed
IF(@@ERROR <> 0)
 PRINT 'Error Occurred'
ELSE
 PRINT 'No Errors'

 --Use a local variable to store @@ERROR value
DECLARE @Error INT
INSERT INTO tblProduct VALUES (2, 'Mobile Phone', 1500, 100)
SET @Error = @@ERROR
SELECT * FROM tblProduct
IF(@Error <> 0)
 PRINT 'Error Occurred'
ELSE
 PRINT 'No Errors'