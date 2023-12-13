USE master;
GO

IF DB_ID ('Solmaris_AidanLinerud') IS NOT NULL
	DROP DATABASE Solmaris_AidanLinerud;
GO

CREATE DATABASE Solmaris_AidanLinerud;
GO

USE Solmaris_AidanLinerud;
GO



CREATE TABLE tblLocation (
	LocationNum		char(10) PRIMARY KEY,
	LocationName	char(40),
	Address			char(40),
	City			char(20),
	State			char(2),
	PostalCode		char(10),
);

CREATE TABLE tblOwner (
	OwnerNum	char(10) PRIMARY KEY,
	LastName	char(20),
	FirstName	char(30),
	Address		char(40),
	City		char(20),
	State		char(2),
	PostalCode	char(10),
);

CREATE TABLE tblCondoUnit (
	CondoID		char(10) PRIMARY KEY,
	LocationNum	char(10) NOT NULL FOREIGN KEY REFERENCES tblLocation(LocationNum),
	UnitNum		char(10),
	SqrFt		smallint,
	Bdrms		smallint,
	Baths		smallint,
	CondoFee	smallmoney,
	OwnerNum	char(10) FOREIGN KEY REFERENCES tblOwner(OwnerNum),
);

CREATE TABLE tblServiceCategory (
	CategoryNum			char(2) PRIMARY KEY,
	CategoryDescription	char(30),
);

CREATE TABLE tblServiceRequest (
	ServiceID		char(5) PRIMARY KEY,
	CondoID			char(10) NOT NULL FOREIGN KEY REFERENCES tblCondoUnit(CondoID),
	CategoryNum		char(2) NOT NULL FOREIGN KEY REFERENCES tblServiceCategory(CategoryNum),
	Description		char(100),
	Status			char(100),
	EstHours		smallint,
	SpentHours		smallint,
	NextServiceDate	date,
);



-- Data pulled from the textbook using Windows Snipping Tool's new text recognition feature,
-- and formatted using VS Code's multi-caret editing. Took me just 5 minutes!

INSERT INTO tblLocation (LocationNum, LocationName, Address, City, State, PostalCode)
VALUES
	('1', 'Solmaris Ocean', '100 Ocean Ave.', 'Bowton', 'FL', '31313'),
	('2', 'Solmaris Bayside', '405 Bayside Blvd.', 'Glander Bay', 'FL', '31044')
;

INSERT INTO tblOwner (OwnerNum, LastName, FirstName, Address, City, State, PostalCode)
VALUES
	('AD057', 'Adney', 'Bruce and Jean', '100 Ocean Ave.', 'Bowton', 'FL', '31313'),
	('AN175', 'Anderson', 'Bill', '18 Wilcox St.', 'Brunswick', 'GA', '31522'),
	('BL720', 'Blake', 'Jack', '2672 Condor St.', 'Mills', 'SC', '29707'),
	('EL025', 'Elend', 'Bill and Sandy', '100 Ocean Ave.', 'Bowton', 'FL', '31313'),
	('FE182', 'Feenstra', 'Daniel', '7822 Coventry Dr.', 'Rivard', 'FL', '31062'),
	('JU092', 'Juarez', 'Maria', '892 Oak St.', 'Kaleva', 'FL', '31521'),
	('KE122', 'Kelly', 'Alyssa', '527 Waters St.', 'Norton', 'MI', '49441'),
	('NO225', 'Norton', 'Peter and Caitlin', '281 Lakewood Ave.', 'Lawndale', 'PA', '19111'),
	('RO123', 'Robinson', 'Mike and Jane', '900 Spring Lake Dr.', 'Springs', 'MI', '49456'),
	('SM072', 'Smeltz', 'Jim and Cathy', '922 Garland Dr.', 'Lewiston', 'FL', '32765'),
	('TR222', 'Trent', 'Michael', '405 Bayside Blvd.', 'Glander Bay', 'FL', '31044'),
	('WS032', 'Wilson', 'Henry and Karen', '25 Nichols St.', 'Lewiston', 'FL', '32765')
;

INSERT INTO tblCondoUnit (CondoID, LocationNum, UnitNum, SqrFt, Bdrms, Baths, CondoFee, OwnerNum)
VALUES
	('1', '1', '102', 675, 1, 1, 475, 'AD057'),
	('2', '1', '201', 1030, 2, 1, 550, 'EL025'),
	('3', '1', '306', 1575, 3, 2, 625, 'AN175'),
	('4', '1', '204', 1164, 2, 2, 575, 'BL720'),
	('5', '1', '405', 1575, 3, 2, 625, 'FE182'),
	('6', '1', '401', 1030, 2, 2, 550, 'KE122'),
	('7', '1', '502', 745, 1, 1, 490, 'JU092'),
	('8', '1', '503', 1680, 3, 3, 670, 'RO123'),
	('9', '2', 'A03', 725, 1, 1, 190, 'TR222'),
	('10', '2', 'A01', 1084, 2, 1, 235, 'NO225'),
	('11', '2', 'B01', 1084, 2, 2, 250, 'SM072'),
	('12', '2', 'C01', 750, 1, 1, 190, 'AN175'),
	('13', '2', 'C02', 1245, 2, 2, 250, 'WS032'),
	('14', '2', 'C06', 1540, 3, 2, 300, 'RO123')
;

INSERT INTO tblServiceCategory (CategoryNum, CategoryDescription)
VALUES
	('1', 'Plumbinǵ'),
	('2', 'Heating/Air Conditioning'),
	('3', 'Painting'),
	('4', 'Electrical Systems'),
	('5', 'Carpentry'),
	('6', 'Janitorial')
;

INSERT INTO tblServiceRequest (ServiceID, CondoID, CategoryNum, Description, Status, EstHours, SpentHours, NextServiceDate)
VALUES
	('1', '2', '1', 'Back wall in pantry has mold indicating water seepage. Diagnose and repair.', 'Service rep has verified the problem. Plumbing contractor has been called.', '4', '2', '10-12-2015'),
	('2', '5', '2', 'Air conditioning doesn''t cool.', 'Service rep has verified problem. Air conditioning contractor has been called.', '3', '1', '10-12-2015'),
	('3', '4', '6', 'Hardwood floors must be refinished.', 'Service call has been scheduled.', '8', '0', '10-16-2015'),
	('4', '1', '4', 'Switches in kitchen and dining room are reversed.', 'Open', '1', '0', '10-13-2015'),
	('5', '2', '5', 'Modling in pantry must be replaced.', 'Cannot schedule until water leak is corrected.', '2', '0', NULL),
	('6', '14', '3', 'Unit needs to be repainted due to previous tenant damage.', 'Scheduled', '7', '0', '10-19-2015'),
	('7', '11', '4', 'Tenant complained that using microwave caused short circuits on two occasions.', 'Service rep unable to duplicate problem. Tenant to notify condo management if problem recurs.', '1', '1', NULL),
	('8', '9', '3', 'Kitchen must be repainted. Walls discolored due to kitchen fire.', 'Scheduled', '5', '0', '10-16-2015'),
	('9', '7', '6', 'Shampoo all carpets.', 'Open', '5', '0', '10-19-2015'),
	('10', '9', '5', 'Repair window sills.', 'Scheduled', '4', '0', '10-20-2015')
;



-- For reference:
/*
ALTER TABLE tblCondoUnit
	ADD CONSTRAINT FK_LocationNum FOREIGN KEY (LocationNum)
		REFERENCES tblLocation (LocationNum)
		ON UPDATE CASCADE;

ALTER TABLE tblCondoUnit
	ADD CONSTRAINT FK_OwnerNum FOREIGN KEY (OwnerNum)
		REFERENCES tblOwner (OwnerNum)
		ON UPDATE CASCADE;

ALTER TABLE tblServiceRequest
	ADD CONSTRAINT FK_CondoId FOREIGN KEY (CondoID)
		REFERENCES tblCondoUnit (CondoId)
		ON UPDATE CASCADE;

ALTER TABLE tblServiceRequest
	ADD CONSTRAINT FK_CondoId FOREIGN KEY (CategoryNum)
		REFERENCES tblServiceCategory (CategoryNum)
		ON UPDATE CASCADE;
*/
