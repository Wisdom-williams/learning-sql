------------Lab 3----------------------
/*Challenge 1: Retrieve Product Information
  1. Retrieve the name and approximate weight of each product 
  Write a query to return the product ID of each product, together with the product name formatted as 
upper case and a column named ApproxWeight with the weight of each product rounded to the nearest 
whole unit 
*/
select ProductID, UPPER(Name) as FullName, ROUND(Weight,0) as ApproxWeight 
from SalesLT.Product;

/*
2. Retrieve the year and month in which products were first sold
Extend your query to include columns named SellStartYear and SellStartMonth containing the year and 
month in which Adventure Works started selling each product. The month should be displayed as the 
month name (for example, ‘January’).
*/

select year(SellStartDate)  as startYear,DATENAME(month, month(SellStartDate)) as startmonth
from SalesLT.Product order by ProductID asc;

/*
3. Extract product types from product numbers
Extend your query to include a column named ProductType that contains the leftmost two characters 
from the product number
*/
select year(SellStartDate)  as startYear,
DATENAME(month, month(SellStartDate)) as startmonth, Left(ProductNumber,2) as ProductType
from SalesLT.Product
order by ProductID asc;

/*
4. Retrieve only products with a numeric size
Extend your query to filter the product returned so that only products 
with a numeric size are included
*/
select year(SellStartDate)  as startYear,
DATENAME(month, month(SellStartDate)) as startmonth, 
Left(ProductNumber,2) as ProductType, Size
from SalesLT.Product where ISNumeric(Size) = 1
order by ProductID asc;

/*
Challenge 2: Rank Customers by Revenue
The sales manager would like a list of 
customers ranked by sales

1. Retrieve companies ranked by sales totals
Write a query that returns a list of company names with a ranking of their place in a list of highest 
TotalDue values from the SalesOrderHeader table.

*/

SELECT CUS.CompanyName, SOH.TotalDue ,RANK() over(order by TotalDue desc) as rank
 from SalesLT.SalesOrderHeader as SOH 
inner JOIN SalesLT.Customer as CUS on SOH.CustomerID = CUS.CustomerID;

/*
Challenge 3: Aggregate Product Sales
The product manager would like aggregated information about product sales.
Tip: Review the documentation for the GROUP BY clause in the Transact-SQL Reference
*/

/*
1. Retrieve total sales by product
Write a query to retrieve a list of the product names and 
the total revenue calculated as the sum of the 
LineTotal from the SalesLT.SalesOrderDetail table, 
with the results sorted in descending order of total 
revenue.
*/
select p.Name, SUM(SOD.LineTotal) as totalRevenue 
from SalesLT.SalesOrderDetail as SOD 
inner join SalesLT.Product as p on SOD.ProductID = p.ProductID 
GROUP by p.Name,SOD.LineTotal, p.ListPrice 
order by totalRevenue desc;

/*2. Filter the product sales list to 
include only products that cost over $1,000*/
select p.Name, SUM(SOD.LineTotal) as totalRevenue 
from SalesLT.SalesOrderDetail as SOD 
inner join SalesLT.Product as p on SOD.ProductID = p.ProductID 
where p.ListPrice > 1000 
GROUP by p.Name,SOD.LineTotal, p.ListPrice 
order by totalRevenue desc;

/*
3. Filter the product sales groups to include only total sales over $20,000
Modify the previous query to only include only product
 groups with a total sales value greater than $20,000.
*/
select p.Name, SUM(SOD.LineTotal) as totalRevenue 
from SalesLT.SalesOrderDetail as SOD 
inner join SalesLT.Product as p on SOD.ProductID = p.ProductID 
where p.ListPrice  > 1000 
GROUP by p.Name,SOD.LineTotal, p.ListPrice
having  SUM(SOD.LineTotal) > 20000
order by totalRevenue desc;
