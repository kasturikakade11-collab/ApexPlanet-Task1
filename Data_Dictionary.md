# Data Dictionary

| Column Name   | Data Type | Description                                      | Business Relevance                                      |
| ------------- | --------- | ------------------------------------------------ | ------------------------------------------------------- |
| Order_ID      | TEXT      | Unique identifier assigned to each order         | Helps track and manage customer orders                  |
| Order_Date    | DATE      | Date when the order was placed                   | Useful for sales trend and time-based analysis          |
| Customer_ID   | TEXT      | Unique identifier assigned to each customer      | Helps analyze customer behavior and purchasing patterns |
| Customer_Name | TEXT      | Name of the customer                             | Used for customer records and reporting                 |
| Age           | INT       | Age of the customer                              | Useful for demographic analysis                         |
| Gender        | TEXT      | Gender of the customer                           | Helps understand customer demographics                  |
| City          | TEXT      | City of the customer                             | Useful for location-based sales analysis                |
| Product       | TEXT      | Product purchased by the customer                | Helps identify popular products                         |
| Category      | TEXT      | Category to which the product belongs            | Useful for category-wise sales analysis                 |
| Quantity      | INT       | Number of units purchased                        | Helps measure product demand                            |
| Unit_Price    | DECIMAL   | Price of one unit of the product                 | Useful for pricing analysis                             |
| Total_Sales   | DECIMAL   | Total transaction amount (Quantity × Unit Price) | Key metric for revenue analysis                         |

## Data Cleaning Summary

* Checked for missing values.
* Found and handled missing values in the City column.
* Investigated duplicate Order_ID values.
* Verified that duplicate Order_IDs represented different transactions and were retained.
* Standardized data for analysis.
* Performed feature engineering.
* Prepared the dataset for analysis.
