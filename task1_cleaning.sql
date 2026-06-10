CREATE DATABASE Task1_Sales;
USE Task1_Sales;
SELECT * FROM sales_dataset;
DESCRIBE sales_dataset;

-- Total Rows
SELECT COUNT(*) AS total_rows
FROM sales_dataset;


-- FIND MISSING VALUES
SELECT
SUM(CASE WHEN Order_ID IS NULL OR Order_ID='' THEN 1 ELSE 0 END) AS missing_order_id,
SUM(CASE WHEN Order_Date IS NULL OR Order_Date='' THEN 1 ELSE 0 END) AS missing_order_date,
SUM(CASE WHEN Customer_ID IS NULL OR Customer_ID='' THEN 1 ELSE 0 END) AS missing_customer_id,
SUM(CASE WHEN Customer_Name IS NULL OR Customer_Name='' THEN 1 ELSE 0 END) AS missing_customer_name,
SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS missing_age,
SUM(CASE WHEN Gender IS NULL OR Gender='' THEN 1 ELSE 0 END) AS missing_gender,
SUM(CASE WHEN City IS NULL OR City='' THEN 1 ELSE 0 END) AS missing_city,
SUM(CASE WHEN Product IS NULL OR Product='' THEN 1 ELSE 0 END) AS missing_product,
SUM(CASE WHEN Category IS NULL OR Category='' THEN 1 ELSE 0 END) AS missing_category,
SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
SUM(CASE WHEN Unit_Price IS NULL THEN 1 ELSE 0 END) AS missing_unit_price,
SUM(CASE WHEN Total_Sales IS NULL THEN 1 ELSE 0 END) AS missing_total_sales
FROM sales_dataset;


-- CHECK DUPLICATES
SELECT Order_ID, COUNT(*) AS duplicate_count
FROM sales_dataset
GROUP BY Order_ID
HAVING COUNT(*) > 1;

SELECT * FROM sales_dataset
WHERE Order_ID IN (
    SELECT Order_ID
    FROM sales_dataset
    GROUP BY Order_ID
    HAVING COUNT(*) > 1)
ORDER BY Order_ID;
-- Duplicate Analysis
-- 7 Order_ID values appeared multiple times.
-- Upon investigation, the records contained different customer IDs, products, dates and sales values.
-- Therefore, they were retained and not removed.

-- EXPLORE CATEGORICAL DATA

SELECT Gender, COUNT(*) AS count
FROM sales_dataset
GROUP BY Gender;

SELECT City, COUNT(*) AS count
FROM sales_dataset
GROUP BY City
ORDER BY count DESC;

SELECT Category, COUNT(*) AS count
FROM sales_dataset
GROUP BY Category
ORDER BY count DESC;

SELECT Product, COUNT(*) AS count
FROM sales_dataset
GROUP BY Product
ORDER BY count DESC;


-- CREATE CLEANED TABLE

CREATE TABLE cleaned_sales_dataset AS
SELECT * FROM sales_dataset;

SET SQL_SAFE_UPDATES = 0;

-- HANDLE MISSING CITY AND REPLACE IT WITH MODE

SELECT City, COUNT(*) AS count
FROM cleaned_sales_dataset
WHERE City IS NOT NULL
GROUP BY City
ORDER BY count DESC
LIMIT 1;

UPDATE cleaned_sales_dataset
SET City = 'Patna'
WHERE City IS NULL;


-- VERIFY NULLS

SELECT SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS null_city
FROM cleaned_sales_dataset;


-- DATE STANDARDIZATION

ALTER TABLE cleaned_sales_dataset
MODIFY COLUMN Order_Date DATE;


-- FEATURE ENGINEERING

ALTER TABLE cleaned_sales_dataset
ADD COLUMN Month_Name VARCHAR(20);

UPDATE cleaned_sales_dataset
SET Month_Name = MONTHNAME(Order_Date);

ALTER TABLE cleaned_sales_dataset
ADD COLUMN Day_Name VARCHAR(20);

UPDATE cleaned_sales_dataset
SET Day_Name = DAYNAME(Order_Date);

ALTER TABLE cleaned_sales_dataset
ADD COLUMN Sales_Category VARCHAR(20);

UPDATE cleaned_sales_dataset
SET Sales_Category =
CASE
    WHEN Total_Sales < 50000 THEN 'Low'
    WHEN Total_Sales < 150000 THEN 'Medium'
    ELSE 'High'
END;


-- OUTLIER CHECK

SELECT
MIN(Total_Sales) AS min_sales,
MAX(Total_Sales) AS max_sales,
AVG(Total_Sales) AS avg_sales
FROM cleaned_sales_dataset;


-- FINAL VALIDATION

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT Customer_ID) AS unique_customers,
COUNT(DISTINCT Product) AS unique_products,
COUNT(DISTINCT Category) AS unique_categories,
MIN(Order_Date) AS earliest_date,
MAX(Order_Date) AS latest_date,
ROUND(MIN(Total_Sales),2) AS min_sales,
ROUND(MAX(Total_Sales),2) AS max_sales,
ROUND(AVG(Total_Sales),2) AS avg_sales
FROM cleaned_sales_dataset;


-- VIEW FINAL DATA

SELECT * FROM cleaned_sales_dataset;