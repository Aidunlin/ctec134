-- Week 10 QSQL chapter 7 (continued), Exercise #4 through 7, page 222

-- Student Name: Aidan Linerud

USE TALdistributors_Rick2
GO



-- #4 Write, BUT DO NOT EXECUTE, the commands to grant the following privileges:

    -- a. User Ashton must be able to retreive data from the ITEM table

    GRANT SELECT ON tblItem TO Ashton;

    -- b. Users Kelly and Morgan must be able to add new orders and order lines.

    GRANT INSERT ON tblOrders TO Kelly, Morgan;
    GRANT INSERT ON tblOrderLine TO Kelly, Morgan;

    -- c. User James must be able to change the price for all items.

    GRANT UPDATE Price ON tblItem TO James;

    -- d. User Danielson must be able to delete customers.

    GRANT DELETE ON tblCustomer TO Anderson;

    -- e. All users must be able to retrieve each customer's number,
    -- name, street, city, state and postal code.

    GRANT SELECT (CustomerNum, CustomerName, Street, City, State, Zip)
    ON tblCustomer TO PUBLIC;

    -- f. User Perez must be able to create an index on the ORDERS table

    GRANT INDEX ON tblOrders TO Perez;

    -- g. User Washington must be able to change the structure of the ITEM table.

    GRANT ALTER ON tblItem TO Washington;

    -- h. User Grinstead must have all privelege on the ORDERS table

    GRANT ALL ON tblOrders TO Grinstead;



-- #5. Write, BUT DO NOT EXECUTE, the command to revoke the privelege 
-- given to user Ashton in exercise #4a above

REVOKE SELECT ON tblItem FROM Ashton;



-- #6. Perform the following tasks:

    -- a. Create an index named ITEM_INDEX1 on the ITEM_NUM columns in the 
    -- ORDER_LINE table.

    CREATE INDEX ItemIndex1 ON tblOrderLine(ItemNum);

    -- b. Create an index named ITEM_INDEX2 on the CATEGORY column in the 
    -- ITEM table.

    CREATE INDEX ItemIndex2 ON tblItem(Category);

    -- c. Create an index named ITEM_INDEX3 on the CATEGORY and STOREHOUSE 
    -- columns in the ITEM table

    CREATE INDEX ItemIndex3 ON tblItem(Category, Storehouse);

    -- d. Create in index named ITEM_INDEX4 on the CATEGORY and STOREHOUSE
    -- columns in the ITEM table. List categories in descending order.

    CREATE INDEX ItemIndex4 ON tblItem(Category DESC, Storehouse);



-- #7. Delete the index named ITEM_INDEX3  (write the SQL command)

DROP INDEX ItemIndex3;
