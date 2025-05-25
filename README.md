# Blinkit Sales Analysis Using SQL

This project focuses on analyzing Blinkit sales data using SQL queries to extract, clean, and interpret data. The objective is to derive actionable insights from key performance indicators such as sales trends, fat content preferences, regional performance, and outlet characteristics. This analysis supports better business decision-making and strategy formulation for the retail grocery delivery segment.

## SQL Queries

**Standardization of Item Fat Content**  
   Clean inconsistent values in the `Item_Fat_Content` column (e.g., 'low Fat', 'LF', 'reg') for accurate grouping and analysis.

**Total Sales in Millions**  
   Calculate total sales across all items and convert the result into a readable million-scale format.

**Average and Total Sales Insights**  
   Derive the average sales, total number of items sold, and overall sum of sales.

**Sales Segmentation by Item Fat Content**  
   Compare sales volumes between 'Low Fat' and 'Regular' items.

**Year-wise Sales Analysis**  
   Assess total sales in specific years to observe growth trends or stagnation.

**Granular Insights by Category**  
   Perform group-by analysis across `Item_Fat_Content`, `Item_Type`, and `Outlet_Establishment_Year`.

**Sales by Outlet Type and Location**  
   Understand which outlet locations and outlet types contribute most to revenue.

**Pivot Tables for Comparative Analysis**  
   Use SQL pivoting to compare sales and average sales by `Outlet_Location_Type` and `Item_Fat_Content`.

**Sales Percentage Distribution**  
   Analyze what percentage each outlet size, location, and type contributes to overall sales.

## Business Insights

- **Product Demand:**  
  Standardized product labels help identify customer preferences, improving inventory management and marketing focus.

- **Top Categories:**  
  Analysis of sales highlights the most profitable products, guiding promotional efforts and resource allocation.

- **Seasonal Trends:**  
  Monthly and yearly sales data reveal seasonal patterns, enabling better stock planning and campaign timing.

- **Store & Regional Performance:**  
  Sales analyzed by store type, location, and city tier identify high-performing formats and regions, supporting targeted strategies.

- **Customer Ratings:**  
  Average ratings provide insights into customer satisfaction and areas needing improvement.
