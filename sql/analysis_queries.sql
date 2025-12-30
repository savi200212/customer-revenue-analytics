----Overall Business KPIs

--Total Revenue
select sum(Revenue) as TotalRevenue
from FactSales

---Total Orders
select count(*) as TotalTransactions
from FactSales

---Total Customers
select count(distinct CustomerID) as TotalCustomers
from FactSales
where CustomerID <> -1;

----Monthly Revenue Trend----
select
  d.Year,
  d.Month,
  d.MonthName,
  SUM(f.Revenue) as MonthlyRevenue
from FactSales f
JOIN DimDate d on f.DateID = d.DateID
group by d.Year, d.Month, d.MonthName
order by d.Year, d.Month;

---Top 10 customers by Revenue
select top 10
    f.CustomerID,
	sum(f.Revenue) as TotalRevenue
from FactSales f
where f.CustomerID <> -1
group by f.CustomerID
order by TotalRevenue DESC;

--Top 10 Products
select top 10
   p.StockCode,
   p.Description,
   sum(f.Revenue) as ProductRevenue
from FactSales f
join DimProduct p on f.ProductID = p.ProductID
group by p.StockCode, p.Description
order by ProductRevenue desc;

---Country wise Revenue
select
   c.Country,
   sum(f.Revenue) as Revenue
from FactSales f
join DimCustomer c on f.CustomerID = c.CustomerID
group by c.Country
order by Revenue desc;

---Returning Customers
select CustomerID, count(*) as Purchases
from FactSales
where CustomerID <> -1
group by CustomerID
having count(*) > 1;

---Revenue Contribution
select 
     p.StockCode,
	 sum(f.Revenue) as Revenue,
	 round(
	    100.0 * sum(f.Revenue) / sum(sum(f.Revenue)) over (),
		2
	 ) as RevenuePercentage
from FactSales f
join DimProduct p on f.ProductID = p.ProductID
group by p.StockCode
order by Revenue desc;