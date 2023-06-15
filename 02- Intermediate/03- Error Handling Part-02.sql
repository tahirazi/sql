--Error handling in sql server 2005, and later versions
-- Using Try Catch blocks
--Any set of SQL statements, that can possibly throw an exception are wrapped between BEGIN TRY and END TRY blocks. 
--If there is an exception in the TRY block, the control immediately, jumps to the CATCH block. 
--If there is no exception, CATCH block will be skipped, and the statements, after the CATCH block are executed.

--NOTE: TRY/CATCH cannot be used in a user-defined functions.

--Example stored procedure that uses TRY/CATCH
CREATE PROCEDURE spSellProductWithTryCatch
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
    BEGIN TRY
     BEGIN TRANSACTION
         -- First reduce the quantity available
  UPDATE tblProduct SET QtyAvailable = (QtyAvailable - @QuantityToSell)
  WHERE ProductId = @ProductId
  
  DECLARE @MaxProductSalesId INT
  -- Calculate MAX ProductSalesId  
  SELECT @MaxProductSalesId = CASE WHEN 
          MAX(ProductSalesId) IS NULL 
          THEN 0 ELSE MAX(ProductSalesId) END 
         FROM tblProductSales
  --Increment @MaxProductSalesId by 1, so we don't get a primary key violation
  ----------------------------Error Below!-------------------------------------------
  --SET @MaxProductSalesId = @MaxProductSalesId + 1
  INSERT INTO tblProductSales VALUES (@MaxProductSalesId, @ProductId, @QuantityToSell)
     COMMIT TRANSACTION
    END TRY
    BEGIN CATCH 
  ROLLBACK TRANSACTION
  SELECT 
   ERROR_NUMBER() AS ErrorNumber,
   ERROR_MESSAGE() AS ErrorMessage,
   ERROR_PROCEDURE() AS ErrorProcedure,
   ERROR_STATE() AS ErrorState,
   ERROR_SEVERITY() AS ErrorSeverity,
   ERROR_LINE() AS ErrorLine
    END CATCH 
   END
END
GO

--Testing procedure
EXEC spSellProductWithTryCatch 1, 8	--SP has an error. It should handle it properly.
SELECT * FROM tblProduct
SELECT * FROM tblProductSales