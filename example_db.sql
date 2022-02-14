-- create database called example_db
-- employee table has emp id, name and age for table 1
-- address table will have address id, address st, and city, state, fk_employee id, TIMESTAMP with default of NOW
-- contraints fk in address table for employee table

-- to create a db: CREATE DATABASE name_of_db...

create database example_db;

-- now, if you refresh DB on the left the db example_db will be there. Good Job!

-- use database_name... to work in it 

use example_db;

/*
 *  create a table with... CREATE TABLE tablename with datatypes and contraints
 * 
 * create table table name (
 * field_id datatype(constraint i.e. number constraint) primary key auto_increment ,
 * field1 datatype () ,
 * field2 datatype () ,
 *...
 * );
 * 
 * Note: PK cannot be null so you do not need to specify that it  has to be not null
 * example of a field format: fieldname datatype() not null default ' ' 
 * 
 */

create table employee (
	emp_id int(4) primary key auto_increment, 
	name varchar(255) not null default 'MISSING',
	age tinyint(127) check(age >= 0)
);

-- refresh example_db - your table will now be there! 

select * from employee;

-- see the rules/strucutre of your employee table

describe employee;

-- ticks do not work for my fieldnames with insert command, the below line works! 
insert into employee (name, age) values ('keith', 25);

-- this should not work due to our rules/constraints.. age cannot be less than 0

insert into employee (name, age) values ('jafer', -1);
-- error - good!
insert into employee (name, age) values ('jafer', 1);
-- now, it will be accepted
insert into employee (name, age) values ('reema', 45);

-- name can be null, here the name shoudl defualt to MISSING 
insert into employee (age) values ( 45);

/*
 * mp_id|name   |age|
-----+-------+---+
    1|keith  | 25|
    2|jafer  |  1|
    3|reema  | 45|
    4|MISSING| 45|
 * 
 */

select * from employee;

-- now it is time to make the address table 


create table address (
	address_id int(11) primary key auto_increment,
	address_street varchar(255) not null default  'unknown',
	city varchar(255) not null default 'unknown',
	state char(2) not null default 'na',
-- TIMESTAMP cannot be null 
	timestampt TIMESTAMP not null default NOW(6),
-- Foreign Key, give the same contraints as it is in the primary key in its main table
	fk_emp_id int(4),
-- define contstraint for FK right after 
	-- some_name is the name for constraint
	constraint some_name foreign key(fk_emp_id)
	references employee(emp_id)
	);

-- now you have two tables in this DB!

describe address;

/*
 * ield         |Type        |Null|Key|Default            |Extra         |
-------------+------------+----+---+-------------------+--------------+
ddress_id    |int(11)     |NO  |PRI|                   |auto_increment|
ddress_street|varchar(255)|NO  |   |unknown            |              |
ity          |varchar(255)|NO  |   |unknown            |              |
tate         |char(2)     |NO  |   |na                 |              |
imestampt    |timestamp   |NO  |   |current_timestamp()|              |
k_emp_id     |int(4)      |YES |MUL|                   |              |
 */


insert into address (address_street, city, state, fk_emp_id )
values ('123 street', 'plano', 'TX', 2);

select * from address;
/*
 * address_id|address_street|city |state|timestampt             |fk_emp_id|
----------+--------------+-----+-----+-----------------------+---------+
         1|123 street    |plano|TX   |2022-02-14 05:49:12.000|        2|
 * 
 */

insert into address (address_street, city, state, fk_emp_id )
values ('123 street', 'plano', 'TX', 122);

-- UH OH - can't run this one! Error occurs because the fk contstaint will not allow this data to be entered 



-- 2/14
use example_db;

-- drop the constraint 
-- alter table address drop constraint some_name;
-- add a constraint 
-- add table address add constraint some_name foreign key(fk_emp_id) references employee(emp_id);


-- here we joined two tables together - this is an inner joined 
Select *
--  left table
From employee 
-- right table
Join address on employee.emp_id = address.fk_emp_id ;

/* 
 * mp_id|name |age|address_id|address_street|city |state|timestampt             |fk_emp_id|
-----+-----+---+----------+--------------+-----+-----+-----------------------+---------+
    2|jafer|  1|         1|123 street    |plano|TX   |2022-02-14 05:49:12.000|        2|
 * 
 */

-- practiving Group By with classicmodels 
use classicmodels;
-- we see that there are repeating values 
select * from orders as o;

-- Group by - group something that repeats and put it together
-- i.e. we have some dates that are the same 
select status 
from orders 
group by status; 
/*
 * status    |
----------+
Cancelled |
Disputed  |
In Process|
On Hold   |
Resolved  |
Shipped   |
 */

-- now  I want to know HOW MANY each one of these appeared

select status, count(status) 
from orders 
group by status; 

/*
 * 
 
 * tatus    |count(status)|
---------+-------------+
ancelled |            6|
isputed  |            3|
n Process|            6|
n Hold   |            4|
esolved  |            4|
hipped   |          303|
*/


-- gave count(status) alias for readibility 
-- again I can not have tickers.... for second counter 
select status, count(status) as 'counter' 
from orders 
group by status
having counter > 4 ; 


-- show orderdetails table 

select * from orderdetails;

use example_db ;

select address_id, DATE_FORMAT(TIMESTAMP, '%Y')
from address;

/*
 * address_id|DATE_FORMAT(TIMESTAMP, '%Y')|
----------+----------------------------+
         1|2022                         
*/


-- here I selected only customer names that start with the letter A
use classicmodels

select * 
from customers as c 
where customerName like 'A%';

/*
**ustomerNumber|customerName                |contact
-------------+----------------------------+-------
          103|Atelier graphique           |Schmitt
          114|Australian Collectors, Co.  |Ferguso
          168|American Souvenirs Inc      |Franco 
          187|AV Stores, Co.              |Ashwort
*/