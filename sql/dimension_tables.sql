------Create Dimension Tables-----------
---DimCustomer Table----
create table DimCustomer(
    CustomerID INT PRIMARY KEY,
	Country nvarchar(50)
);

insert into DimCustomer
select distinct CustomerID, Country
from online_retail;

truncate table DimCustomer

INSERT INTO DimCustomer (CustomerID, Country)
SELECT
    CAST(CustomerID AS INT) AS CustomerID,
    MIN(Country) AS Country
FROM online_retail
WHERE CustomerID <> -1
GROUP BY CAST(CustomerID AS INT);

INSERT INTO DimCustomer (CustomerID, Country)
VALUES (-1, 'Unknown');

SELECT CustomerID, COUNT(*) AS Cnt
FROM DimCustomer
GROUP BY CustomerID
HAVING COUNT(*) > 1;


SELECT COUNT(*) FROM DimCustomer;

---Create DimProduct Table---
create table DimProduct(
     ProductID INT IDENTITY(1,1) primary key,
	 StockCode nvarchar(50),
	 Description  nvarchar(255),
	 UnitPrice float

);

insert into DimProduct(StockCode, Description, UnitPrice)
select 
     StockCode,
	 MIN(Description) as Description,
	 AVG(UnitPrice) as UnitPrice
from online_retail
group by StockCode;

select count(*) from DimProduct;
select top 10 * from DimProduct;

--Create DimDate Table
create table DimDate(
    DateID int primary key,
	FullDate date,
	Day int,
	Month int,
	MonthName nvarchar(20),
	Quarter int,
	Year int
);

insert into DimDate
select distinct
       convert(int, format(InvoiceDate, 'yyyyMMdd')) as DateID,
	   CAST(InvoiceDate as Date) AS DateID,
	   DAY(InvoiceDate),
	   Month(InvoiceDate),
	   DATENAME(Month, InvoiceDate),
	   DATEPART(QUARTER, InvoiceDate),
	   YEAR(InvoiceDate)
from online_retail;

SELECT COUNT(*) FROM DimDate;
SELECT TOP 10 * FROM DimDate ORDER BY FullDate;

