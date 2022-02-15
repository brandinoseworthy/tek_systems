/*
*Q1. Write a query to display each customer’s name (as “Customer Name”) alongside the name of the employee 
*who is responsible for that customer’s orders. 
*The employee name should be in a single “Sales Rep” column formatted as “lastName, firstName”. 
*The output should be sorted alphabetically by customer name.
*
*/

use classicmodels;

select * from customers;

select * from employees;

-- get concat string function from Mariabd documentation
-- CONCAT(fieldname1, ' ', fieldname2, etc.) as 'alias'
-- Note: you need to put the space with ' ', or else it will show as one word

select c.customerName as 'Customer Name', CONCAT(e.lastname,' ', e.firstname ) as 'Sales Rep'
from customers as c
join employees as e on c.salesRepEmployeeNumber = e.employeeNumber
order by customerName;


/*
 * Q2. Determine which products are most popular with our customers. For each product, 
 * list the total quantity ordered along with the total sale generated (total quantity ordered * priceEach) 
 * for that product. The column headers should be “Product Name”, “Total # Ordered” and “Total Sale”. 
 * List the products by Total Sale descending.
 * 
 */


-- PRODCUTtable for quanty ordered and total sale CUSTOEMRtbale


select p.productName as 'Product Name', SUM(o.quantityOrdered) as 'Total # Ordered', 
		SUM(o.quantityOrdered * o.priceEach) as 'Total Sale'
from products as p  
JOIN orderdetails as o on p.productCode = o.productCode 
group by p.productName 
order by 'Total Sale' desc;


/*
 * Q3. Write a query which lists order status and the # of orders with that status. 
 * Column headers should be “Order Status” and “# Orders”. Sort alphabetically by status.
 * 
 */

select * from orders;

Select o.status as 'Order Status', Count(*) as '# Orders'
from orders as o
group by status; -- automatically sorts in ascending order

/*
 * Q4. Write a query to list, for each product line, the total # of products sold from that product line. 
 * The first column should be “Product Line” and the second should be “# Sold”. 
 * Order by the second column descending.
 * 
 */


select * from productlines;

Select pl.productLine  as 'Product Line', SUM(od.quantityOrdered) as '# Sold'
from productlines as pl 
join products as p on p.productLine = pl.productLine 
join orderdetails as od on p.productCode = od.productCode 
group by pl.productLine 
order by 2 desc; -- in order by you can use a # to determine which columb you want to sort BY 


/*
 * Q5. For each employee who represents customers, output the total # of orders that employee’s customers have placed 
 * alongside the total sale amount of those orders. The employee name should be output as a single column named 
 * “Sales Rep” formatted as “lastName, firstName”. The second column should be titled “# Orders” and the third 
 * should be “Total Sales”. Sort the output by Total Sales descending. Only (and all) employees with the 
 * job title ‘Sales Rep’ should be included in the output, and if the employee made no sales the Total Sales 
 * should display as “0.00”.
 * 
 */

select CONCAT(e.lastName, ', ', e.firstName) as "Sales Rep", SUM(od.quantityOrdered) as '# Orders', 
        if (SUM(od.quantityOrdered) IS NULL, 0.00, SUM(od.quantityOrdered * od.priceEach)) as 'Total Sales'
 from employees as e
 left join customers as c on e.employeeNumber = c.salesRepEmployeeNumber
 left join orders as o on c.customerNumber = o.customerNumber
left join orderdetails as od on o.orderNumber = od.orderNumber
 where e.jobTitle = "Sales Rep"
 group by  e.employeeNumber
 order by SUM(od.quantityOrdered * od.priceEach) desc;

/*
 * Q6.  Your product team is requesting data to help them create a bar-chart of monthly sales since the 
 * company’s inception. Write a query to output the month (January, February, etc.), 
 * 4-digit year, and total sales for that month. The first column should be labeled ‘Month’, the second ‘Year’, 
 * and the third should be ‘Payments Received’. Values in the third column should be formatted as numbers with 
 * two decimals – for example: 694,292.68.
 * 
 */

select * from payments;


-- use monthname and year from maria db documentation
-- i.e SELECT MONTHNAME('2019-02-03');

select MonthName(paymentDate) as 'Month', Year(paymentDate) as 'Year',
		format (sum(amount), 2) AS 'Payments Received'
from payments as p 
group by 2, 1
order by paymentDate;

-- complete