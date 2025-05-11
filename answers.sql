-- Step 1: Create a CTE to assign row numbers to each product
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
