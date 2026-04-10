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
    SUM(Units_Sold) AS Total_Units_Sold,
    SUM(Units_Sold * Price) AS Revenue,
    AVG(Inventory_Level) AS Avg_Inventory
FROM workspace.default.inventory_forecasting_clean
GROUP BY Category
ORDER BY Total_Units_Sold DESC;

--- Sales by Region
SELECT
    Region,
    SUM(Units_Sold) AS Total_Sales,
    SUM(Units_Sold * Price) AS Revenue
FROM workspace.default.inventory_forecasting_clean
GROUP BY Region
ORDER BY Revenue DESC;

--- Sales by Month
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Units_Sold) AS Monthly_Sales
FROM workspace.default.inventory_forecasting_clean
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

--- 5. Promotion Analysis
SELECT
    `Holiday/Promotion`,
    AVG(Units_Sold) AS Avg_Sales,
    AVG(Discount) AS Avg_Discount,
    SUM(Units_Sold * Price) AS Revenue
FROM workspace.default.inventory_forecasting_clean
GROUP BY `Holiday/Promotion`;

--- 6. Forecast Accuracy
SELECT
    Category,
    AVG(ABS(Units_Sold - Demand_Forecast)) AS MAE
FROM workspace.default.inventory_forecasting_clean
GROUP BY Category;

--- 7. Inventory & Stockout Analysis
SELECT
    Category,
    COUNT(*) AS Records,
    SUM(CASE WHEN Inventory_Level < Demand_Forecast THEN 1 ELSE 0 END) AS Stockout_Risk_Count
FROM workspace.default.inventory_forecasting_clean
GROUP BY Category;

--- 8. Sales by season
SELECT
    Weather_condition,
    AVG(Units_Sold) AS AVG_Units_sold
FROM workspace.default.inventory_forecasting_clean
GROUP BY Weather_condition;

--- 9. Top Products
SELECT
    Product_ID,
    SUM(Units_Sold) AS Revenue
FROM workspace.default.inventory_forecasting_clean
GROUP BY Product_ID 
ORDER BY Revenue DESC;

--- preview the cleaned dataset
SELECT *
FROM workspace.default.inventory_forecasting_clean
limit 10;
