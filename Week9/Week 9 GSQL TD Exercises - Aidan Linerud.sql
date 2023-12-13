-- Week 9 chapter 7 TD exercises 1-3, page 221-222, Rick Eaton */

-- Student Name: Aidan Linerud


 
--Note: The 'CREATE VIEW' command must be the first statement in a
--query batch. To batch query statements, use the 'GO' command. This 
--will ensure that all commands are executed prior to moving on to 
--the next command.

-- Important Note:	Follow my naming conventions, e.g. vwMajorCustomer
--					instead of MAJOR_CUSTOMER


USE TALdistributors_Rick2;
GO


-- #1a  Create view with customer number, name, balance, credit limit and
--		 rep number where the credit limit is $10,000 or less.
CREATE VIEW vwMajorCustomer AS
SELECT CustomerNum, CustomerName, Balance, CreditLimit, RepNum
FROM tblCustomer
WHERE CreditLimit <= 10000;
GO

-- #1b  Write and execute the command to retreive the customer number and name
--		of each customer where balance is over credit limit, using the
--		vwMajorCustomer view
SELECT CustomerNum, CustomerName
FROM vwMajorCustomer
WHERE Balance > CreditLimit;
GO

-- #1c - write the query the dbms acutally executes
SELECT CustomerNum, CustomerName
FROM tblCustomer
WHERE Balance > CreditLimit AND CreditLimit <= 10000;
GO

-- #1d - Does updating the data through this view create any problems? If so,
--			what are they? If not, why not? 

/*

vwMajorCustomer was made from a single table, tblCustomer.
vwMajorCustomer includes the primary key (CustomerNum) from tblCustomer.
Every tblCustomer column not included in vwMajorCustomer is nullable.
There are no statistics columns in vwMajorCustomer.

Deleting rows: no problems
Updating rows: no problems, as long as CreditLimit isn't changed to be above $10,000.
    Otherwise, the row will disappear from the view.
Adding rows: almost no problems. Columns that aren't in vwMajorCustomer will be set to null.
    Note that adding a customer with a CustomerNum that already exists in tblCustomer,
    but not in vwMajorCustomer, will still result in an error.

*/


-- #2a - Create view with Item number, description, price, order number,
--			order date, number ordered and quoted price
CREATE VIEW vwItemOrder AS
SELECT tblitem.ItemNum, Description, Price, tblOrders.OrderNum, OrderDate, NumOrdered, QuotedPrice
FROM tblItem, tblOrders, tblOrderLine
WHERE tblItem.ItemNum = tblOrderLine.ItemNum
AND tblOrders.OrderNum = tblOrderLine.OrderNum;
GO

-- #2b - Using above view, Item number, description, order number, quoted price,
--		where quoted price exceeds $100
SELECT ItemNum, Description, OrderNum, QuotedPrice
FROM vwItemOrder
WHERE QuotedPrice > 100;
GO

-- #2c - Write the query the dbms acutally executes
SELECT tblitem.ItemNum, Description, Price, tblOrders.OrderNum, OrderDate, NumOrdered, QuotedPrice
FROM tblItem, tblOrders, tblOrderLine
WHERE tblItem.ItemNum = tblOrderLine.ItemNum
AND tblOrders.OrderNum = tblOrderLine.OrderNum
AND QuotedPrice > 100;
GO

-- #2d - Does updating the data through this view create any problems? If so,
--			what are they? If not, why not? 

/*

vwItemOrder was made from a multi-table join involving tblItem, tblOrders, and tblOrderLine.
vwItemOrder includes the primary key from tblItem, the primary key from tblOrders,
    and each set of primary keys from tblOrderLine.
Every column not included in vwItemOrder is nullable.
There are no statistics columns in vwItemOrder.

Rows cannot be deleted, updated, or added. Because each table in the join uses different sets
of primary keys, it can be inconsistent to figure out what needs to be changed.
    From tblItem:       ItemNum -> Description, Price
    From tblOrders:     OrderNum -> OrderDate
    From tblOrderLine:  ItemNum, OrderNum -> NumOrdered, QuotedPrice
There can be multple rows with the same item number, description, and price, but in reality
those all point to the same item in tblItem. So what happens when one of those rows gets
changed through the view? Same applies for the order date. Technically, changing the
number ordered column or quoted price column should work (because each value in those
columns will be unique against the item num and order num). But it's best to treat the whole
view as read-only.

*/


-- #3a - Create a view named OrderTotal with order number, order total (named TotalAmount)
--		 for each order. Note: No need to include an ORDER BY clause here.
CREATE VIEW vwOrderTotal AS
SELECT OrderNum, SUM(NumOrdered * QuotedPrice) as TotalAmount
FROM tblOrderLine
GROUP BY OrderNum;
GO

-- #3b - Using the above view, retieve records where order total is greater than $500
SELECT *
FROM vwOrderTotal
WHERE TotalAmount > 500;
GO

-- #3c - write the query the dbms acutally executes
SELECT OrderNum, SUM(NumOrdered * QuotedPrice) as TotalAmount
FROM tblOrderLine
GROUP BY OrderNum
HAVING SUM(NumOrdered * QuotedPrice) > 500;
GO

-- #3d - Does updating the data through this view create any problems? If so,
--			what are they? If not, why not? 

/*

This view involves statistics/aggregate totals, so deleting/adding/updating rows in this
view is impossible.

*/
