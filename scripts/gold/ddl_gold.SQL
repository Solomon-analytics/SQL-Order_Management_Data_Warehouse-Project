-- ==================================================================
-- Create Gold Layer Database views
-- ==================================================================
Script purpose:
This script creates a database which will store the gold tables in
a view. The gold layer represent the final dimension and fact tables.

Ech view performs transformations and combines data from the silver
layer views to produce a clean, enriched, and business-ready dataset.
-- ===================================================================

CREATE DATABASE gold_sales_order_management;


-- ==============================================================
-- Customer Dimension (gold_dim_customers)
-- customer profile attributes
-- ==============================================================
DROP VIEW IF EXISTS gold_dim_customers;
CREATE VIEW gold_dim_customers AS
SELECT 
CONCAT(ROW_NUMBER() OVER (ORDER BY customer_id), '-', customer_id) AS customer_key,
    customer_id,
    customer_full_name,
    customer_address,
    customer_state,
    customer_country,
    customer_postcode,
    customer_age,
    gender AS customer_gender,
CASE
    WHEN customer_id IS NULL OR customer_full_name IS NULL 
	  THEN 'Invalid' ELSE 'Valid' END AS dq_record_status, ## Data Quality Flag
NOW() AS etl_load_timestamp,
    'gold_dim_customers' AS etl_source ## ETL Metadata
FROM silver_sales_order_management.customer_silver_layer;


-- ==============================================================
-- Product Dimension (gold_dim_products)
-- product attributes
-- ==============================================================
DROP VIEW IF EXISTS gold_dim_products;
CREATE VIEW gold_dim_products AS
SELECT 
CONCAT(ROW_NUMBER() OVER (ORDER BY product_id), '-', product_id) AS product_key,
    product_id,
    product_name,
    product_category,
    product_number,
    product_price_usd,
CASE
    WHEN product_id IS NULL OR product_name IS NULL 
	  THEN 'Invalid' ELSE 'Valid' END AS dq_record_status,
NOW() AS etl_load_timestamp,
    'gold_dim_products' AS etl_source
FROM silver_sales_order_management.product_silver_layer;


-- ==============================================================
-- Store-Product Fact (gold_fact_store_products)
-- Inventory position, stock replenish flags, and store info
-- ==============================================================
DROP VIEW IF EXISTS gold_fact_store_products;
CREATE VIEW gold_fact_store_products AS
WITH base_inventory AS (
    SELECT
        SP.store_location_id,
        SP.product_id,
        COALESCE(SP.available_quantity, 0) AS available_quantity,
        COALESCE(SP.blocked_quantity, 0) AS blocked_quantity,
        COALESCE(SP.blocked_quantity, 0) AS reserved_inventory,
        (COALESCE(SP.available_quantity, 0) - COALESCE(SP.blocked_quantity, 0)) AS unreserved_inventory,
        s.store_address,
        s.store_city,
        s.store_country,
        s.store_postcode,
        CASE WHEN COALESCE(SP.available_quantity, 0) < 20 THEN 'Y' ELSE 'N' END AS stock_replenish_flag
    FROM silver_sales_order_management.store_product_silver_layer SP
    INNER JOIN silver_sales_order_management.store_silver_layer s
        ON SP.store_location_id = s.store_location_id
)
SELECT
*,
CONCAT(product_id, '-', store_location_id) AS store_product_key,
    CASE
		    WHEN product_id IS NULL OR store_location_id IS NULL THEN 'Invalid' ELSE 'Valid' END AS dq_record_status,
	NOW() AS etl_load_timestamp,
    'gold_fact_store_products' AS etl_source
FROM base_inventory;


-- ==============================================================
-- Store Dimension (gold_dim_store)
-- store details
-- ==============================================================
DROP VIEW IF EXISTS gold_dim_store;
CREATE VIEW gold_dim_store AS
SELECT 
    CONCAT(ROW_NUMBER() OVER (ORDER BY store_location_id), '-', store_location_id) AS store_key,
    store_location_id,
    store_address,
    store_city,
    store_country,
    store_postcode,
CASE
    WHEN store_location_id IS NULL OR store_address IS NULL THEN 'Invalid' ELSE 'Valid' END AS dq_record_status,
    NOW() AS etl_load_timestamp,
    'gold_dim_store' AS etl_source
FROM silver_sales_order_management.store_silver_layer;


-- ==============================================================
-- Sales Person Dimension (gold_dim_sales_person)
-- Sales representative details
-- ==============================================================
DROP VIEW IF EXISTS gold_dim_sales_person;
CREATE VIEW gold_dim_sales_person AS
SELECT 
    CONCAT(sp.sales_person_id, '-', sp.store_location_id) AS sales_person_key,
    sp.sales_person_id,
    sp.store_location_id,
    sp.sales_person_full_name AS sales_rep_name,
    CASE 
        WHEN is_manager = 1 THEN 'Yes'
        WHEN is_manager = 0 THEN 'No'
        ELSE 'Unknown' 
    END AS manager_flag,
    sp.sales_person_salary_usd AS sales_rep_salary,
    s.store_address,
    s.store_city,
    s.store_country,
    s.store_postcode,

    CASE
        WHEN sales_person_id IS NULL OR sales_person_full_name IS NULL THEN 'Invalid' ELSE 'Valid' END AS dq_record_status,
    NOW() AS etl_load_timestamp,
    'gold_dim_sales_person' AS etl_source
FROM silver_sales_order_management.sales_person_silver_layer sp
INNER JOIN silver_sales_order_management.store_silver_layer s 
    ON s.store_location_id = sp.store_location_id;


-- ==============================================================
-- Sales Order Fact (gold_fact_sales_order_details)
-- order details
-- ==============================================================
DROP VIEW IF EXISTS gold_fact_sales_order_details;
CREATE VIEW gold_fact_sales_order AS
WITH base_orders AS (
    SELECT 
        so.order_id,
        so.product_id,
        so.store_location_id,
        so.customer_id,
        so.sales_person_id,
        so.order_number,
        so.order_line_status,
        COALESCE(so.ordered_quantity, 0) AS ordered_quantity,
        COALESCE(so.cancelled_quantity, 0) AS cancelled_quantity,
        COALESCE(so.returned_quantity,0) AS returned_quantity,
        (COALESCE(so.ordered_quantity, 0) 
          - (COALESCE(so.cancelled_quantity, 0) + COALESCE(so.returned_quantity,0))) AS actual_ordered_quantity,
        sp.product_price_usd,
        (COALESCE(so.ordered_quantity, 0) * sp.product_price_usd) AS order_value_usd,
        so.customer_request_date,
        so.actual_shipment_date AS ship_date,
        so.order_creation_date,
        so.payment_method,
        so.product_number,
        so.invoice_number,
        so.sales_person_name AS sales_rep_name,
        c.customer_full_name AS customer_name,
        sp.product_name,
        sp.product_category,
        s.store_address,
        s.store_city,
        s.store_country,
        s.store_postcode
    FROM silver_sales_order_management.sales_details_silver__layer so
    LEFT JOIN silver_sales_order_management.customer_silver_layer c 
        ON c.customer_id = so.customer_id
    LEFT JOIN silver_sales_order_management.store_silver_layer s 
        ON s.store_location_id = so.store_location_id
    LEFT JOIN silver_sales_order_management.product_silver_layer sp 
        ON sp.product_id = so.product_id
)
SELECT
 *,
    CONCAT(order_id, '-', product_id, '-', store_location_id) AS sales_order_key,
    CASE
		    WHEN customer_id IS NULL OR product_id IS NULL OR order_id IS NULL THEN 'Invalid' ELSE 'Valid' END AS dq_record_status,
    NOW() AS etl_load_timestamp,
    'gold_fact_sales_order' AS etl_source
FROM base_orders;


-- ==============================================================
-- Shipment Fact (gold_fact_order_ship_details)
-- Shipments, deliveries, and customer/store ship details
-- ==============================================================
DROP VIEW IF EXISTS gold_fact_order_ship_details;
CREATE VIEW gold_fact_order_ship AS
WITH base_shipments AS (
    SELECT 
        so.order_id,
        so.ship_id,
        so.product_id,
        so.store_location_id,
        so.delivery_status,
        so.customer_id,
        so.delivery_number,
        so.delivery_type,
        COALESCE(so.cancelled_quantity, 0) AS cancelled_quantity,
        COALESCE(so.shipped_quantity, 0) AS shipped_quantity,
        COALESCE(so.delivered_quantity, 0) AS delivered_quantity,
        so.delivery_date,
        so.ship_date,
        so.shipping_method,
        so.carrier_type,
        so.tracking_number,
        c.customer_full_name AS customer_name,
        c.customer_address AS ship_to_address,
        c.customer_state AS ship_to_state,
        c.customer_country AS ship_to_country,
        c.customer_postcode AS ship_to_postcode,
        s.store_address AS ship_from_address,
        s.store_city AS ship_from_city,
        s.store_country AS ship_from_country,
        s.store_postcode AS ship_from_postcode
    FROM silver_sales_order_management.order_ship_silver_layer so
    INNER JOIN silver_sales_order_management.customer_silver_layer c 
        ON c.customer_id = so.customer_id
    INNER JOIN silver_sales_order_management.store_silver_layer s 
        ON s.store_location_id = so.store_location_id
)
SELECT
*,
    CONCAT(order_id, '-', ship_id, '-', product_id) AS ship_order_key,
    
    CASE 
        WHEN order_id IS NULL OR product_id IS NULL OR ship_id IS NULL 
        THEN 'Invalid' ELSE 'Valid' END AS dq_record_status,
    NOW() AS etl_load_timestamp,
    'gold_fact_order_ship' AS etl_source
FROM base_shipments;

---

