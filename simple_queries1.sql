use classicmodels;

/*
 * Write a query to display the name, product line, and buy price of all products. 
 * The output columns should display as “Name”, “Product Line”, and “Buy Price”. 
 * The output should display the most expensive items first
 */

select productname as 'Name', productline as 'Product Line', buyprice as 'Buy Price'
from products 
order by buyprice desc;

-- Question 2

select contactfirstname as 'First Name', contactlastname as 'Last Name', city as 'City'
from customers 
Where Country = 'Germany'
order by contactLastName asc; 

-- Question 3 

select * from orders;

select distinct status
from orders;

-- Question 4

select * from payments;

select * 
from payments
where paymentDate >= '2005-01-01';

-- Question 5

select * from employees;

select officecode 
from offices 
where city = 'San Francisco';


select firstname as 'First Name', lastname as 'Last Name', Email as 'Email', jobTitle as 'Job Title'
from employees  
Where officecode = '1'
order by lastname; 

-- Question 6

select * from products;

select productname as 'Name', productline as 'Product Line', productscale as 'Scale', productVendor as 'Vendor'
from products
where productline LIKE 'Motorcycles' OR productLine = 'Classic Cars'
order by productname asc, productline asc;

