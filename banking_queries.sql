-- Interactive Exercise - Banking Queries

use Banking;

-- Q1. For each product, show the product name "Product" and the product type name "Type".

select * from product;

select name as 'Product', product_type_cd as 'Type'
from product;

-- Q2. For each branch, list the branch name and city, plus the last name and title of each employee 
-- who works in that branch.

select * from branch;
describe employee;

-- branch id with branch name and city AND employee name and title 

select branch_id as 'Branch', name as 'Name', city as 'City', first_name as 'Employee Name', title as 'Title'
from branch b 
left join employee e 
on BRANCH_ID = ASSIGNED_BRANCH_ID;

-- 3. Show a list of each unique employee title.

select title from employee;

select distinct title as "Title" 
from employee;

-- 4. Show the last name and title of each employee, along with the last name and title of that employee's boss.

select * from employee;
describe employee;

-- you need to specify the table in the selct and in the ON statement 
-- note there is a difference between left join and join 

select e.LAST_NAME  as 'Last Name', e.TITLE as 'Title', e2.SUPERIOR_EMP_ID as 'Supervisor', e2.Last_Name as 'Last Name'
from employee e
join employee e2 
on e.EMP_ID = e2.SUPERIOR_EMP_ID; 

-- 5. For each account, show the name of the account's product, the available balance, and the customer's last name.

-- account product balance 
-- customer last name 

select p.NAME as 'Product Name', a.AVAIL_BALANCE as 'Available Balance', i.last_name as 'Last Name'
from account as a
join product as p on a.PRODUCT_CD = p.PRODUCT_CD
join individual as i on a.CUST_ID = i.CUST_ID;                   
 
-- 6. List all account transaction details for individual customers whose last name starts with 'T'.

select * from acc_transaction;

select at2.*, i.last_name
from acc_transaction as at2
join  account as a on at2.account_ID = a.account_ID
join customer as c on a.CUST_ID = c.CUST_ID
join individual as i on c.CUST_ID = i.CUST_ID 
Where i.LAST_NAME Like 'T%';

