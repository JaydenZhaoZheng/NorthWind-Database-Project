SELECT
    YEAR(O.OrderDate) AS Year,
    MONTH(O.OrderDate) AS Month,
    C.CategoryName,
    ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 0) AS TotalSales
FROM
    Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY
    YEAR(O.OrderDate),
    MONTH(O.OrderDate),
    C.Categoryname
ORDER BY
    Year,
    Month,
    C.CategoryName;
