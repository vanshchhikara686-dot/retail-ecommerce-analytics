/*
PROJECT: D2C Revenue, Profitability & Customer Analytics
DATABASE: d2c_analytics
DIALECT: Microsoft SQL Server (T-SQL)

Expected tables:
  dbo.Customers
  dbo.Products
  dbo.orderrs       -- table name as used in the source database
  dbo.OrderItems

Analysis convention:
  Revenue and gross profit are calculated from OrderItems.
  Delivered-order analyses filter Orders/OrderItems to Delivered.
  COUNT(DISTINCT Order_ID) is used when counting orders after joining to line items.
*/

USE d2c_analytics;
GO

-- 1. Dataset overview: row counts
SELECT 'Customers' AS Table_Name, COUNT_BIG(*) AS Row_Count FROM dbo.Customers
UNION ALL SELECT 'Products', COUNT_BIG(*) FROM dbo.Products
UNION ALL SELECT 'Orders', COUNT_BIG(*) FROM dbo.orderrs
UNION ALL SELECT 'OrderItems', COUNT_BIG(*) FROM dbo.OrderItems;
GO

-- 2. Overall delivered business performance
SELECT
    SUM(oi.Revenue_INR) AS Total_Revenue_INR,
    SUM(oi.Gross_Profit_INR) AS Total_Gross_Profit_INR,
    SUM(oi.Quantity) AS Total_Units_Sold,
    COUNT(DISTINCT o.Order_ID) AS Total_Delivered_Orders,
    COUNT(DISTINCT o.Customer_ID) AS Customers_With_Delivered_Orders,
    CAST(100.0 * SUM(oi.Gross_Profit_INR) /
         NULLIF(SUM(oi.Revenue_INR), 0) AS DECIMAL(10,2)) AS Gross_Profit_Margin_Pct
FROM dbo.orderrs AS o
INNER JOIN dbo.OrderItems AS oi
    ON o.Order_ID = oi.Order_ID
WHERE o.Order_Status = 'Delivered'
  AND oi.Order_Status = 'Delivered';
GO

-- 3. Revenue and profitability by product category
SELECT
    p.Category,
    SUM(oi.Revenue_INR) AS Revenue_INR,
    SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR,
    SUM(oi.Quantity) AS Units_Sold,
    CAST(100.0 * SUM(oi.Gross_Profit_INR) /
         NULLIF(SUM(oi.Revenue_INR), 0) AS DECIMAL(10,2)) AS Gross_Margin_Pct
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Products AS p
    ON oi.Product_ID = p.Product_ID
WHERE oi.Order_Status = 'Delivered'
GROUP BY p.Category
ORDER BY Revenue_INR DESC;
GO

-- 4. Performance by customer acquisition channel
SELECT
    c.Acquisition_Channel,
    COUNT(DISTINCT c.Customer_ID) AS Customers,
    COUNT(DISTINCT o.Order_ID) AS Delivered_Orders,
    SUM(oi.Revenue_INR) AS Revenue_INR,
    SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR,
    CAST(100.0 * SUM(oi.Gross_Profit_INR) /
         NULLIF(SUM(oi.Revenue_INR), 0) AS DECIMAL(10,2)) AS Gross_Margin_Pct,
    CAST(SUM(oi.Revenue_INR) /
         NULLIF(COUNT(DISTINCT o.Order_ID), 0) AS DECIMAL(18,2)) AS Revenue_Per_Order_INR
FROM dbo.Customers AS c
INNER JOIN dbo.orderrs AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN dbo.OrderItems AS oi
    ON o.Order_ID = oi.Order_ID
WHERE o.Order_Status = 'Delivered'
  AND oi.Order_Status = 'Delivered'
GROUP BY c.Acquisition_Channel
ORDER BY Revenue_INR DESC;
GO

-- 5. Top 10 products by revenue
SELECT TOP (10)
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(oi.Revenue_INR) AS Revenue_INR,
    SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR,
    SUM(oi.Quantity) AS Units_Sold
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Products AS p
    ON oi.Product_ID = p.Product_ID
WHERE oi.Order_Status = 'Delivered'
GROUP BY p.Product_ID, p.Product_Name, p.Category
ORDER BY Revenue_INR DESC;
GO

-- 6. Top 10 products by gross profit
SELECT TOP (10)
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR,
    SUM(oi.Revenue_INR) AS Revenue_INR,
    SUM(oi.Quantity) AS Units_Sold
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Products AS p
    ON oi.Product_ID = p.Product_ID
WHERE oi.Order_Status = 'Delivered'
GROUP BY p.Product_ID, p.Product_Name, p.Category
ORDER BY Gross_Profit_INR DESC;
GO

-- 7. Monthly revenue, gross profit and delivered orders
WITH MonthlyPerformance AS
(
    SELECT
        YEAR(o.Order_Date) AS Order_Year,
        MONTH(o.Order_Date) AS Order_Month,
        SUM(oi.Revenue_INR) AS Revenue_INR,
        SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR,
        COUNT(DISTINCT o.Order_ID) AS Delivered_Orders
    FROM dbo.orderrs AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.Order_ID = oi.Order_ID
    WHERE o.Order_Status = 'Delivered'
      AND oi.Order_Status = 'Delivered'
    GROUP BY YEAR(o.Order_Date), MONTH(o.Order_Date)
)
SELECT
    Order_Year,
    Order_Month,
    Revenue_INR,
    Gross_Profit_INR,
    Delivered_Orders,
    LAG(Revenue_INR) OVER (ORDER BY Order_Year, Order_Month) AS Previous_Month_Revenue_INR,
    CAST(100.0 * (Revenue_INR - LAG(Revenue_INR) OVER (ORDER BY Order_Year, Order_Month)) /
         NULLIF(LAG(Revenue_INR) OVER (ORDER BY Order_Year, Order_Month), 0)
         AS DECIMAL(10,2)) AS Revenue_MoM_Growth_Pct
FROM MonthlyPerformance
ORDER BY Order_Year, Order_Month;
GO

-- 8. Customer segment performance
SELECT
    c.Customer_Segment,
    COUNT(DISTINCT c.Customer_ID) AS Customers,
    COUNT(DISTINCT o.Order_ID) AS Delivered_Orders,
    SUM(oi.Revenue_INR) AS Revenue_INR,
    SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR,
    CAST(SUM(oi.Revenue_INR) /
         NULLIF(COUNT(DISTINCT c.Customer_ID), 0) AS DECIMAL(18,2)) AS Revenue_Per_Customer_INR
FROM dbo.Customers AS c
INNER JOIN dbo.orderrs AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN dbo.OrderItems AS oi
    ON o.Order_ID = oi.Order_ID
WHERE o.Order_Status = 'Delivered'
  AND oi.Order_Status = 'Delivered'
GROUP BY c.Customer_Segment
ORDER BY Revenue_INR DESC;
GO

-- 9. Order status distribution
SELECT
    Order_Status,
    COUNT(*) AS Orders,
    CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(10,2)) AS Order_Status_Share_Pct
FROM dbo.orderrs
GROUP BY Order_Status
ORDER BY Orders DESC;
GO

-- 10. Discount band profitability
WITH DiscountedItems AS
(
    SELECT
        CASE
            WHEN Discount_Pct < 10 THEN '0-9%'
            WHEN Discount_Pct < 20 THEN '10-19%'
            WHEN Discount_Pct < 30 THEN '20-29%'
            WHEN Discount_Pct < 40 THEN '30-39%'
            ELSE '40%+'
        END AS Discount_Band,
        CASE
            WHEN Discount_Pct < 10 THEN 1
            WHEN Discount_Pct < 20 THEN 2
            WHEN Discount_Pct < 30 THEN 3
            WHEN Discount_Pct < 40 THEN 4
            ELSE 5
        END AS Band_Sort,
        Revenue_INR,
        Gross_Profit_INR,
        Quantity
    FROM dbo.OrderItems
    WHERE Order_Status = 'Delivered'
)
SELECT
    Discount_Band,
    SUM(Revenue_INR) AS Revenue_INR,
    SUM(Gross_Profit_INR) AS Gross_Profit_INR,
    SUM(Quantity) AS Units_Sold,
    CAST(100.0 * SUM(Gross_Profit_INR) /
         NULLIF(SUM(Revenue_INR), 0) AS DECIMAL(10,2)) AS Gross_Margin_Pct
FROM DiscountedItems
GROUP BY Discount_Band, Band_Sort
ORDER BY Band_Sort;
GO

-- 11. Repeat-purchase behaviour by customer
WITH CustomerOrders AS
(
    SELECT
        o.Customer_ID,
        COUNT(DISTINCT o.Order_ID) AS Delivered_Order_Count,
        SUM(oi.Revenue_INR) AS Revenue_INR,
        SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR
    FROM dbo.orderrs AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.Order_ID = oi.Order_ID
    WHERE o.Order_Status = 'Delivered'
      AND oi.Order_Status = 'Delivered'
    GROUP BY o.Customer_ID
)
SELECT
    CASE WHEN Delivered_Order_Count = 1 THEN 'One-time'
         ELSE 'Repeat' END AS Customer_Type,
    COUNT(*) AS Customers,
    SUM(Delivered_Order_Count) AS Delivered_Orders,
    SUM(Revenue_INR) AS Revenue_INR,
    SUM(Gross_Profit_INR) AS Gross_Profit_INR,
    CAST(SUM(Revenue_INR) / NULLIF(COUNT(*), 0) AS DECIMAL(18,2)) AS Revenue_Per_Customer_INR
FROM CustomerOrders
GROUP BY CASE WHEN Delivered_Order_Count = 1 THEN 'One-time' ELSE 'Repeat' END
ORDER BY Revenue_INR DESC;
GO

-- 12. Geographic performance by city
SELECT
    c.City,
    COUNT(DISTINCT c.Customer_ID) AS Customers,
    COUNT(DISTINCT o.Order_ID) AS Delivered_Orders,
    SUM(oi.Revenue_INR) AS Revenue_INR,
    SUM(oi.Gross_Profit_INR) AS Gross_Profit_INR
FROM dbo.Customers AS c
INNER JOIN dbo.orderrs AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN dbo.OrderItems AS oi
    ON o.Order_ID = oi.Order_ID
WHERE o.Order_Status = 'Delivered'
  AND oi.Order_Status = 'Delivered'
GROUP BY c.City
ORDER BY Revenue_INR DESC;
GO
