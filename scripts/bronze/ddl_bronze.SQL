/*
======================================================================================================================================
DDL Script: Create Bronze Schema and tables
======================================================================================================================================
Script Purpose:
   This script creates a database and tables in the 'bronze' schema, dropping existing tables if they already exists
======================================================================================================================================
*/

DROP SCHEMA IF EXISTS bronze_sales_order_management;

CREATE SCHEMA IF NOT EXISTS bronze_sales_order_management;

DROP TABLE IF EXISTS bronze_pos_customer_info;
CREATE TABLE IF NOT EXISTS bronze_pos_customer_info (
id CHAR(50),
    status CHAR(10),
    names varchar(30),
    address VARCHAR(255),
    email VARCHAR(255),
    gender CHAR(10),
    Age INT,
    PRIMARY KEY(id)
);


DROP TABLE IF EXISTS bronze_erp_customer_info;
CREATE TABLE IF NOT EXISTS bronze_erp_customer_info (
id CHAR(50),
    status CHAR(10),
    names varchar(30),
    address VARCHAR(255),
    email VARCHAR(255),
    gender CHAR(10),
    Age INT,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS bronze_erp_product_info;
CREATE TABLE IF NOT EXISTS bronze_erp_product_info(
product_id VARCHAR(255),
    product_name VARCHAR(255) NOT NULL,
    store_location_name VARCHAR(255),
    product_number VARCHAR(255),
    product_height_weight VARCHAR(255),
    product_length_width VARCHAR(255),
    avg_product_cost INT,
    product_creation_date_id VARCHAR(255),
    product_price VARCHAR(255),
    PRIMARY KEY(product_id)
);


DROP TABLE IF EXISTS bronze_pos_product_info;
CREATE TABLE IF NOT EXISTS bronze_pos_product_info(
product_id VARCHAR(255),
    product_name VARCHAR(255) NOT NULL,
    store_location_name VARCHAR(255),
    product_number VARCHAR(255),
    product_height_weight VARCHAR(255),
    product_length_width VARCHAR(255),
    avg_product_cost INT,
    product_creation_date_id VARCHAR(255),
    product_price VARCHAR(255),
    PRIMARY KEY(product_id)
);

DROP TABLE IF EXISTS bronze_pos_store_info;
CREATE TABLE IF NOT EXISTS bronze_pos_store_info(
Store_Location_id VARCHAR(10),
store_location_address VARCHAR(100)
);

DROP TABLE IF EXISTS bronze_erp_store_info;
CREATE TABLE IF NOT EXISTS bronze_erp_store_info
(
Store_Location_id VARCHAR(30),
store_location_address VARCHAR(100)
);

DROP TABLE IF EXISTS bronze_pos_Store_products_info;
CREATE TABLE IF NOT EXISTS bronze_pos_Store_products_info(
store_location_id VARCHAR(50), 
product_id VARCHAR(50), 
available_quantity varchar(15), 
blocked_quantity varchar(15), 
received_date_id varchar(15));

DROP TABLE IF EXISTS bronze_erp_Store_products_info;
CREATE TABLE IF NOT EXISTS bronze_erp_Store_products_info(
store_location_id VARCHAR(50), 
product_id VARCHAR(50), 
available_quantity varchar(15), 
blocked_quantity varchar(15), 
received_date_id varchar(15));

DROP TABLE IF EXISTS bronze_erp_sales_person_info;
CREATE TABLE IF NOT EXISTS bronze_erp_sales_person_info(
sales_person_id VARCHAR(255),
    store_location_id VARCHAR(255),
    sales_person_name VARCHAR(255),
    sales_person_full_name VARCHAR(255),
    hire_date_id VARCHAR(30),
    is_manager BOOLEAN,
    salary VARCHAR(20)
);

DROP TABLE IF EXISTS bronze_pos_sales_person_info;
CREATE TABLE IF NOT EXISTS bronze_pos_sales_person_info(
sales_person_id VARCHAR(255),
    store_location_id VARCHAR(255),
    sales_person_name VARCHAR(255),
    sales_person_full_name VARCHAR(255),
    hire_date_id VARCHAR(30),
    is_manager BOOLEAN,
    salary VARCHAR(20)
);


DROP TABLE IF EXISTS bronze_pos_sales_details;
CREATE TABLE IF NOT EXISTS bronze_pos_sales_details(
order_id VARCHAR(255),
    product_id VARCHAR(255),
    store_location_id VARCHAR(255),
    customer_id VARCHAR(255),
    sales_person_id VARCHAR(255),
    order_number VARCHAR(30),
    order_line_status VARCHAR(255),
    discount_amount VARCHAR(30),
    ordered_quantity VARCHAR(30),
    cancelled_quantity VARCHAR(30),
    returned_quantity VARCHAR(30),
    shipping_cost VARCHAR(30),
    customer_request_dateid VARCHAR(255),
    actual_shipment_dateid VARCHAR(255),
    payment_method VARCHAR(20),
    Order_Creation_date_id VARCHAR(255),
    product_number VARCHAR(255),
    invoice_number VARCHAR(255),
    sales_person_full_name VARCHAR(255)
);


DROP TABLE IF EXISTS bronze_erp_sales_details;
CREATE TABLE IF NOT EXISTS bronze_erp_sales_details(
order_id VARCHAR(255),
    product_id VARCHAR(255),
    store_location_id VARCHAR(255),
    customer_id VARCHAR(255),
    sales_person_id VARCHAR(255),
    order_number VARCHAR(30),
    order_line_status VARCHAR(255),
    discount_amount VARCHAR(30),
    ordered_quantity VARCHAR(30),
    cancelled_quantity VARCHAR(30),
    returned_quantity VARCHAR(30),
    shipping_cost VARCHAR(30),
    customer_request_dateid VARCHAR(255),
    actual_shipment_dateid VARCHAR(255),
    payment_method VARCHAR(20),
    Order_Creation_date_id VARCHAR(255),
    product_number VARCHAR(255),
    invoice_number VARCHAR(255),
    sales_person_full_name VARCHAR(255)
);


DROP TABLE IF EXISTS bronze_erp_ship_details;
CREATE TABLE IF NOT EXISTS bronze_erp_ship_details(
order_id VARCHAR(255),
    ship_id VARCHAR(255),
    product_id VARCHAR(255),
    store_location_id VARCHAR(255),
    delivery_status VARCHAR(255),
    customer_id VARCHAR(255),
    delivery_number VARCHAR(255),
    delivery_type VARCHAR(255),
    cancelled_quantity VARCHAR(30),
    shipped_quantity VARCHAR(30),
    delivered_quantity VARCHAR(30),
    delivery_dateid VARCHAR(30),
    ship_date_id VARCHAR(30),
    shipping_method VARCHAR(25),
    carrier VARCHAR(25),
    tracking_number VARCHAR(255)
);


DROP TABLE IF EXISTS bronze_pos_ship_details;
CREATE TABLE IF NOT EXISTS bronze_pos_ship_details(
order_id VARCHAR(255),
    ship_id VARCHAR(255),
    product_id VARCHAR(255),
    store_location_id VARCHAR(255),
    delivery_status VARCHAR(255),
    customer_id VARCHAR(255),
    delivery_number INT,
    delivery_type VARCHAR(255),
    cancelled_quantity VARCHAR(30),
    shipped_quantity VARCHAR(30),
    delivered_quantity VARCHAR(30),
    delivery_dateid VARCHAR(30),
    ship_date_id VARCHAR(30),
    shipping_method VARCHAR(25),
    carrier VARCHAR(25),
    tracking_number VARCHAR(255)
);

