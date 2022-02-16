use classicmodels;

-- SQL Operators Hands On Excercise 

Select * from customers;

-- 1. SQL OR Operator... Query all customers who are located in USA or France

Select customername, country
from customers 
where country = 'USA' OR country = 'France';

/* BONUS - you can also use the IN () to get the previous answer
Select customername, country
from customers 
where country IN ('USA', 'France');

**** 48 Rows will populate
*
customername                |countr
----------------------------+------
Atelier graphique           |France
Signal Gift Stores          |USA   
La Rochelle Gifts           |France
Mini Gifts Distributors Ltd.|USA   
Mini Wheels Co.             |USA   
Land of Toys Inc.           |USA   
Saveley & Henriot, Co.      |France
Muscle Machine Inc          |USA   
Diecast Classics Inc.       |USA   

....
 */



-- 2. SQL AND ()... boolean that returns only if both expressions are true.

-- 2.A The following statement returns the customers who are located in the USA or France and have credit limits greater than 10000.

Select customername, country, creditLimit 
FROM customers as c
WHERE (country = 'USA' OR country = 'France')       -- You can still use the IN () ... country IN ('USA', 'France')
AND creditLimit >100000;

/* 
 *  11 Rows 
 
customername                |country|creditLimi
----------------------------+-------+----------
La Rochelle Gifts           |France |  118200.0
Mini Gifts Distributors Ltd.|USA    |  210500.0
Land of Toys Inc.           |USA    |  114900.0
Saveley & Henriot, Co.      |France |  123900.0
Muscle Machine Inc          |USA    |  138500.0

*/


-- 2.B The below query will return the customers who locate in the USA or the customers who locate in France with the credit limit greater than 10000.

SELECT customername, country, creditLimit 
FROM customers
WHERE country = 'USA' OR country = 'France' AND creditLimit > 100000;

-- so hee USA does not have a credit limit restirction

/*customername                |country|creditLimit
----------------------------+-------+-----------
Signal Gift Stores          |USA    |   71800.00
La Rochelle Gifts           |France |  118200.00
Mini Gifts Distributors Ltd.|USA    |  210500.00
Mini Wheels Co.             |USA    |   64600.00
...
*/


-- 2c. The following statement retrieves customers who are located in California (CA) and USA. It uses the†AND operator in the expression†of the†WHERE†clause.

Select customername, country, state 
From customers as c
Where country = 'USA' AND state = 'CA';

/*
customername                |country|state|
----------------------------+-------+-----+
Mini Gifts Distributors Ltd.|USA    |CA   |
Mini Wheels Co.             |USA    |CA   |
Technics Stores Inc.        |USA    |CA   |
Toys4GrownUps.com           |USA    |CA   |
Boards & Toys Co.           |USA    |CA   |
Collectable Mini Designs Co.|USA    |CA   |
Corporate Gift Ideas Co.    |USA    |CA   |
Men 'R' US Retailers, Ltd.  |USA    |CA   |
The Sharp Gifts Warehouse   |USA    |CA   |
West Coast Collectables Co. |USA    |CA   |
Signal Collectibles Ltd.    |USA    |CA   |
*/

-- 2d With the AND operator, you can combine more than two Boolean expressions. For example, the following query returns the customers who are located in California, USA, and have credit limits greater than 100K.

Select customername, country, state, creditLimit 
From customers 
Where country = 'USA' AND state ='CA' AND creditLimit >100000;

/*
customername                |country|state|creditLimit
----------------------------+-------+-----+-----------
Mini Gifts Distributors Ltd.|USA    |CA   |  210500.00
Collectable Mini Designs Co.|USA    |CA   |  105000.00
Corporate Gift Ideas Co.    |USA    |CA   |  105000.00
*/


-- 3. SQL BETWEEN and NOT Between ()

-- 3a. Suppose you want to find products whose buy prices are within the ranges of†90†and†100, you can use the†BETWEEN†operator as the following query:

Select productCOde, productname, buyPrice
FROM products
Where buyPrice BETWEEN 90 AND 100;

/*
productCOde|productname                         |buyPrice|
-----------+------------------------------------+--------+
S10_1949   |1952 Alpine Renault 1300            |   98.58|
S10_4698   |2003 Harley-Davidson Eagle Drag Bike|   91.02|
S12_1099   |1968 Ford Mustang                   |   95.34|
S12_1108   |2001 Ferrari Enzo                   |   95.59|
S18_1984   |1995 Honda Civic                    |   93.89|
S18_4027   |1970 Triumph Spitfire               |   91.92|
S24_3856   |1956 Porsche 356A Coupe             |   98.30|
*/


-- 3b. You can achieve the same effect by using the greater than or equal†(>=) and less than or equal (†<=†) operators as the following query:

Select productCOde, productname, buyPrice
FROM products
Where buyPrice >= 90 AND buyPrice <= 100;

-- returns the same as the ^

-- 3c. To find the product whose buy price is not between $20 and $100, you combine the†BETWEEN†operator with the†NOT†operator as follows:

Select productCOde, productname, buyPrice
FROM products
Where buyprice NOT BETWEEN 20 AND 100; -- OR you can do .... Where buyprice <20 OR buyproce > 100;

/*
 * productCOde|productname                        |buyPrice
-----------+-----------------------------------+--------
S10_4962   |1962 LanciaA Delta 16V             |  103.42
S18_2238   |1998 Chrysler Plymouth Prowler     |  101.51
S24_2840   |1958 Chevy Corvette Limited Edition|   15.91
S24_2972   |1982 Lamborghini Diablo            |   16.24
 
 **/


-- SQL 'IS NULL'

-- The following query uses the IS NULL operator to find customers who do not have a sales representative:

SELECT customerName, country, salesrepemployeenumber
FROM customers
WHERE salesrepemployeenumber IS NULL
ORDER BY customerName;

/*
 * customerName                  |country     |salesrepemployeenumber|
------------------------------+------------+----------------------+
ANG Resellers                 |Spain       |                      |
Anton Designs, Ltd.           |Spain       |                      |
Asian Shopping Network, Co    |Singapore   |                      |
Asian Treasures, Inc.         |Ireland     |                      |
BG&E Collectables             |Switzerland |                      |
Cramer Spezialit√§ten, Ltd    |Germany     |                      |
Der Hund Imports              |Germany     |                      |
Feuer Online Stores, Inc      |Germany     |                      |
Franken Gifts, Co             |Germany     |                      |
Havel & Zbyszek Co            |Poland      |                      |
Kommission Auto               |Germany     |                      |
Kremlin Collectables, Co.     |Russia      |                      |
Lisboa Souveniers, Inc        |Portugal    |                      |
Messner Shopping Network      |Germany     |                      |
Mit Vergn√ºgen & Co.          |Germany     |                      |
Nat√ºrlich Autos              |Germany     |                      |
Porto Imports Co.             |Portugal    |                      |
Raanan Stores, Inc            |Israel      |                      |
SAR Distributors, Co          |South Africa|                      |
Schuyler Imports              |Netherlands |                      |
Stuttgart Collectable Exchange|Germany     |                      |
Warburg Exchange              |Germany     |                      |
*/


-- 2. The below query uses the IS NOT NULL operator to get the customers who have a sales representative:

Select Customername, country, salesrepemployeenumber 
From customers 
where salesRepEmployeeNumber IS NOT NULL 
Order by customerName;

/*
Customername                      |country    |salesrepemployeenumber
----------------------------------+-----------+----------------------
Alpha Cognac                      |France     |                  1370
American Souvenirs Inc            |USA        |                  1286
Amica Models & Co.                |Italy      |                  1401
Anna's Decorations, Ltd           |Australia  |                  1611
Atelier graphique                 |France     |                  1370
Australian Collectables, Ltd      |Australia  |                  1611
Australian Collectors, Co.        |Australia  |                  1611
Australian Gift Network, Co       |Australia  |                  1611

...
*/

