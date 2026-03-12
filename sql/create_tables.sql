CREATE TABLE dimensional_dw.dim_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM relational_dw.customers;
----------------------------------------------------------------------------------------------
CREATE TABLE dimensional_dw.dim_products AS
SELECT
    p.product_id,
    p.product_category_name,
    t.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM relational_dw.products p
LEFT JOIN relational_dw.product_category_translation t
ON p.product_category_name = t.product_category_name;
----------------------------------------------------------------------------------------------
CREATE TABLE dimensional_dw.dim_sellers AS
SELECT
    seller_id,
    seller_city,
    seller_state
FROM relational_dw.sellers;
----------------------------------------------------------------------------------------------
CREATE TABLE dimensional_dw.dim_date AS
SELECT DISTINCT
    DATE(order_purchase_timestamp) AS date,
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    EXTRACT(DAY FROM order_purchase_timestamp) AS day,
    TO_CHAR(order_purchase_timestamp, 'Month') AS month_name
FROM relational_dw.orders;
----------------------------------------------------------------------------------------------
CREATE TABLE dimensional_dw.fact_orders AS
SELECT
    oi.order_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    DATE(o.order_purchase_timestamp) AS order_date,
    oi.price,
    oi.freight_value,
    op.payment_value,
    r.review_score
FROM relational_dw.order_items oi
JOIN relational_dw.orders o
    ON oi.order_id = o.order_id
LEFT JOIN relational_dw.order_payments op
    ON oi.order_id = op.order_id
LEFT JOIN relational_dw.order_reviews r
    ON oi.order_id = r.order_id;
----------------------------------------------------------------------------------------------
CREATE INDEX idx_fact_orders_date ON dimensional_dw.fact_orders(order_date);
CREATE INDEX idx_fact_orders_customer ON dimensional_dw.fact_orders(customer_id);
CREATE INDEX idx_fact_orders_product ON dimensional_dw.fact_orders(product_id);
