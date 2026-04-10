--- DATA EXPLORATION
--- Preview the tables
SELECT *
FROM inventory_forecasting
LIMIT 10;

--- Data cleaning
CREATE OR REPLACE TABLE workspace.default.inventory_forecasting_clean AS
SELECT 
       Date,
       `Store ID`        AS Store_ID,
       `Product ID`      AS Product_ID,
       Category,
       Region,
       `Inventory Level` AS Inventory_Level,
       `Units Sold`      AS Units_Sold,
       `Units Ordered`   AS Units_Ordered,
       `Demand Forecast` AS Demand_Forecast,
       Price,
       Discount,
       `Weather Condition` AS Weather_Condition,
       `Competitor Pricing` AS Competitor_Pricing,
       `Holiday/Promotion`,

       -- Feature Engineering
       YEAR(Date) AS Year,
       MONTH(Date) AS Month,
       DAY(Date) AS Day,

       Units_Sold * Price * (1 - Discount/100) AS Revenue,

       Units_Sold - Demand_Forecast AS Forecast_Error,

       CASE 
           WHEN Inventory_Level < Demand_Forecast THEN 'Stockout Risk'
           ELSE 'OK'
       END AS Stockout_Status,

       CASE 
           WHEN `Holiday/Promotion` = 1 THEN 'Promotion'
           ELSE 'No Promotion'
       END AS Promotion_Status

FROM inventory_forecasting;

--- 4. Aggregations
--- Sales by Category
SELECT
    Category,
    SUM(`Units Sold`) AS Total_Units_Sold,
    SUM(`Units Sold` * Price) AS Total_Revenue,
    AVG(`Inventory Level`) AS Avg_Inventory
FROM inventory_forecasting
GROUP BY Category
ORDER BY Total_Units_Sold DESC;

--- Sales by Region
SELECT
    Region,
    SUM(`Units Sold`) AS Total_Sales,
    SUM(`Units Sold` * Price) AS Revenue
FROM inventory_forecasting
GROUP BY Region
ORDER BY Revenue DESC;

--- Sales by Month
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(`Units Sold`) AS Monthly_Sales
FROM inventory_forecasting
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

--- 5. Promotion Analysis
SELECT
    `Holiday/Promotion`,
    AVG(`Units Sold`) AS Avg_Sales,
    AVG(Discount) AS Avg_Discount,
    SUM(`Units Sold` * Price) AS Revenue
FROM inventory_forecasting
GROUP BY `Holiday/Promotion`;

--- 6. Forecast Accuracy
SELECT
    Category,
    AVG(ABS(`Units Sold` - `Demand Forecast`)) AS MAE
FROM inventory_forecasting
GROUP BY Category;

--- 7. Inventory & Stockout Analysis
SELECT
    Category,
    COUNT(*) AS Records,
    SUM(CASE WHEN `Inventory Level` < `Demand Forecast` THEN 1 ELSE 0 END) AS Stockout_Risk_Count
FROM inventory_forecasting
GROUP BY Category;
