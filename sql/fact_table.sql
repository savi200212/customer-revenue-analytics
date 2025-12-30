---Create FactSales Table
create table FactSales(
   SalesID int identity(1,1) primary key,
   CustomerID int,
   ProductID int,
   DateID int,
   Quantity int,
   Revenue float
);

insert into FactSales (CustomerID, ProductID, DateID, Quantity, Revenue)
select
    CAST(r.CustomerID as int),
	p.ProductID,
	convert(int, FORMAT(r.InvoiceDate, 'yyyyMMdd')) as DateID,
	r.Quantity,
	r.Quantity * r.UnitPrice as Revenue
from online_retail r
join DimProduct p
     ON r.StockCode = p.StockCode;


----Verify Fact Table
SELECT COUNT(*) FROM FactSales;
SELECT TOP 10 * FROM FactSales;