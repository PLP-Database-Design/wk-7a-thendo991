
WITH RECURSIVE product_split AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS Remaining
    FROM ProductDetail

    UNION ALL

    SELECT
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Remaining, ',', 1)),
        SUBSTRING(Remaining, LENGTH(SUBSTRING_INDEX(Remaining, ',', 1)) + 2)
    FROM product_split
    WHERE Remaining != ''
)

SELECT 
    OrderID, 
    CustomerName, 
    Product
FROM 
    product_split
ORDER BY 
    OrderID;

/* this Query creates the Orders table (eliminate partial dependency): */
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM 
    OrderDetails;

/*this Query create the OrderItems table: */
SELECT 
    OrderID, 
    Product, 
    Quantity
FROM 
    OrderDetails;
