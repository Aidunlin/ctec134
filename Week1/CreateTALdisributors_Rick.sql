
/*
This T-SQL script builds the TAL Distributors test database
and loads the sample data found on paged 4-5 (also found on pages 22-23). 

In this script I am using two different ways to add
comments, with the slash/asterisk - asterisk/slash method 
and with the double dash method. Which method you use is your choice.
*/
	
USE master;
GO

IF DB_ID ('TALdistributors_Rick2') IS NOT NULL
	DROP DATABASE TALdistributors_Rick2;
GO

CREATE DATABASE TALdistributors_Rick2;
GO

USE TALdistributors_Rick2;
GO

--Create tblRep table

CREATE TABLE tblRep (
	RepNum 		char(10) PRIMARY KEY,
	LastName 	char(20) NULL,
	FirstName 	char(20) NULL,
	Street 		char(40) NULL,
	City 		char(20) NULL,
	State 		char(2) NULL,
	Zip 		char(10) NULL,
	Commission 	smallmoney NULL,
	Rate 		decimal(7, 4) NULL	);



--Create tblCustomer table with foreign key on RepNum
CREATE TABLE tblCustomer(
	CustomerNum 	char(10) PRIMARY KEY,
	CustomerName 	char(40) NOT NULL,
	Street 			char(40) NULL,
	City 			char(20) NULL,
	State 			char(2) NULL,
	Zip 			char(10) NULL,
	Balance 		smallmoney NULL,
	CreditLimit 	smallmoney NULL,
	RepNum 			char(10) NULL FOREIGN KEY REFERENCES tblRep(RepNum)
	 );


--Create tblItem table
CREATE TABLE tblItem (
	ItemNum 	char (10) PRIMARY KEY, 
	Description	char (40), 
	OnHand 		int, 
	Category	char (4),
	Storehouse 	char (2),
	Price 		smallmoney
	);

--Create tblOrders table
CREATE TABLE tblOrders(
	OrderNum 	char(10) PRIMARY KEY,
	OrderDate 	date NOT NULL,
	CustomerNum	char(10) NOT NULL FOREIGN KEY REFERENCES tblCustomer(CustomerNum)
	);

--Create tblOrderLine table with compound primary key and foreign key on OrderNum and foreign key on PartNum
CREATE TABLE tblOrderLine (
	OrderNum 	char (10) NOT NULL FOREIGN KEY REFERENCES tblOrders(OrderNum),
	ItemNum 	char (10) NOT NULL FOREIGN KEY REFERENCES tblItem(ItemNum),
	NumOrdered	int NOT NULL, 
	QuotedPrice	smallmoney NOT NULL,
	PRIMARY KEY (OrderNum, ItemNum)
	);


--Now add the data

--Add data to tblRep

INSERT INTO tblRep (RepNum, LastName, FirstName, Street, City, State, Zip, Commission, Rate)
VALUES 
	('15','Campos','Rafael','724 Vinca Dr.','Grove','CA','90092',23457.50,0.06),
	('30','Gradey','Megan','632 Liatris St.','Fullton','CA','90085',41317.00,0.08),
	('45','Tian','Hui','1785 Tyler Ave.','Northfield','CA','90098',27789.25,0.06),
	('60','Sefton','Janet','267 Oakley St.','Congaree','CA','90097',0.00,0.06);
	
--Add data to tblCustomer

INSERT INTO tblCustomer (CustomerNum, CustomerName, Street, City, State, Zip, Balance, CreditLimit, RepNum)
VALUES
	('126','Toys Galore','28 Laketon St.','Fullton','CA','90085',1210.25,7500.00,'15'),
	('260','Brookings Direct','452 Columbus Dr.','Grove','CA','90092',575.00,10000.00,'30'),
	('334','The Everything Shop','342 Magee St.','Congaree','CA','90097',2345.75,7500.00,'45'),
	('386','Johnson''s Department Store','124 Main St.','Northfield','CA','90098',879.25,7500.00,'30'),
	('440','Grove Historical Museum Store','3456 Central Ave.','Fullton','CA','90085',345.00,5000.00,'45'), 
	('502','Cards and More','167 Hale St.','Mesa','CA','90104',5025.75,5000.00,'15'),
	('586','Almondton General Store','3345 Devon Ave.','Almondton','CA','90125',3456.75,15000.00,'45'),
	('665','CRick2et Gift Shop','372 Oxford St.','Grove','CA','90092',678.90,7500.00,'30'),
	('713','Cress Store','12 Rising Sun Ave.','Congaree','CA','90097',4234.60,10000.00,'15'),
	('796','Unique Gifts','786 Passmore St.','Northfield','CA','90098',124.75,7500.00,'45'),
	('824','Kline''s','945 Gilham St.','Mesa','CA','90104',2475.99,15000.00,'30'),
	('893','All Season Gifts','382 Wildwood Ave.','Fullton','CA','90085',935.75,7500.00,'15');


--Add data to tblItem

INSERT INTO tblItem (ItemNum, Description, OnHand, Category, Storehouse, Price)
VALUES	
	('AH74','Patience',9,'GME','3',22.99),
	('BR23','Skittles',21,'GME','2',29.99),
	('CD33','Wood Block Set (48 piece)',36,'TOY','1',89.49),
	('DL51','Classic Railway Set',12,'TOY','3',107.95),
	('DR67','Giant Star Brain Teaser',24,'PZL','2',31.95),
	('DW23','Mancala',40,'GME','3',50.00),
	('FD11','Rocking Horse',8,'TOY','3',124.95),
	('FH24','Puzzle Gift Set',65,'PZL','1',38.95),
	('KA12','Cribbage Set',56,'GME','3',75.00),
	('KD34','Pentominoes Brain Teaser',60,'PZL','2',14.95),
	('KL78','Pick Up Sticks',110,'GME','1',10.95),
	('MT03','Zauberkasten Brain Teaser',45,'PZL','1',45.79),
	('NL89','Wood Block Set (62 piece)',32,'TOY','3',119.75),
	('TR40','Tic Tac Toe',75,'GME','2',13.99),
	('TW35','Fire Engine',30,'TOY','2',118.95);

--Add data to tblOrders

INSERT INTO tblOrders (OrderNum, OrderDate, CustomerNum)
VALUES	
	('51608','10-12-2015','126'),
	('51610','10-12-2015','334'),
	('51613','10-13-2015','386'),
	('51614','10-13-2015','260'),
	('51617','10-15-2015','586'),
	('51619','10-15-2015','126'),
	('51623','10-15-2015','586'),
	('51625','10-16-2015','796');

--Add data to tblOrderline

INSERT INTO tblOrderLine (OrderNum, ItemNum, NumOrdered, QuotedPrice)
VALUES	
	('51608','CD33',5.00,86.99),
	('51610','KL78',25.00,10.95),
	('51610','TR40',10.00,13.99),
	('51613','DL51',5.00,104.95),
	('51614','FD11',1.00,124.95),
	('51617','NL89',4.00,115.99),
	('51617','TW35',3.00,116.95),
	('51619','FD11',2.00,121.95),
	('51623','DR67',5.00,29.95),
	('51623','FH24',12.00,36.95),
	('51623','KD34',10.00,13.10),
	('51625','MT03',8.00,45.79);

--Enforce referential integrity by defining the Foreign Keys.

--This has already been done right in the CREATE TABLE definition
--***************************************************************
--but this method allows you to add, change or remove foreign key
--definitions after the fact. It also allows you to assign a name
--to the foreign key constraint and add options, e.g., CASCADE

--ALTER TABLE tblCustomer     
--	ADD CONSTRAINT FK_RepNum FOREIGN KEY (RepNum)     
--    REFERENCES tblRep (RepNum)     
--    ON UPDATE CASCADE;    

--ALTER TABLE tblOrders    
--	ADD CONSTRAINT FK_CustomerNum FOREIGN KEY (CustomerNum)     
--    REFERENCES tblCustomer (CustomerNum)     
--    ON UPDATE CASCADE;    

--ALTER TABLE tblOrderLine     
--	ADD CONSTRAINT FK_OrderNum FOREIGN KEY (OrderNum)     
--    REFERENCES tblOrders (OrderNum)     
--    ON UPDATE CASCADE;    

--ALTER TABLE tblOrderLine     
--	ADD CONSTRAINT FK_ItemNum FOREIGN KEY (ItemNum)     
--    REFERENCES tblItem (ItemNum)     
--    ON UPDATE CASCADE;    

/* 
The following commands drop the foreign key constraints
created in the above four commands. They are commented out
here because you actually don't want to run them. They are
here just for you to examine and maybe experiment with later.
*/

--ALTER TABLE tblCustomer DROP CONSTRAINT FK_RepNum;
--ALTER TABLE tblOrders DROP CONSTRAINT FK_CustomerNum;
--ALTER TABLE tblOrderLine DROP CONSTRAINT FK_OrderNum;
--ALTER TABLE tblOrderLine DROP CONSTRAINT FK_ItemNum;
