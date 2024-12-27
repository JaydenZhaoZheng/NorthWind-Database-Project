SELECT
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 0) AS TotalSales
FROM
    Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY
    Year,
    Month;
