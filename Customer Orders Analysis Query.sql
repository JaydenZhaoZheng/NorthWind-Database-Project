SELECT
    YEAR(O.OrderDate) AS Year,
    MONTH(O.OrderDate) AS Month,
    C.CustomerID,
    C.CompanyName AS CustomerName,
    COUNT(O.OrderID) AS NumberOfOrders
FROM
    Orders O
    JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY
    YEAR(O.OrderDate),
    MONTH(O.OrderDate),
    C.CustomerID,
    C.CompanyName
ORDER BY
    Year,
    Month,
    C.CustomerID;
