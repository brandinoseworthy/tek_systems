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



