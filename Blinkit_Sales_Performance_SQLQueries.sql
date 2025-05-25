-- 1. Data Cleaning

--viewing all the data using a simple SELECT statement:
SELECT * FROM Blinkit_data

--After looking at 'Item Fat Content', we noticed inconsistent labels like 'low Fat', 'LF', and 'reg'. These need to be standardized.
UPDATE Blinkit_data 
SET Item_Fat_Content = 
CASE  
    WHEN Item_Fat_Content IN ('low Fat', 'LF') THEN 'Low Fat' 
    WHEN Item_Fat_Content IN ('reg') THEN 'Regular' 
    ELSE Item_Fat_Content 
END;

--After cleaning, we check distinct values to ensure data consistency.
SELECT DISTINCT(Item_Fat_Content) FROM Blinkit_data

--2. KPI Calculations

--Total Sum of Sales:-
SELECT SUM(Sales) AS TOTAL_SALES 
FROM Blinkit_data

--Total Sales in Millions:-
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS TOTAL_SALES_IN_MILLIONS 
FROM Blinkit_data

--Average Sales:-
SELECT CAST(AVG(Sales) AS DECIMAL(10,0)) AS AVERAGE_OF_SALES 
FROM Blinkit_data

--Total Number of Items:-
SELECT COUNT(*) AS No_of_Items 
FROM Blinkit_data

--Sales by Fat Content:-
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS TOTAL_SALES_IN_MILLIONS_LF 
FROM Blinkit_data 
WHERE Item_Fat_Content = 'Low Fat'

SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS TOTAL_SALES_IN_MILLIONS_RF 
FROM Blinkit_data 
WHERE Item_Fat_Content = 'Regular'

--Average Rating:-
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Total_Rating 
FROM Blinkit_data

--Sales in Year 2022:-
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS TOTAL_SALES_IN_MILLIONS 
FROM Blinkit_data 
WHERE Outlet_Establishment_Year = 2022

--Granular Analysis
--Grouped by Fat Content:-
SELECT Item_Fat_Content,  
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
GROUP BY Item_Fat_Content 
ORDER BY Totals_Sales DESC

--Grouped by Fat Content for Year 2022:-
SELECT Item_Fat_Content,  
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
WHERE Outlet_Establishment_Year = 2022 
GROUP BY Item_Fat_Content 
ORDER BY Totals_Sales DESC

-- Grouped by Fat Content for Year 2020:-
SELECT Item_Fat_Content,  
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
WHERE Outlet_Establishment_Year = 2020 
GROUP BY Item_Fat_Content 
ORDER BY Totals_Sales DESC

--Total Sales by Item Type:-
SELECT Item_Type,  
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
GROUP BY Item_Type 
ORDER BY Totals_Sales DESC

--Sales by Outlet Establishment Year:-
SELECT Outlet_Establishment_Year, 
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
GROUP BY Outlet_Establishment_Year 
ORDER BY Outlet_Establishment_Year ASC

--Sales by Location and Fat Content:-
SELECT Outlet_Location_Type, Item_Fat_Content,   
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
GROUP BY Outlet_Location_Type, Item_Fat_Content  
ORDER BY Totals_Sales DESC

--Pivot Table: Total Sales by Fat and Location (Tier-wise):-
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular 
FROM (
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales 
    FROM Blinkit_data 
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT (
    SUM(Totals_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable 
ORDER BY Outlet_Location_Type

--Pivot Table: Average Sales by Fat and Location:-
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular 
FROM (
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(AVG(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
           CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
    FROM Blinkit_data 
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT (
    AVG(Totals_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable 
ORDER BY Outlet_Location_Type

--Sales % by Outlet Attributes:-
--By Outlet Size-
SELECT Outlet_Size, 
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST((SUM(Sales)*100.0/SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Precentage 
FROM Blinkit_data 
GROUP BY Outlet_Size 
ORDER BY Totals_Sales DESC

--By Outlet Location-
SELECT Outlet_Location_Type,   
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST((SUM(Sales)*100.0/SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Precentage, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
GROUP BY Outlet_Location_Type 
ORDER BY Totals_Sales DESC

--By Outlet Type-
SELECT Outlet_Type,   
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Totals_Sales, 
       CAST((SUM(Sales)*100.0/SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Precentage, 
       CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales, 
       COUNT(*) AS No_of_Items, 
       CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Ratings 
FROM Blinkit_data 
GROUP BY Outlet_Type 
ORDER BY Totals_Sales DESC