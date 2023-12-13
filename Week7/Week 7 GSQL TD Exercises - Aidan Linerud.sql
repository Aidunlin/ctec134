-- GSQL WEEK 7 EXERCISES 1-15, PAGES 163-164

-- Student name: Aidan Linerud

USE TALdistributors_Rick2
GO

-- #1  List order number, order date, customer number and customer  
--     name for each order

SELECT OrderNum, OrderDate, tblCustomer.CustomerNum, CustomerName
FROM tblOrders
INNER JOIN tblCustomer
ON tblOrders.CustomerNum = tblCustomer.CustomerNum;

-- #2 List order number, customer number, customer name for all 
--    orders placed on 10-15-2015

SELECT OrderNum, tblCustomer.CustomerNum, CustomerName
FROM tblOrders
INNER JOIN tblCustomer
ON tblOrders.CustomerNum = tblCustomer.CustomerNum
    AND tblOrders.OrderDate = '2015-10-15';

--#3 Order number, order date, item number, units ordered and quoted price
--   for each order line that makes up the order

SELECT tblOrderLine.OrderNum, OrderDate, ItemNum, NumOrdered, QuotedPrice
FROM tblOrderLine
INNER JOIN tblOrders
ON tblOrderLine.OrderNum = tblOrders.OrderNum;

--#4 Customer number and name who placed an order on 10/15/2015 (using the IN operator)

SELECT CustomerNum, CustomerName
FROM tblCustomer
WHERE CustomerNum IN (
    SELECT CustomerNum
    FROM tblOrders
    WHERE OrderDate = '2015-10-15'
);

--#5 (same as #4 but using the EXISTS operator)

SELECT CustomerNum, CustomerName
FROM tblCustomer
WHERE EXISTS (
    SELECT *
    FROM tblOrders
    WHERE tblCustomer.CustomerNum = tblOrders.CustomerNum
        AND OrderDate = '2015-10-15'
);

--#6 Customer number and name for all customers who did NOT place an order on 10/15/2015 

-- Hint: Needs to include customers with no orders at all
-- Hint: Look above at #4

SELECT CustomerNum, CustomerName
FROM tblCustomer
WHERE CustomerNum NOT IN (
    SELECT CustomerNum
    FROM tblOrders
    WHERE OrderDate = '2015-10-15'
);

--#7 For each order list order number, order date, item number, item description and category

SELECT ol.OrderNum, o.OrderDate, ol.ItemNum, i.Description, i.Category
FROM tblOrderLine AS ol, tblItem AS i, tblOrders AS o
WHERE i.ItemNum = ol.ItemNum
    AND o.OrderNum = ol.OrderNum;

--#8 Same as #7 but sort by class and then order number

SELECT ol.OrderNum, o.OrderDate, ol.ItemNum, i.Description, i.Category
FROM tblOrderLine AS ol, tblItem AS i, tblOrders AS o
WHERE i.ItemNum = ol.ItemNum AND o.OrderNum = ol.OrderNum
ORDER BY i.Category, ol.OrderNum;

--#9 List rep num, last name and first name for each rep who has a customer
--   with a credit limit of $10,000. List each rep only once. Use a subquery.

SELECT r.RepNum, r.LastName, r.FirstName
FROM tblRep AS r
WHERE r.RepNum IN (
    SELECT RepNum FROM tblCustomer WHERE CreditLimit = 10000
);

--#10 Same as #9 but do not use a subquery

SELECT r.RepNum, r.LastName, r.FirstName
FROM tblRep AS r, tblCustomer AS c
WHERE r.RepNum = c.RepNum
    AND c.CreditLimit = 10000;

-- #11 Find the number and name of each customer that currently has an 
-- order on file for a Rocking Horse. 

-- Hint: needs to join four tables

SELECT c.CustomerNum, c.CustomerName
FROM tblCustomer AS c, tblOrders AS o, tblOrderLine AS ol, tblItem AS i
WHERE c.CustomerNum = o.CustomerNum
    AND o.OrderNum = ol.OrderNum
    AND ol.ItemNum = i.ItemNum
    AND i.Description = 'Rocking Horse';

-- #12 List the item number, description and category for each pair of 
-- items that are in the same category. (For example, one such pair would
-- be item CD33 and item DL51, because the category for both is TOY)

-- Hint: Look at self join example on GSQL page 144 & 145

SELECT i1.ItemNum, i1.Description, i2.ItemNum, i2.Description, i2.Category
FROM tblItem AS i1, tblItem AS i2
WHERE i1.Category = i2.Category
    AND i1.ItemNum < i2.ItemNum;

-- #13 List the order number and order date for each order placed by the
-- customer name Johnson's Department Store. 

-- Hint: To enter an apostrophe (single quotation mark) within a string
-- of characters, type two single quotation marks.)

SELECT o.OrderNum, o.OrderDate
FROM tblOrders AS o, tblCustomer AS c
WHERE o.CustomerNum = c.CustomerNum
    AND c.CustomerName = 'Johnson''s Department Store';

-- #14 List the order number and order date for each order that contains an
-- order line for a Fire Engine.

SELECT o.OrderNum, o.OrderDate
FROM tblOrders AS o, tblOrderLine AS ol, tblItem AS i
WHERE o.OrderNum = ol.OrderNum
    AND ol.ItemNum = i.ItemNum
    AND i.Description = 'Fire Engine';

-- #15 List the order number and order date for each order that either was
-- placed by Almondton General Store or that contains an order line for a
-- Fire Engine.

-- Hint: Two union compatible queries joined with the UNION clause. 
--		Look at GSQL pages 150 & 151.
--		The columns following the two SELECTs must be the same data types.
--		The columns used in JOIN and/or WHERE clauses do not need to be
--		included in the SELECT column list.

    SELECT o.OrderNum, o.OrderDate
    FROM tblOrders AS o, tblCustomer AS c
    WHERE o.CustomerNum = c.CustomerNum
        AND c.CustomerName = 'Almondton General Store'
UNION
    SELECT o.OrderNum, o.OrderDate
    FROM tblOrders AS o, tblOrderLine AS ol, tblItem AS i
    WHERE o.OrderNum = ol.OrderNum
        AND ol.ItemNum = i.ItemNum
        AND i.Description = 'Fire Engine';
