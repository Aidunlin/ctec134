--
-- Week 5, GSQL TD Exercises #'s 1-10
-- Student Name: Aidan Linerud
--

USE TALdistributors_Rick2;
GO


--#1 List the Item number, description, and price for all items.

SELECT ItemNum, Description, Price
FROM tblItem;

--#2 List all rows and columns for the complete ORDERS table.

SELECT *
FROM tblOrders;

--#3 List the names of customers with credit limits of $10,000 or more.

SELECT CustomerName
FROM tblCustomer
WHERE CreditLimit >= 10000;

--#4 List the order number for each order placed by customer 
--		number 126 on 10/15/2015.

SELECT OrderNum
FROM tblOrders
WHERE CustomerNum = 126 AND OrderDate = '2015-10-15';

--#5 List the number and name of each customer represented by sales rep 30 
--		or sales rep 45. 

SELECT CustomerNum, CustomerName
FROM tblCustomer
WHERE RepNum = 30 OR RepNum = 45;

--#6 List the Item number and Item description of each Item that is not in 
--		item category PZL.

SELECT ItemNum, Description
FROM tblItem
WHERE Category != 'PZL';

--#7 List the Item number, description, and number of units on hand for each 
--		item that has between 20 and 40 units on hand, including both 20 and 40.
--		*** Do this two ways ***

SELECT ItemNum, Description, OnHand
FROM tblItem
WHERE OnHand BETWEEN 20 AND 40;

--#7 Alternate method (requested in textbook)

SELECT ItemNum, Description, OnHand
FROM tblItem
WHERE OnHand >= 20 AND OnHand <= 40;

--#8  List the item number, item description, and on-hand 
--		value (units on hand * unit price) of each item in item category TOY. 
--		Assign the name ON_HAND_VALUE to the computer column.

SELECT ItemNum, Description, OnHand * Price AS OnHandValue
FROM tblItem
WHERE Category = 'TOY';

--#9 List the item number, item description, and on-hand value for each item
--	whose on-hand value is at least $1,500.
--	Assign the name ON_HAND_VALUE to the computed column.

SELECT ItemNum, Description, OnHand * Price AS OnHandValue
FROM tblItem
WHERE OnHand * Price >= 1500;

--#10 Use the IN operator to list the item number and Item description of each item in
-- item category GME or PZL. 

SELECT ItemNum, Description
FROM tblItem
WHERE Category IN ('GME', 'PZL');
