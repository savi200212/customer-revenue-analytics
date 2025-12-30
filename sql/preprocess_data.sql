

select * from online_retail

--Remove invalid records
DELETE FROM online_retail
WHERE Quantity <= 0
   OR UnitPrice <= 0;

--Handle missing customers
update online_retail
set CustomerID = -1
where CustomerID is null;

--Remove duplicates
delete r1
from online_retail r1
join online_retail r2
ON r1.InvoiceNo = r2.InvoiceNo
AND r1.StockCode = r2.StockCode
AND r1.InvoiceDate = r2.InvoiceDate
AND r1.CustomerID = r2.CustomerID
AND r1.UnitPrice = r2.UnitPrice
AND r1.Quantity = r2.Quantity
AND r1.InvoiceDate > r2.InvoiceDate;



