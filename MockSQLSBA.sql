
Select * from ITEMS i ;
Select * from ORDERS o;
select * from ORDER_ITEMS oi;
select * from STORES;
select * from USERS;

-- 1. Create a query to return all orders made by users with the first name of “Marion”

select o.ORDER_ID as 'Order', u.FIRST_NAME as 'First Name', u.USER_ID, STORE_ID 
from ORDERS o 
join USERS u on o.USER_ID = u.USER_ID 
where u.FIRST_NAME = 'Marion';

/* 
 * Result
 * 
Order|First Name|USER_ID|STORE_ID|
-----+----------+-------+--------+
    2|Marion    |      3|       1|
    3|Marion    |      3|       3|
 */

-- 2. Create a query to select all users that have not made an order

select * from USERS;
select * from ORDERS;

Select u.USER_ID, CONCAT(u.FIRST_NAME, ' ', u.LAST_NAME, '.') as  ' Name ', u.CITY as 'City'
from USERS as u 
left join ORDERS o on u.USER_ID = o.USER_ID
where o.USER_ID IS Null; 

/*
 * Result
 * 
USER_ID|Name   |City    |
-------+-------+--------+
      6|Mike G.|New York|
 * 
 */


-- 3. Create a Query to select the names and prices of all items that have been part of 2 or more separate orders. 

select * from ORDER_ITEMS;
select * from ITEMS;
select * from ORDERS;


-- 

Select i.NAME as 'Name', i.PRICE  as 'Price' 
from ITEMS as i 
inner join ORDER_ITEMS oi on i.ITEM_ID = oi.ITEM_ID 
group by oi.ITEM_ID 
having count(distinct oi.ORDER_ID) >= 2;


/*
 Name        |Price|                    
------------+-----+
Hotdog      | 1.35|
Cheeseburger| 2.50|
Fries       | 1.00|
Soda        | 1.00|

 */


/* 4. Create a query to return the Order Id, Item name, Item Price, and Quantity from orders 
made at stores in the city “New York”. Order by Order Id in ascending order. 
*/

select* from STORES;

-- 

Select oi.ORDER_ID, i.NAME, i.PRICE, oi.QUANTITY    
From ORDER_ITEMS as oi 
	join ITEMS as i on oi.ITEM_ID = i.ITEM_ID 
	join ORDERS as o on  oi.ORDER_ID = o.ORDER_ID 
	right join STORES as s on  o.STORE_ID = s.STORE_ID 
Where o.STORE_ID IN (
	select store_id from STORES where city = "New York")
order by o.ORDER_ID asc;

--ORDER_ID|NAME        |PRICE|QUANTITY|
--------+------------+-----+--------+
       1|Fries       | 1.00|       1|
       1|Hotdog      | 1.35|       2|
       1|Soda        | 1.00|       1|
       2|Cheeseburger| 2.50|       1|
       2|Soda        | 1.00|       1|
       3|Fries       | 1.00|       8|
       5|Soda        | 1.00|       1|
       7|Hotdog      | 1.35|       2|
       
 /*
  * 5. Your boss would like you to create a query that calculates the total revenue generated 
by each item. Revenue for an item can be found as (Item Price * Total Quantity 
Ordered). Please return the first column as ‘ITEM_NAME’ and the second column as 
‘REVENUE’. 
  * 
  */
      
Select * from ITEMS;
Select * from ORDER_ITEMS;

--
 Select i.NAME as `Item_Name`, Sum(i.PRICE *tot_quantity) as `Revenue`
 FROM ITEMS as i
 join ( select ITEM_ID, sum(Quantity) AS tot_quantity from ORDER_ITEMS 
 group by ITEM_ID ) as oi on i.ITEM_ID  = oi.ITEM_ID  
 group by i.NAME;

/*
 * Item_Name   |Revenue|
------------+-------+
Cheeseburger|   5.00|
Fries       |  10.00|
Hotdog      |  10.80|
Soda        |   3.00|
 * 
 */


/*
 * 6. Create a query with the following output: 
a. Column 1 - Store Name 
 
	i. The name of each store 
b. Column 2 - Order Quantity 
	i. The number of times an order has been made in this store 
c. Column 3 - Sales Figure 
	i. If the store has been involved in more than 3 orders, mark as ‘High’ 
	ii. If the store has been involved in less than 3 orders but more than 1 order, 
	mark as ‘Medium’ 
	iii. If the store has been involved with 1 or less orders, mark as ‘Low’ 
d. Should be ordered by the Order Quantity in Descending Order 

*/


Select s.NAME  as 'Name', count(*) as 'Order Quantity',
(CASE 
	when count(*) > 3 then 'High'
	when count(*) > 1 then 'Medium'
	when count (*) <= 1 then 'Low'
end) as 'Sales Figures'
from STORES as s
join ORDERS as o on s.STORE_ID = o.STORE_ID 
group by s.NAME
order by 2 desc;


-- done, scroll below to get database and data



/*
 * 
 
DROP DATABASE IF EXISTS MockSQLSBA;
CREATE DATABASE MockSQLSBA;
USE MockSQLSBA;

-- remove 2 in VarChar
CREATE TABLE USERS (
USER_ID INTEGER PRIMARY KEY,
FIRST_NAME VARCHAR(30),
LAST_NAME VARCHAR(30),
CITY VARCHAR(60)
);
 -- decimal is a synonym for number

CREATE TABLE STORES (
STORE_ID INTEGER PRIMARY KEY,
NAME VARCHAR(100),
CITY VARCHAR(60),
SALES_TAX_RATE Decimal (6,5)
);
-- same as above
CREATE TABLE ITEMS (
ITEM_ID INTEGER PRIMARY KEY,
NAME VARCHAR(30),
PRICE Decimal(5,2)
);
CREATE TABLE ORDERS (
ORDER_ID INTEGER PRIMARY KEY,
USER_ID INTEGER,
STORE_ID INTEGER,
CONSTRAINT FK_UserID FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
CONSTRAINT FK_StoreID FOREIGN KEY (STORE_ID) REFERENCES STORES(STORE_ID)
);
CREATE TABLE ORDER_ITEMS (
ORDER_ID INTEGER,
ITEM_ID INTEGER,
QUANTITY INTEGER,
CONSTRAINT PK_Order_Items PRIMARY KEY (ORDER_ID, ITEM_ID),
CONSTRAINT FK_OrderID FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
CONSTRAINT FK_ItemID FOREIGN KEY (ITEM_ID) REFERENCES ITEMS(ITEM_ID)
);
INSERT INTO USERS VALUES (1, 'Lucien', 'Arnolfi', 'New York');
INSERT INTO USERS VALUES (2, 'Susila', 'Foster', 'Stamford');
INSERT INTO USERS VALUES (3, 'Marion', 'Cole', 'New York');
INSERT INTO USERS VALUES (4, 'Edna', 'Kay', 'New York');
INSERT INTO USERS VALUES (5, 'Meridith', 'Stefanov', 'Stamford');
INSERT INTO USERS VALUES (6, 'Mike', 'G', 'New York');
INSERT INTO STORES VALUES (1, 'Bronx Location', 'New York', 0.08875);
INSERT INTO STORES VALUES (2, 'Financial District', 'New York', 0.08875);
INSERT INTO STORES VALUES (3, 'Harlem Location', 'New York', 0.08875);
INSERT INTO STORES VALUES (4, 'North Stamford Location', 'Stamford', 0.0635);
INSERT INTO STORES VALUES (5, 'South Stamford Location', 'Stamford', 0.0635);
INSERT INTO ITEMS VALUES (1,'Hotdog',1.35);
INSERT INTO ITEMS VALUES (2,'Hamburger', 2.00);
INSERT INTO ITEMS VALUES (3,'Cheeseburger',2.50);
INSERT INTO ITEMS VALUES (4,'Fries',1.00);
INSERT INTO ITEMS VALUES (5,'Soda',1.00);
INSERT INTO ORDERS VALUES(1,1,1);
INSERT INTO ORDERS VALUES(2,3,1);
INSERT INTO ORDERS VALUES(3,3,3);
INSERT INTO ORDERS VALUES(4,2,5);
INSERT INTO ORDERS VALUES(5,4,1);
INSERT INTO ORDERS VALUES(6,5,5);
INSERT INTO ORDERS VALUES(7,1,2);
INSERT INTO ORDERS VALUES(8,5,4);
INSERT INTO ORDER_ITEMS VALUES(1,1,2);
INSERT INTO ORDER_ITEMS VALUES(1,4,1);
INSERT INTO ORDER_ITEMS VALUES(1,5,1);
INSERT INTO ORDER_ITEMS VALUES(2,3,1);
INSERT INTO ORDER_ITEMS VALUES(2,5,1);
INSERT INTO ORDER_ITEMS VALUES(3,4,8);
INSERT INTO ORDER_ITEMS VALUES(4,3,1);
INSERT INTO ORDER_ITEMS VALUES(4,4,1);
INSERT INTO ORDER_ITEMS VALUES(5,5,1);
INSERT INTO ORDER_ITEMS VALUES(6,1,2);
INSERT INTO ORDER_ITEMS VALUES(7,1,2);
INSERT INTO ORDER_ITEMS VALUES(8,1,2);
*/
