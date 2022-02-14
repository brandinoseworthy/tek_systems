
-- uses the databases -- is for one line comments 
-- use classmodels tells the DB what database I want to uses
-- what ever I do now, will affect the classicmodels database 

use classicmodels;
select * from classicmodels.customers;

-- describe tablename... gives a description of the databases
-- gives information on each filed of that table and datatype

describe customers;

-- select * from tablename.. this shows you all fields of table.
-- SELECT statements are called Queries
-- other functions such as updated tables/fields is called a STATEMENT

select * from customers;
select * from employees;

-- select *ALL from tablename WHERE fieldname = ___;

select * from employees
where employeenumber = 1370;

select * from employees 
where email = 'ghernande@classicmodelcars.com';

select * from employees 
where officeCode = 4;
 
select * from classicmodels.customers

-- select  count(*all) from tablename... this countFUNCTION counts all rows in this table
select count(*) from orders;
select count(*) from employees;
-- 
/*
 * this format allows for mutliple lines of comments 
 * show all employess in office number 4
 */

select * from employees where employeeNumber = 1370;
select count(*) from orders; 
select count(*) from employees;

-- use select to get specific information from specific columns... select column1, column 2 from TABLE;
select contactfirstname, contactlastname from customers;

-- use this and make an alias for field names `` to put the text and put a better column header
-- SELECT fieldname1 AS ' put a better name ' FROM tablename...
-- compare this query with the above query. The Field Name Columns will change.  

select contactfirstname as `First Name`, contactlastname as `Last Name` from customers;

-- order by decending or ascending AND STRUCTURE FOR READABILITY 
/*
 * SELECT field 
 * FROM table
 * ORDER BY field asc or desc
 */
select contactfirstname as `First Name`, contactlastname as `Last Name` 
from customers
order by contactfirstname desc;

-- 

select * from offices; 
-- 7 offices , now compare the differences of these two select count statements 
select count(*) 
from offices;

-- now only gives 5 
select count(addressline2) 
from offices;

-- shows everything
select * from orderdetails;

-- removes the duplicates, distincts only vies your the distinct values in that column called upon
-- we will get more into this later on 

select distinct orderNumber from orderdetails;

-- 

insert  into offices values ('8', 'Plano', '7773331234', '123 Street' , null , 'TX', 'USA' , '12345', 'NA');

delete from offices where officeCode = '8';

describe offices;
insert into offices (officeCode , city , phone , addressLine1 , country , postalCode , territory)
values ('8', 'Plano', '7773331234', '123 Street' ,  'USA' , '12345', 'NA');
select * from offices;
insert into offices ('officeCode' , 'city' , 'phone' , 'addressLine1' , 'country' , 'postalCode' , 'territory')
values ('10', 'Plano', '8883331234', '1456 Street' ,  'USA' , '67899', 'NA');



-- 
/*
 * create database example_db;
 * use example db;
 * 
 */