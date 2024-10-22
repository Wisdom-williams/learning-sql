-----------ASSIGNMENT 1----------------------
--1
SELECT distinct city, stateProvince from SalesLT.Address;

--2
select top 10 percent weight from 
SalesLT.Product order by weight desc;

--3
select weight,name from SalesLT.Product order 
by weight desc OFFSET 10 rows FETCH next 100 rows only;

-------------------ASSIGNMENT 2---------------------
--1
select name, color, size from SalesLT.Product WHERE
ProductModelID=1;

--2
select top 10 percent weight, name from SalesLT.Product
order by weight desc;

--3
SELECT productNumber, name, ListPrice from SalesLT.Product 
where color IN('white','black','white') and SIZE IN('s','m');

--4
SELECT ProductNumber, name, ListPrice from SalesLT.Product 
where ProductNumber like 'BK-[^R]%-[0-9][0-9]'; 
