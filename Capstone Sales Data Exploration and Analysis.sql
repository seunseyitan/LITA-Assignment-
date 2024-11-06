SELECT * from dbo.SalesData$

DELETE FROM dbo.SalesData$
WHERE Product IS NULL


ALTER TABLE dbo.SalesData$
ADD TotalSales (int,null)


update [dbo].[SalesData$]
set TotalSales = Quantity * UnitPrice


--TOTAL SALES FOR EACH PRODUCT CATEGORY---

select product, sum(TotalSales) as TotalSales 
from [dbo].[SalesData$]  group by product

--NO OF SALES TRANSACTION IN EACH REGION---

select region, count(*) as numberofsalestransaction
from [dbo].[SalesData$] group by region 
order by 2 desc


---HIGHEST SELLING PRODUCT BY TOTAL SALES VALUE---
select top 1 product, sum(TotalSales) as HighestSellingProduct 
from [dbo].[SalesData$] 
group by Product 
order by 2 desc

---TOTAL REVENUE PER PRODUCT---
select product, sum(TotalSales) as TotalRevenue 
from [dbo].[SalesData$]
group by product

---MONTHLY SALES TOTAL FOR THE CURRENT YEAR---
select FORMAT(OrderDate, 'yyyy-mm') as sales_month, sum(TotalSales) as monthly_sales_total
from [dbo].[SalesData$] where YEAR(OrderDate) = 2024 group by FORMAT(OrderDate, 'yyyy-mm')
order by FORMAT(OrderDate, 'yyyy-mm')

---top 5 customers by total purchase amount---
select top [Customer Id] , sum(TotalSales) as TotalPurchase 
from [dbo].[SalesData$] group by CustomerId  
--order by 2 desc

---PERCENTAGE OF TOTAL SALES CONTRIBUTED BY EACH REGION---
select
      YEAR(OrderDate) AS SalesYear,
	  MONTH(OrderDate) AS SalesMonth,
	  SUM(TotalSales) AS TotalSales

From
     [dbo].[SalesData$]
Where
     Year(OrderDate) = YEAR(GETDATE())-----Filter from the current year
Group by
       YEAR(OrderDate),
	   MONTH(OrderDate)
Order by
        SalesYear,
		SalesMonth;

 ---PRODUCTS WITH NO SALES IN LAST QUARTER---

select product from [dbo].[SalesData$] group by product 
having 
sum(case when OrderDate >= '2024-01-01' and OrderDate < '2024-04-01'
then 1 else 0 end) = 0; -- Q1 of 2024