# Data Dictionary for Gold Layer

## Overview

The **Gold Layer** is the business-level data representation, structured to support analytical and reporting use cases.
It consists of **dimension tables** and **fact tables** that capture sales order management business processes: customer, product, store, sales rep, orders, shipments, and inventory.

---

## 1. gold\_dim\_customers

**Purpose**: Stores customer details enriched with demographic and geographic data for analytics.

| Column Name          | Data Type    | Description                                                                           |
| -------------------- | ------------ | --------------------------------------------------------------------------------------|                              
| customer\_key        | VARCHAR(42)  | Surrogate key uniquely identifying each customer record: CONCAT('1','-', customer_id) |
| customer\_id         | VARCHAR(10)  | Unique identifier assign to each customers                                            |
| customer\_full\_name | VARCHAR(100) | Customer’s full name.                                                                 |
| customer\_address    | VARCHAR(255) | Customer’s address.                                                                   |
| customer\_state      | VARCHAR(30)  | Customer’s state of residence.                                                        |
| customer\_country    | VARCHAR(30)  | Customer’s country of residence.                                                      |
| customer\_postcode   | VARCHAR(20)  | Customer’s postal code.                                                               |
| customer\_age        | INT          | Customer’s age (derived from source data).                                            |
| customer\_gender     | VARCHAR(10)  | Customer’s gender.                                                                    |
| dq\_record\_status   | VARCHAR(10)  | Data quality flag (Valid / Invalid).                                                  |
| etl\_load\_timestamp | TIMESTAMP    | ETL load timestamp for audit.                                                         |
| etl\_source          | VARCHAR(50)  | ETL metadata source table name.                                                       |

---

## 2. gold\_dim\_products

**Purpose**: Provides product master data including categories, pricing, and identifiers.

| Column Name          | Data Type     | Description                                                                           |
| -------------------- | ------------- | --------------------------------------------------------------------------------------|
| product\_key         | VARCHAR(42)   | Surrogate key uniquely identifying each product record: concat('1', '-', product_id). |
| product\_id          | VARCHAR(10)   | Natural identifier assigned to each product.                                          |
| product\_name        | VARCHAR(100)  | Product name.                                                                         |
| product\_category    | VARCHAR(50)   | Product category (e.g., Electronics, Apparel).                                        |
| product\_number      | VARCHAR(30)   | Product reference or SKU number.                                                      |
| product\_price\_usd  | DECIMAL(10,2) | Product unit price in USD.                                                            |
| dq\_record\_status   | VARCHAR(10)   | Data quality flag (Valid / Invalid).                                                  |
| etl\_load\_timestamp | TIMESTAMP     | ETL load timestamp for audit.                                                         |
| etl\_source          | VARCHAR(50)   | ETL metadata source table name.                                                       |

---

## 3. gold\_fact\_store\_products

**Purpose**: Captures store-level product inventory positions, including stock availability and replenishment needs.

| Column Name            | Data Type    | Description                                                                        |
| ---------------------- | ------------ | -----------------------------------------------------------------------------------|
| store\_location\_id    | VARCHAR(10)  | Identifier for the store location.                                                 |
| product\_id            | VARCHAR(10)  | Identifier for the product.                                                        |
| available\_quantity    | INT          | Quantity of stock available for sale.                                              |
| blocked\_quantity      | INT          | Quantity of stock blocked/reserved.                                                |
| reserved\_inventory    | INT          | Reserved stock quantity(derived from blocked quantity).                            |
| unreserved\_inventory  | INT          | Available stock not reserved(derived from available quantity).                     |
| store\_address         | VARCHAR(255) | Store address.                                                                     |
| store\_city            | VARCHAR(50)  | Store city.                                                                        |
| store\_country         | VARCHAR(50)  | Store country.                                                                     |
| store\_postcode        | VARCHAR(20)  | Store postal code.                                                                 |
| stock\_replenish\_flag | VARCHAR(1)   | Flag (‘Y’ if stock < 20 units, else ‘N’).                                          |
| store\_product\_key    | VARCHAR(42)  | Surrogate key for store-product record: CONCAT(store_location_id, '-', product_id).|
| dq\_record\_status     | VARCHAR(10)  | Data quality flag (Valid / Invalid).                                               |
| etl\_load\_timestamp   | TIMESTAMP    | ETL load timestamp.                                                                |
| etl\_source            | VARCHAR(50)  | ETL metadata source table name.                                                    |

---

## 4. gold\_dim\_store

**Purpose**: Stores details about physical stores.

| Column Name          | Data Type    | Description                                           |
| -------------------- | ------------ | ----------------------------------------------------- |
| store\_key           | VARCHAR(42)  | Surrogate key uniquely identifying each store record. |
| store\_location\_id  | VARCHAR(10)  | Unique identifier for the store location.             |
| store\_address       | VARCHAR(255) | Location of the store.                                |
| store\_city          | VARCHAR(50)  | City where store is located.                          |
| store\_country       | VARCHAR(50)  | Country where store is located.                       |
| store\_postcode      | VARCHAR(20)  | Postcode where store is located.                      |
| dq\_record\_status   | VARCHAR(10)  | Data quality flag (Valid / Invalid).                  |
| etl\_load\_timestamp | TIMESTAMP    | ETL load timestamp.                                   |
| etl\_source          | VARCHAR(50)  | ETL metadata source table name.                       |

---

## 5. gold\_dim\_sales\_person

**Purpose**: Stores information on sales representatives, their roles, and salaries.

| Column Name          | Data Type     | Description                                               |
| -------------------- | ------------- | --------------------------------------------------------- |
| sales\_person\_key   | VARCHAR(42)   | Surrogate key: CONCATS(sales_person_id  & store_id).      |
| sales\_person\_id    | VARCHAR(10)   | Unique identifier for the sales person.                   |
| store\_location\_id  | VARCHAR(10)   | Identifier of store where sales person assigned.          |
| sales\_rep\_name     | VARCHAR(100)  | Full name of sales representative.                        |
| manager\_flag        | VARCHAR(10)   | Indicates if the sales rep is a manager (Yes/No/Unknown). |
| sales\_rep\_salary   | DECIMAL(10,2) | Sales representative’s salary (USD).                      |
| store\_address       | VARCHAR(255)  | Store address where sales rep is assigned.                |
| store\_city          | VARCHAR(50)   | Store city where sales rep is assigned.                   |
| store\_country       | VARCHAR(50)   | Store country where sales rep is assigned.                |
| store\_postcode      | VARCHAR(20)   | Store postcode where sales rep is assigned.               |
| dq\_record\_status   | VARCHAR(10)   | Data quality flag (Valid / Invalid).                      |
| etl\_load\_timestamp | TIMESTAMP     | ETL load timestamp.                                       |
| etl\_source          | VARCHAR(50)   | ETL metadata source table name.                           |

---

## 6. gold\_fact\_sales\_order

**Purpose**: Captures details of customer orders, including quantities, values, and related entities.

| Column Name               | Data Type     | Description                                                |
| ------------------------- | ------------- | ---------------------------------------------------------- |
| sales\_order\_key         | VARCHAR(42)   | Surrogate key: CONCAT(order_id & product_id  & store_id).  |
| order\_id                 | VARCHAR(10)   | Unique identifier for the order.                           |
| product\_id               | VARCHAR(10)   | Identifier of the ordered product.                         |
| store\_location\_id       | VARCHAR(10)   | Store where the order was placed.                          |
| customer\_id              | VARCHAR(10)   | Customer who placed the order.                             |
| sales\_person\_id         | VARCHAR(10)   | Sales representative who handled the order.                |
| order\_number             | VARCHAR(20)   | order number.                                              |
| order\_line\_status       | VARCHAR(20)   | Status of the order line (e.g., Open, Shipped, Cancelled). |
| ordered\_quantity         | INT           | Ordered quantity.                                          |
| cancelled\_quantity       | INT           | Cancelled quantity.                                        |
| returned\_quantity        | INT           | Returned quantity.                                         |
| actual\_ordered\_quantity | INT           | Net quantity ordered (after cancellations/returns).        |
| product\_price\_usd       | DECIMAL(10,2) | Unit price of product.                                     |
| order\_value\_usd         | DECIMAL(12,2) | Total value of the order line.                             |
| customer\_request\_date   | DATE          | Customer’s requested delivery date.                        |
| ship\_date                | DATE          | Actual shipment date.                                      |
| order\_creation\_date     | DATE          | Order creation timestamp.                                  |
| payment\_method           | VARCHAR(30)   | Payment method used.                                       |
| product\_number           | VARCHAR(30)   | Product reference/SKU.                                     |
| invoice\_number           | VARCHAR(30)   | Invoice number.                                            |
| sales\_rep\_name          | VARCHAR(100)  | Sales rep handling the order.                              |
| customer\_name            | VARCHAR(100)  | Customer name.                                             |
| product\_name             | VARCHAR(100)  | Product name.                                              |
| product\_category         | VARCHAR(50)   | Product category.                                          |
| store\_address            | VARCHAR(255)  | Store address.                                             |
| store\_city               | VARCHAR(50)   | Store city.                                                |
| store\_country            | VARCHAR(50)   | Store country.                                             |
| store\_postcode           | VARCHAR(20)   | Store postal code.                                         |
| dq\_record\_status        | VARCHAR(10)   | Data quality flag (Valid / Invalid).                       |
| etl\_load\_timestamp      | TIMESTAMP     | ETL load timestamp.                                        |
| etl\_source               | VARCHAR(50)   | ETL metadata source table name.                            |

---

## 7. gold\_fact\_order\_ship

**Purpose**: Captures shipments, deliveries, and fulfillment details for sales orders.

| Column Name          | Data Type    | Description                                                                |
| -------------------- | ------------ | ---------------------------------------------------------------------------|
| ship\_order\_key     | VARCHAR(42)  | VARCHAR(42)	Surrogate key: CONCAT(order_id & ship_id  & product_id).       |
| order\_id            | VARCHAR(10)  | Associated order identifier.                                               |
| ship\_id             | VARCHAR(10)  | Shipment identifier.                                                       |
| product\_id          | VARCHAR(10)  | Product identifier.                                                        |
| store\_location\_id  | VARCHAR(10)  | Store shipping the product.                                                |
| delivery\_status     | VARCHAR(20)  | Status of delivery (e.g., Shipped, Delivered, Cancelled).                  |
| customer\_id         | VARCHAR(10)  | Customer receiving the shipment.                                           |
| delivery\_number     | VARCHAR(20)  | Delivery reference number.                                                 |
| delivery\_type       | VARCHAR(20)  | Delivery type (e.g., Express, Standard).                                   |
| cancelled\_quantity  | INT          | Quantity cancelled in shipment.                                            |
| shipped\_quantity    | INT          | Quantity shipped.                                                          |
| delivered\_quantity  | INT          | Quantity delivered.                                                        |
| delivery\_date       | DATE         | Date of delivery.                                                          |
| ship\_date           | DATE         | Date of shipment.                                                          |
| shipping\_method     | VARCHAR(30)  | Shipping method used (e.g., Air, Road).                                    |
| carrier\_type        | VARCHAR(30)  | Carrier type (e.g., FedEx, DHL).                                           |
| tracking\_number     | VARCHAR(50)  | Tracking number for shipment.                                              |
| customer\_name       | VARCHAR(100) | Customer name.                                                             |
| ship\_to\_address    | VARCHAR(255) | Shipping destination address.                                              |
| ship\_to\_state      | VARCHAR(50)  | Shipping destination state.                                                |
| ship\_to\_country    | VARCHAR(50)  | Shipping destination country.                                              |
| ship\_to\_postcode   | VARCHAR(20)  | Shipping destination postal code.                                          |
| ship\_from\_address  | VARCHAR(255) | Origin store address.                                                      |
| ship\_from\_city     | VARCHAR(50)  | Origin store city.                                                         |
| ship\_from\_country  | VARCHAR(50)  | Origin store country.                                                      |
| ship\_from\_postcode | VARCHAR(20)  | Origin store postal code.                                                  |
| dq\_record\_status   | VARCHAR(10)  | Data quality flag (Valid / Invalid).                                       |
| etl\_load\_timestamp | TIMESTAMP    | ETL load timestamp.                                                        |
| etl\_source          | VARCHAR(50)  | ETL metadata source table name.                                            |

---

