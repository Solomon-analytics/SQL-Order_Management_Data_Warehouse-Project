-- =======================================================================================================
SELECT '================== Loading Bronze Layer ==================';
-- =======================================================================================================
Script Purpose:
     This scripts load data into the 'bronze' schema from external csv files.
     It performs the following action:
     - checks and calculate the time it takes to load each csv into the specified tables.
     - Uses 'Load Data Infile' command to load data from csv files to each of the bronze tables.
-- -------------------------------------------------------------------------------------------------------
SELECT '---------------------- Loading ERP Tables ----------------';
-- -------------------------------------------------------------------------------------------------------

-- Bronze ERP Customer Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/Customer_ERP.csv'
INTO TABLE bronze_erp_customer_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_erp_customer_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze ERP Product Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/products_ERP.csv'
INTO TABLE bronze_erp_product_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_erp_product_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze ERP Store Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/store_erp.csv'
INTO TABLE bronze_erp_store_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_erp_store_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze ERP Store Products Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/Store_products_erp.csv'
INTO TABLE bronze_erp_store_products_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_erp_store_products_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze ERP Sales Person Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/sales_person.csv'
INTO TABLE bronze_erp_sales_person_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_erp_sales_person_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze ERP Sales Details
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/sales_orders_erp.csv'
INTO TABLE bronze_erp_sales_details
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_erp_sales_details Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze ERP Ship Details
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/ship_erp.csv'
INTO TABLE bronze_erp_ship_details
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_erp_ship_details Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;


-- --------------------------------------------------------------------------------------------------------
SELECT '---------------------- Loading POS Tables ----------------;
-- --------------------------------------------------------------------------------------------------------

-- Bronze POS Customer Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/Customer_CRM.csv'
INTO TABLE bronze_crm_customer_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_crm_customer_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze POS Product Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/products_crm.csv'
INTO TABLE bronze_crm_product_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_crm_product_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze POS Store Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/store_crm.csv'
INTO TABLE bronze_crm_store_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_crm_store_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze POS Store Products Info
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/Store_products_crm.csv'
INTO TABLE bronze_crm_store_products_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_crm_store_products_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze POS Sales Details
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/sales_orders_crm.csv'
INTO TABLE bronze_crm_sales_details
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_crm_sales_details Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- Bronze POS Ship Details
SET @start_time = NOW();
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/ship_crm.csv'
INTO TABLE bronze_crm_ship_details
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET @end_time = NOW();
SELECT CONCAT('bronze_crm_ship_details Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS msg;

-- ==================================================================================
SELECT 'Loading Bronze Layer Completed';
-- ==================================================================================
