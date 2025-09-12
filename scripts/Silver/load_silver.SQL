/*
=========================================================================
Load Silver Layer (Bronze --> silver)
=========================================================================
Script purpose:
  This script populates the silver database tables from the bzonze database
  using the each of the views created in the bronze database.
Action performed:
- Drop table if it exists in the database
- Inserts transformed and cleansed data from Views stored in the Bronze databse into
each of the tables in the silver database.


Views stored in the Bronze database:
bronze_sales_order_management.staging_crm_customer
bronze_sales_order_management.staging_erp_customer
bronze_sales_order_management.staging_crm_product;
bronze_sales_order_management.staging_erp_product;
bronze_sales_order_management.staging_crm_store_product;
bronze_sales_order_management.staging_erp_store_product;
bronze_sales_order_management.staging_crm_store;
bronze_sales_order_management.staging_erp_store;
bronze_sales_order_management.staging_erp_sales_person;
bronze_sales_order_management.staging_crm_ship_details;
bronze_sales_order_management.staging_erp_ship_details;
bronze_sales_order_management.staging_crm_sales_details;
bronze_sales_order_management.staging_erp_sales_details;



-------------------------------------------------------------
-- Customer Silver Layer: Consolidating ERP & CRM Customers
-------------------------------------------------------------

DROP TABLE IF EXISTS Customer_silver_layer;
CREATE TABLE IF NOT EXISTS Customer_silver_layer (
    Customer_id VARCHAR(20) PRIMARY KEY,
    Customer_Status CHAR(1),
    Customer_Full_Name VARCHAR(100),
    Customer_Address VARCHAR(255),
    Customer_Country VARCHAR(50),
    Customer_Postcode VARCHAR(20),
    Customer_State VARCHAR(30),
    Customer_Email VARCHAR(255),
    Gender VARCHAR(10),
    Customer_Age INT,
    Creation_Date DATETIME DEFAULT NOW(),
    Data_Quality_flag VARCHAR(20)
);

INSERT INTO Customer_silver_layer 
SELECT *
FROM bronze_sales_order_management.staging_erp_customer
UNION 
SELECT *
FROM bronze_sales_order_management.staging_crm_customer;


-------------------------------------------------------------
-- Product Silver Layer: Consolidating ERP & CRM Products
-------------------------------------------------------------

DROP TABLE IF EXISTS Product_Silver_layer;
CREATE TABLE IF NOT EXISTS Product_Silver_layer (
    product_id VARCHAR(25) PRIMARY KEY,
    Product_Name VARCHAR(100),
    product_Category VARCHAR(100),
    Product_Number VARCHAR(30),
    Product_Price_USD INT,
    Creation_Date DATETIME DEFAULT NOW()
);

INSERT INTO Product_Silver_layer
SELECT *
FROM bronze_sales_order_management.staging_erp_product
UNION
SELECT *
FROM bronze_sales_order_management.staging_crm_product;


-------------------------------------------------------------
-- Store Product Silver Layer: ERP & CRM Store Inventory
-------------------------------------------------------------

DROP TABLE IF EXISTS store_product_silver_layer;
CREATE TABLE IF NOT EXISTS store_product_silver_layer (
    Store_Location_Id VARCHAR(10),
    product_id VARCHAR(25),
    Available_Quantity INT,
    Blocked_Quantity INT,
    Received_date_id VARCHAR(8),
    FOREIGN KEY (Store_Location_id) REFERENCES Store_silver_layer(store_location_id),
    Creation_Date DATETIME DEFAULT NOW()
);

INSERT INTO store_product_silver_layer
SELECT * 
FROM bronze_sales_order_management.staging_erp_store_product
UNION
SELECT *
FROM bronze_sales_order_management.staging_crm_store_product;


-------------------------------------------------------------
-- Store Silver Layer: Consolidating ERP & CRM Stores
-------------------------------------------------------------

DROP TABLE IF EXISTS Store_silver_layer;
CREATE TABLE IF NOT EXISTS Store_silver_layer (
    Store_Location_Id VARCHAR(10) PRIMARY KEY,
    Store_Address VARCHAR(50),
    Store_City VARCHAR(25),
    Store_Country VARCHAR(25),
    Store_PostCode VARCHAR(15),
    Creation_Date DATETIME DEFAULT NOW()
);

INSERT INTO Store_silver_layer
SELECT * 
FROM bronze_sales_order_management.staging_crm_store
UNION
SELECT *
FROM bronze_sales_order_management.staging_erp_store;


-------------------------------------------------------------
-- Sales Person Silver Layer: ERP Sales Person Data
-------------------------------------------------------------

DROP TABLE IF EXISTS sales_person_silver_layer;
CREATE TABLE IF NOT EXISTS sales_person_silver_layer (
    Sales_Person_Id VARCHAR(25) PRIMARY KEY,
    Store_Location_Id VARCHAR(10),
    Sales_Person_Full_Name VARCHAR(50),
    Is_Manager BOOLEAN,
    Sales_Person_Salary_USD INT,
    FOREIGN KEY (Store_Location_Id) REFERENCES Store_silver_layer(Store_Location_Id),
    Creation_Date DATETIME DEFAULT NOW()
);

INSERT INTO sales_person_silver_layer
SELECT * 
FROM bronze_sales_order_management.staging_erp_sales_person;


-------------------------------------------------------------
-- Order Shipment Silver Layer: ERP & CRM Shipment Data
-------------------------------------------------------------

DROP TABLE IF EXISTS Order_Ship_silver_layer;
CREATE TABLE IF NOT EXISTS Order_Ship_silver_layer (
    Order_id VARCHAR(40),
    Ship_id VARCHAR(40),
    Product_id VARCHAR(40),
    Store_Location_id VARCHAR(15),
    Delivery_Status VARCHAR(20),
    Customer_id VARCHAR(20),
    Delivery_Number CHAR(30),
    Delivery_Type VARCHAR(20),
    Cancelled_Quantity INT,
    Shipped_Quantity INT,
    Delivered_Quantity INT,
    Delivery_dateid CHAR(20),
    Delivery_Date DATE,
    Ship_Date_id CHAR(20),
    Ship_Date DATE,
    Shipping_Method VARCHAR(30),
    Carrier_Type VARCHAR(50),
    TRacking_Number VARCHAR(50),
    FOREIGN KEY (Product_id) REFERENCES Product_Silver_layer(Product_id),
    FOREIGN KEY (Order_id) REFERENCES sales_details_silver__layer(Order_id),
    FOREIGN KEY (Store_Location_id) REFERENCES Store_silver_layer(Store_Location_Id),
    FOREIGN KEY (customer_id) REFERENCES Customer_silver_layer(customer_id),
    Created_Date DATETIME DEFAULT NOW(),
    delivery_ship_data_quality_check VARCHAR(10)
);

INSERT INTO Order_Ship_silver_layer
SELECT * 
FROM bronze_sales_order_management.staging_erp_ship_details
UNION
SELECT * 
FROM bronze_sales_order_management.staging_crm_ship_details;


-------------------------------------------------------------
-- Sales Details Silver Layer: ERP & CRM Sales Orders
-------------------------------------------------------------

DROP TABLE IF EXISTS sales_details_silver__layer;
CREATE TABLE IF NOT EXISTS sales_details_silver__layer (
    Order_id VARCHAR(40) PRIMARY KEY,
    Product_id VARCHAR(40),
    Store_Location_id VARCHAR(15),
    Customer_Id VARCHAR(20),
    Sales_Person_id VARCHAR(20),
    Order_Number CHAR(20),
    Order_Line_Status VARCHAR(30),
    Discount_Amount_USD DECIMAL(12,3),
    Ordered_Quantity INT,
    Cancelled_Quantity INT,
    Returned_Quantity INT,
    Shipping_Cost_USD DECIMAL(12,3),
    Customer_Request_dateid CHAR(10),
    Customer_Request_Date DATE,
    Actual_Shipment_dateid CHAR(10),
    Actual_Shipment_Date DATE,
    Payment_method VARCHAR(30),
    Order_creation_date_id CHAR(10),
    Order_Creation_Date DATE,
    Product_Number VARCHAR(30),
    Invoice_number VARCHAR(30),
    Sales_Person_Name VARCHAR(255),
    FOREIGN KEY (Product_id) REFERENCES Product_Silver_layer(Product_id),
    FOREIGN KEY (Store_Location_id) REFERENCES Store_silver_layer(Store_Location_Id),
    FOREIGN KEY (Sales_Person_id) REFERENCES sales_person_silver_layer(Sales_Person_Id),
    FOREIGN KEY (customer_id) REFERENCES Customer_silver_layer(customer_id),
    Creation_Date DATETIME DEFAULT NOW(),
    order_creation_quality_check VARCHAR(10)
);

INSERT INTO sales_details_silver__layer
SELECT *
FROM bronze_sales_order_management.staging_Crm_sales_details
UNION
SELECT *
FROM bronze_sales_order_management.staging_erp_sales_details;
