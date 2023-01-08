-- Inner Join Sql query: Only returns customers that have an Order
SELECT 
c.customerid
,c.country
,o.orderid
,o.orderdate
FROM Customers c
inner join orders o on c.customerid = o.customerid 

-- Left Join Sql query: Returning all the customers and match values from the order table 

SELECT 
c.customerid
,c.country
,o.orderid
,o.orderdate
FROM Customers c
Left join orders o on c.customerid = o.customerid 

-- Right Join Sql query: Returning all the Orders and match values from the customer table 

SELECT 
c.customerid
,c.country
,o.orderid
,o.orderdate
FROM Customers c
Right join orders o on c.customerid = o.customerid 

-- Full Join Sql query: Returning all the customer and match/unmatch values from the order table 
SELECT 
c.customerid
,c.country
,o.orderid
,o.orderdate
FROM Customers c
Full join orders o on c.customerid = o.customerid 


 -- Ranking 
 SELECT 
c.customerid
,o.orderid
,o.orderdate
,rank() over(partition by c.customerid order by o.orderdate asc) rank
,dense_rank() over(partition by c.customerid order by o.orderdate asc) dense_rank
,row_number() over(partition by c.customerid order by o.orderdate asc) row_number
FROM Customers c
inner join orders o on c.customerid = o.customerid 
where c.customerid = 5
ORDER BY CustomerName ASC;


--coalesce 

SELECT 
c.customerid
,o.orderid
,COALESCE(o.orderid,0) new_orderid -- Replace null values with zero
,NVL(o.orderid, xx) new_orderid -- Oracle
FROM Customers c
full join orders o on c.customerid = o.customerid 

-- Scalar and Agg Function

SELECT 
c.customerid
,INITCAP(c.CustomerName) Making_First_Letter_Captial
,Upper(c.CustomerName) All_Letters_Captial
,lower(c.customerName) ALL_Letter_lower
,count(distinct o.orderid) Number_of_orders
,max(o.orderdate) Latest_order_date
,min(o.orderdate) First_order_date
,Sum(od.Quantity) Number_of_Quantity
FROM Customers c
inner join orders o on c.customerid = o.customerid 
left join orderdetails od on o.orderid = od.orderid

group by c.customerid


--How many orders are shipped by each Name?
-- CTE 
with Morethanone_order as (SELECT 
c.customerid
,o.orderid
,o.ShipperID
FROM Customers c
inner join orders o on c.customerid = o.customerid 
group by 1
having count(distinct o.orderid)>1
)

Select 
ShipperName
,count(*)
from Morethanone_order a 
left join shippers s on a.ShipperID = s.ShipperID
group by shipperName


-- Subquery 

select 
ShipperName
,count(*)
from (
SELECT 
c.customerid
,o.orderid
,o.ShipperID
FROM Customers c
inner join orders o on c.customerid = o.customerid 
group by 1
having count(distinct o.orderid)>1
)a 
left join shippers s on a.ShipperID = s.ShipperID
group by shipperName

-- Filters 
-- Where IN or Between equal LIKE

where c.customerID = 5
where c.customerName like '%Around%'
where orderdate between '1996-08-01' and '1996-08-31'
where c.customerID IN(4,5)

-- Having using group 
having count(distinct o.orderid)>1

-- Case statement
case when orderdate between '1996-08-01' and '1996-08-31' then 'Order in August' else 'No Order' end 

-- COALESCE
,COALESCE(o.orderid,0) new_orderid -- Replace null values with zero
,NVL(o.orderid, xx) new_orderid -- Oracle


Create table app.customer_data (
dt varchar2(1000)
,customerName varchar2(1000)
)

-- insert data into the new table
insert into app.customer_data values ('20221001','Customer A')