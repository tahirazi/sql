--Cursors in SQL
-- if there is ever a need to process the rows, on a row-by-row basis, then cursors are your choice. 
--Cursors are very bad for performance, and should be avoided always. 
--Most of the time, cursors can be very easily replaced using joins.

--Types of cursors
----1. Forward-Only
----2. Static
----3. Keyset
----4. Dynamic 

--Example of Forward only cursor
Declare @ProductId int

-- Declare the cursor using the declare keyword
Declare ProductIdCursor CURSOR FOR 
Select ProductId from tblProductSales

-- Open statement, executes the SELECT statment
-- and populates the result set
Open ProductIdCursor

-- Fetch the row from the result set into the variable
Fetch Next from ProductIdCursor into @ProductId

-- If the result set still has rows, @@FETCH_STATUS will be ZERO
While(@@FETCH_STATUS = 0)
Begin
 Declare @ProductName nvarchar(50)
 Select @ProductName = Name from tblProducts where Id = @ProductId
 
 if(@ProductName = 'Product - 55')
 Begin
  Update tblProductSales set UnitPrice = 55 where ProductId = @ProductId
 End
 else if(@ProductName = 'Product - 65')
 Begin
  Update tblProductSales set UnitPrice = 65 where ProductId = @ProductId
 End
 else if(@ProductName like 'Product - 100%')
 Begin
  Update tblProductSales set UnitPrice = 1000 where ProductId = @ProductId
 End
 
 Fetch Next from ProductIdCursor into @ProductId 
End

-- Release the row set
CLOSE ProductIdCursor 
-- Deallocate, the resources associated with the cursor
DEALLOCATE ProductIdCursor

--See results of update
Select  Name, UnitPrice 
from tblProducts join
tblProductSales on tblProducts.Id = tblProductSales.ProductId
where (Name='Product - 55' or Name='Product - 65' or Name like 'Product - 100%')

--Cursor replaced with JOIN
--Performance is best with JOINs
Update tblProductSales
set UnitPrice = 
 Case 
  When Name = 'Product - 55' Then 155
  When Name = 'Product - 65' Then 165
  When Name like 'Product - 100%' Then 10001
 End     
from tblProductSales
join tblProducts
on tblProducts.Id = tblProductSales.ProductId
Where Name = 'Product - 55' or Name = 'Product - 65' or 
Name like 'Product - 100%'
