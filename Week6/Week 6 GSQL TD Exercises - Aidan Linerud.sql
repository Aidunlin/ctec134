-- Week 6, GSQL TD Exercises #11 - 21, pages 130
-- Student Name: Aidan Linerud

USE TALdistributors_Rick2;
GO


--#11 Find number and name of customer who's name begins with "C".

SELECT CustomerNum, CustomerName FROM tblCustomer
WHERE CustomerName LIKE 'C%';

-- Using this alternate method is a bit more flexible as it allows you to
-- specify more than one starting character, e.g., all customers whose name
-- starts with C or T

SELECT CustomerNum, CustomerName FROM tblCustomer
WHERE CustomerName LIKE '[CT]%';

--#12 List all details about Items. Order the output by Item description.

SELECT * FROM tblItem
ORDER BY Description;

--#13 List all details about all Items. Order the output by Item number within Storehouse.

SELECT * FROM tblItem
ORDER BY Storehouse, ItemNum;

--#14 How many customers have balances that are more than their credit limits?

SELECT COUNT(*) FROM tblCustomer
WHERE Balance > CreditLimit;

--#15 Total balances for all customers represented by sales rep 15
--	with balances that are less than their credit limits.

SELECT SUM(Balance) FROM tblCustomer
WHERE RepNum = '15' AND Balance < CreditLimit;

--#16 List the Item number, Item description and on hand value of each Item
--	whose number of units on hand is more the the average 
--	number of units on hand for all Items. (Hint: Use a subquery)

SELECT ItemNum, Description, OnHand FROM tblItem
WHERE OnHand > (SELECT AVG(OnHand) FROM tblItem);

--#17 What is the price of the least expensive Item in the database?

SELECT MIN(Price) FROM tblItem;

--#18 What is the Item number, description, and price of the least
--	expensive Item in the database? (Hint: Use a subquery)

SELECT ItemNum, Description, Price FROM tblItem
WHERE PRICE = (SELECT MIN(Price) FROM tblItem);

--# 19 List the sum of the balances of all customers for each sales rep.
--		Order and group the results by sales rep number.

SELECT RepNum, SUM(Balance) FROM tblCustomer
GROUP BY RepNum ORDER By RepNum;

--#20 List the sum of the balances of all customers for each sales rep,
--	but restrict the output to thouse sales reps for which the sum is 
--	more than $5,000. Order the results by rep number.

SELECT RepNum, SUM(Balance) FROM tblCustomer
GROUP BY RepNum HAVING SUM(Balance) > 5000 ORDER By RepNum;

-- #21 List the item number of any item with an unknown description.

SELECT ItemNum FROM tblItem WHERE Description IS NULL;

--#22 List item number and description of all items that are in the PZL or TOY
--		category and contain the word 'Set' in the description.

SELECT ItemNum, Description FROM tblItem
WHERE Category IN ('PZL', 'TOY') AND Description LIKE '%Set%';

--#23 TAL Distributors is considering discounting all items by 10%.
--		List the item number, description and discounted price for all items.
--		Use 'DISCOUNTED_PRICE' (or 'Discounted Price') as the name for the
--		computed column.

SELECT ItemNum, Description, Price * .9 AS DiscountedPrice FROM tblItem;
