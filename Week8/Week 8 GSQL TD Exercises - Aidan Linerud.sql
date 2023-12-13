
-- Week 8 GSQL Chapter 6 TD Exercises # 1-10, pages 188

-- Student Name: Aidan Linerud

-- IMPORTANT NOTE:	The 'Show results of #..' after each step does not
--					mean you need to submit your actual results in Canvas.
--					I provided them for your convenience to verify your
--					results. As usual, you only need to submit your .sql
--					script file.


USE TALdistributors_Rick2
GO



-- #1 Create tblNonGame table

CREATE TABLE tblNonGame (
	ItemNum CHAR (4) PRIMARY KEY,
	Description CHAR (30) NOT NULL,
	OnHand DECIMAL (4,0),
	Category CHAR (3),
	Price DECIMAL (6,2)
);

SELECT * FROM tblNonGame;



-- #2 Insert all non GME data from current Item table

INSERT INTO tblNonGame
SELECT ItemNum, Description, OnHand, Category, Price FROM tblItem
WHERE Category != 'GME';

SELECT * FROM tblNonGame;



-- #3 In NonGame table change description of DL51 to 'Classic Train Set'

UPDATE tblNonGame
SET Description = 'Classic Train Set'
WHERE ItemNum = 'DL51';

SELECT * FROM tblNonGame;



-- #4 Increase all TOY category items by 2%

UPDATE tblNonGame
SET Price = Price * 1.02
WHERE Category = 'TOY';

SELECT * FROM tblNonGame;



-- #5 Insert new item TL92	

INSERT INTO tblNonGame VALUES
('TL92', 'Dump Truck', 10, 'TOY', 59.95);

SELECT * FROM tblNonGame;



-- #6 Delete all Category 'PZL' records (rows)

DELETE FROM tblNonGame
WHERE Category = 'PZL';

SELECT * FROM tblNonGame;



-- #7 Change Category for part FD11 to Null

UPDATE tblNonGame
SET Category = NULL
WHERE ItemNum = 'FD11';

SELECT * FROM tblNonGame;



-- #8a Add an OnHandValue column

ALTER TABLE tblNonGame
ADD OnHandValue DECIMAL (7,2);

SELECT * FROM tblNonGame;



-- #8b Populate the OnHandValue with calculation OnHand * Price

UPDATE tblNonGame
SET OnHandValue = OnHand * Price;

SELECT * FROM tblNonGame;



-- #9 Increase length of Description column to 40

ALTER TABLE tblNonGame
ALTER COLUMN Description CHAR (40) NOT NULL;

EXEC sp_columns tblNonGame;



-- #10 Remove tblNonGame table
DROP TABLE tblNonGame;
