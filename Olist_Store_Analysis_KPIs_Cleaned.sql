-- ============================================================
-- OLIST E-COMMERCE STORE ANALYSIS
-- SQL KPI ANALYSIS
-- Database: olist_store
-- SQL Dialect: MySQL 8+
-- ============================================================

USE olist_store;

-- ============================================================
-- KPI 1: Weekday vs Weekend Payment Statistics
-- ============================================================

SELECT
    CASE
        WHEN DAYOFWEEK(o.order_purchase_timestamp) IN (1, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(DISTINCT o.order_id) AS distinct_orders,
    COUNT(p.payment_value) AS payment_records,
    ROUND(AVG(p.payment_value), 2) AS average_payment_value,
    ROUND(SUM(p.payment_value), 2) AS total_payment_value
FROM olist_orders_dataset AS o
JOIN olist_order_payments_dataset AS p
    ON o.order_id = p.order_id
GROUP BY day_type
ORDER BY day_type;

-- Finding:
-- Weekday orders represent the larger share of order volume,
-- while average payment value is relatively similar across
-- weekdays and weekends.
--
-- Recommendation:
-- Focus operational capacity on higher-volume weekdays and
-- test weekend promotions to increase weekend demand.


-- ============================================================
-- KPI 2: 5-Star Reviews + Credit Card Payment
-- ============================================================

SELECT
    COUNT(DISTINCT r.order_id) AS matching_orders
FROM olist_order_reviews_dataset AS r
JOIN olist_order_payments_dataset AS p
    ON r.order_id = p.order_id
WHERE r.review_score = 5
  AND p.payment_type = 'credit_card';

-- Finding:
-- 43,981 distinct orders had both a 5-star review and
-- credit-card payment.
--
-- Recommendation:
-- Maintain a fast and reliable credit-card checkout experience
-- and investigate whether other payment methods create friction.


-- ============================================================
-- KPI 3: Average Delivery Days for Pet-Shop Orders
-- ============================================================

SELECT
    ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM (
    SELECT DISTINCT
        o.order_id,
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        ) AS delivery_days
    FROM olist_orders_dataset AS o
    JOIN olist_order_items_dataset AS oi
        ON o.order_id = oi.order_id
    JOIN olist_products_dataset AS p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name = 'pet_shop'
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_purchase_timestamp IS NOT NULL
) AS pet_orders;

-- Finding:
-- Average delivery time for pet-shop orders is approximately
-- 11.31 days.
--
-- Recommendation:
-- Investigate seller location, customer location, logistics
-- partners, and shipping routes to identify opportunities
-- to reduce delivery time.


-- ============================================================
-- KPI 4: Average Product Price vs Payment Value
--         for São Paulo Customers
-- ============================================================

WITH item_avg AS (
    SELECT
        order_id,
        AVG(price) AS avg_price
    FROM olist_order_items_dataset
    GROUP BY order_id
),
payment_avg AS (
    SELECT
        order_id,
        AVG(payment_value) AS avg_payment
    FROM olist_order_payments_dataset
    GROUP BY order_id
)
SELECT
    ROUND(AVG(i.avg_price), 2) AS average_product_price,
    ROUND(AVG(p.avg_payment), 2) AS average_payment_value
FROM olist_customers_dataset AS c
JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
JOIN item_avg AS i
    ON o.order_id = i.order_id
JOIN payment_avg AS p
    ON o.order_id = p.order_id
WHERE LOWER(c.customer_city) = 'sao paulo';

-- Finding:
-- The source project reports an average product price of 112.58
-- and an average payment value of 138.74 for São Paulo customers.
--
-- Note:
-- These metrics measure different concepts: product price is
-- item-level, while payment value is order-payment-level and
-- can include freight or multiple products.
--
-- Recommendation:
-- Analyze product price, freight, and order payment value
-- together when evaluating transaction value.


-- ============================================================
-- KPI 5: Delivery Days vs Review Score
-- ============================================================

SELECT
    r.review_score,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS average_delivery_days
FROM olist_orders_dataset AS o
JOIN olist_order_reviews_dataset AS r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp IS NOT NULL
  AND r.review_score IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score;

-- Purpose:
-- Compare delivery duration with review score to identify
-- whether slower delivery is associated with lower customer
-- satisfaction.


-- ============================================================
-- PROJECT ANALYSIS NOTES
-- ============================================================

-- Customer and order analysis:
-- Customer orders, order status, delivery information,
-- payments, products, sellers, and reviews are analyzed
-- using customer_id and order_id relationships.

-- Order status:
-- Orders include statuses such as delivered, shipped,
-- canceled, invoiced, and processing.
-- Delivered orders are most useful for delivery and review analysis.

-- Delivery analysis:
-- Delivery days are calculated using:
-- DATEDIFF(order_delivered_customer_date,
--          order_purchase_timestamp)

-- Review analysis:
-- Review scores range from 1 to 5 and can be compared
-- with delivery duration to study customer satisfaction.

-- Payment analysis:
-- Payment types include credit_card, boleto, voucher,
-- and debit_card. Payment volume and payment value can
-- be analyzed at order level.

-- Product analysis:
-- Product categories, prices, freight values, and product
-- characteristics can be analyzed to identify important
-- product segments.

-- Seller analysis:
-- Seller information can be combined with orders and products
-- to evaluate seller performance, sales, and delivery metrics.

-- ============================================================
-- END OF OLIST SQL KPI ANALYSIS
-- ============================================================
