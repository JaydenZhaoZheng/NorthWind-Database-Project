-- Step 1: Calculate total quantity sold for each product each month
WITH MonthlyProductSales AS (
    SELECT
        -- Extract year from OrderDate
        YEAR(O.OrderDate) AS Year,
        -- Extract month from OrderDate
        MONTH(O.OrderDate) AS Month,
        -- Get the product name
        P.ProductName,
        -- Calculate the total quantity sold for each product
        SUM(OD.Quantity) AS TotalQuantity
    FROM
        -- Orders table
        Orders O
        -- Join with Order Details table
        JOIN [Order Details] OD ON O.OrderID = OD.OrderID
        -- Join with Products table
        JOIN Products P ON OD.ProductID = P.ProductID
    GROUP BY
        -- Group results by year, month, and product name
        YEAR(O.OrderDate),
        MONTH(O.OrderDate),
        P.ProductName
),

-- Step 2: Rank products by total quantity sold within each month
RankedProducts AS (
    SELECT
        Year,
        Month,
        ProductName,
        TotalQuantity,
        -- Assign a rank to each product based on total quantity sold
        RANK() OVER (PARTITION BY Year, Month ORDER BY TotalQuantity DESC) AS ProductRank
    FROM
        MonthlyProductSales
)

-- Step 3: Select the top-ranked product for each month
SELECT
    Year,
    Month,
    ProductName,
    TotalQuantity
FROM
    RankedProducts
WHERE
    -- Only select the top product for each month (rank = 1)
    ProductRank = 1
ORDER BY
    -- Order results by year and month
    Year,
    Month;
