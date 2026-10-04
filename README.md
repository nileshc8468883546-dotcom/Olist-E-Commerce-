Olist E-commerce Data Analysis — SQL

Project Overview

This project analyzes the Olist e-commerce dataset using MySQL and SQL.

The analysis focuses on orders, customers, payments, products, delivery performance, and customer reviews. The goal is to use relational data and SQL queries to calculate business KPIs and identify useful operational insights.

Objectives

Analyze order volume across weekdays and weekends

Analyze payment behavior and payment values

Measure delivery performance for product categories

Compare product price with payment value

Analyze the relationship between delivery duration and customer review scores

Practice business-oriented SQL analysis using multiple related tables

KPIs & Analysis

KPI 1 — Weekday vs Weekend Payment Statistics

Compares weekday and weekend orders using:

Distinct order count

Payment records

Average payment value

Total payment value

Business insight: Weekday orders represent the larger share of order volume, while average payment value is relatively similar across weekdays and weekends.

KPI 2 — 5-Star Reviews + Credit Card Payment

Identifies orders that have both:

A 5-star review

Credit-card payment

The project query reports 43,981 distinct matching orders.

Business recommendation: Maintain a fast and reliable credit-card checkout experience and investigate whether other payment methods create additional friction.

KPI 3 — Average Delivery Days for Pet-Shop Orders

Calculates the average number of days between order purchase and customer delivery for the pet_shop category.

Result: Approximately 11.31 days.

Business recommendation: Investigate seller locations, customer locations, logistics partners, and shipping routes to identify opportunities to reduce delivery time.

KPI 4 — Average Product Price vs Payment Value for São Paulo Customers

Compares average product price with average payment value for customers in São Paulo.

The source project reports:

Average product price: 112.58

Average payment value: 138.74

These metrics represent different concepts: product price is item-level, while payment value is order/payment-level and may include freight or multiple products.

KPI 5 — Delivery Days vs Review Score

Compares average delivery duration with customer review scores from 1 to 5.

The purpose is to identify whether longer delivery duration is associated with lower customer satisfaction.

SQL Techniques Used

SELECT

WHERE

CASE

JOIN

GROUP BY

ORDER BY

COUNT(DISTINCT ...)

AVG()

SUM()

ROUND()

DATEDIFF()

Common Table Expressions (CTEs)

Subqueries

Data filtering

Date/time analysis

KPI calculations

Relational data analysis

Tables Used

The analysis uses relationships between Olist tables including:

olist_orders_dataset

olist_order_items_dataset

olist_products_dataset

olist_order_payments_dataset

olist_order_reviews_dataset

olist_customers_dataset

Key Business Areas

Delivery Performance

Delivery duration is calculated from order purchase timestamp to customer delivery date.

Payment Analysis

Payment types and payment values are analyzed at order/payment level.

Customer Satisfaction

Review scores are compared with delivery performance to understand potential relationships between logistics and customer satisfaction.

Product Analysis

Product categories and prices are used to analyze product-level and order-level metrics.

Tools

MySQL

SQL

MySQL Workbench

GitHub

How to Run

Load the Olist database/schema and data into MySQL.

Select the olist_store database.

Open Olist_Store_Analysis_KPIs_Cleaned.sql.

Run the KPI queries individually or as required.

Review the results in MySQL Workbench.

Note: The SQL file in this repository is a cleaned portfolio analysis file. It does not contain the full raw Olist data dump.

Repository Structure

Olist-E-Commerce/
│
├── Olist_Store_Analysis_KPIs_Cleaned.sql
└── README.md

Project Outcome

This project demonstrates practical SQL skills for data analysis, including joining multiple relational tables, calculating KPIs, performing date-based analysis, and translating query results into business-oriented insights.

Author

Nilesh Sunil Chaudhari

B.Tech — Computer Engineering
P G College of Engineering and Technology
DBATU
