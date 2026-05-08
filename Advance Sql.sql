-- Top 5 product name,total sales category wise

WITH ProductSales AS (
    SELECT 
        p.Category, 
        p.Product_Name, 
        SUM(f.Sales) as TotalSales,
        DENSE_RANK() OVER(PARTITION BY p.Category ORDER BY SUM(f.Sales) DESC) as SalesRank
    FROM Fact_Sales f
    JOIN Dim_Product p ON f.Product_ID = p.Product_ID
    GROUP BY p.Category, p.Product_Name
)
SELECT * FROM ProductSales 
WHERE SalesRank <= 5; 

-- Premium Customer

SELECT 
    c.Customer_Name, 
    c.Segment, 
    SUM(f.Profit) as TotalProfit,
    RANK() OVER(PARTITION BY c.Segment ORDER BY SUM(f.Profit) DESC) as ProfitRank
FROM Fact_Sales as f
JOIN Dim_Customer c ON f.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name, c.Segment;


-- Find High Value Order


WITH OrderSummary AS (
    SELECT 
        Order_ID, 
        SUM(Sales) AS TotalOrderValue,
        SUM(Profit) AS TotalOrderProfit
    FROM Fact_Sales
    GROUP BY Order_ID
),
AverageStoreSales AS (
    SELECT AVG(TotalOrderValue) AS OverallAvg FROM OrderSummary
)
SELECT 
    os.Order_ID, 
    os.TotalOrderValue, 
    os.TotalOrderProfit
FROM OrderSummary os, AverageStoreSales avg
WHERE os.TotalOrderValue > avg.OverallAvg
ORDER BY os.TotalOrderValue DESC;

---------Product-wise Profitability & Sales Performance Status---------

SELECT 
    p.Product_Name, 
    p.Category,
    SUM(f.Sales) AS TotalSales,
    SUM(f.Profit) AS TotalProfit,
   
    CASE 
        WHEN SUM(f.Profit) > 1000 THEN 'Highly Profitable'
        WHEN SUM(f.Profit) BETWEEN 0 AND 1000 THEN 'Stable'
        WHEN SUM(f.Profit) < 0 THEN 'Loss Making'
        ELSE 'Neutral'
    END AS Profit_Status,
    
    CASE 
        WHEN SUM(f.Sales) > 5000 THEN 'Best Seller'
        WHEN SUM(f.Sales) BETWEEN 2000 AND 5000 THEN 'Average'
        ELSE 'Low Demand'
    END AS Sales_Performance
FROM Fact_Sales f
JOIN Dim_Product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Name, p.Category
ORDER BY TotalProfit DESC;

--------------End--------------------