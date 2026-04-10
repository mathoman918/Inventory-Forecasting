# Inventory Forecasting & Demand Analysis

## Project Overview

This project analyzes inventory, sales, and demand forecasting data to identify trends, improve forecasting accuracy, and reduce stockout risks. The goal is to support better inventory planning and data-driven decision-making using SQL, Excel, and Power BI.

## Business Problem

Organizations often struggle to balance inventory levels with customer demand. Poor forecasting can lead to:

* Stockouts and lost sales
* Overstocking and increased holding costs
* Poor promotion planning

This project analyzes inventory data to identify demand patterns, evaluate forecast performance, and highlight stockout risks.

## Dataset

The dataset includes inventory and sales data with the following key fields:

* Date
* Store and Product identifiers
* Category and Region
* Inventory Level and Units Sold
* Demand Forecast
* Pricing and Discounts
* Promotion indicators
* Seasonality information

## Data Processing

Data preparation and feature engineering were performed using SQL and Power BI:

* Cleaned column names for consistency
* Checked and handled missing values
* Created new fields:

  * Year, Month, Day
  * Revenue
  * Forecast Error
  * Stockout Status
  * Promotion Status

A cleaned dataset was generated for analysis and reporting.

## Analysis Performed

### Sales Performance

* Sales by product category
* Regional performance analysis
* Monthly sales trends

### Forecast Accuracy

* Forecast vs actual sales comparison
* Mean Absolute Error (MAE) evaluation

### Inventory & Risk

* Stockout risk identification
* Risk distribution by category

### Promotions & Seasonality

* Impact of promotions on sales
* Seasonal demand trends

## Dashboard & Reporting

An interactive dashboard was built to visualize:

* Total sales and revenue
* Forecast performance
* Stockout risks
* Promotion effectiveness
* Sales trends by category and region

Filters were added to enable analysis by:

* Region
* Category
* Year
* Promotion status

## Key Insights

* Promotions significantly increase sales performance.
* Certain categories show higher stockout risk.
* Forecast accuracy is moderate and can be improved.
* Seasonality plays a key role in demand patterns.

## Recommendations

* Improve forecasting models to reduce errors.
* Optimize inventory levels for high-risk categories.
* Align inventory planning with promotional and seasonal demand.
* Use data insights for proactive inventory management.

## Tools Used

* SQL | Databricks (Data processing and transformation)
* Excel (Pivot analysis and exploration)
* Power BI (Dashboard and visualization)
* GitHub (Version control and documentation)

## Conclusion

This project demonstrates how data analytics can support better inventory planning, reduce risks, and improve decision-making through data-driven insights.

