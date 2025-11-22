# Order Management Data Warehouse Project

Welcome to the **Order Management Data Warehouse Project** repository!
---
In this project, i designed and developed a data warehouse and analytics solution, utilising medallion architecture best practices to transform raw data from two sources into business-ready data for analytics and reporting purposes.

This project is developed as a portfolio project to highlight industry best practices in data engineering, data modelling and analytics.

---
**The raw data came from two different sources**:

* ERP (Enterprise Resource Planning): contains sales orders, product information, store data, and shipment details.
* POS (Point of sales): contains sales transactions, product and store details, customer information, and shipment data.
---


# Project Overview
This project covers the full data lifecycle:
1. Data Architecture: Designing a modern Data Warehouse using the Medallion Architecture Bronze, Silver, and Gold layers
2. ETL Pipelines: Extracting, transforming, and loading data from POS and ERP source systems into the warehouse
3. Data Modelling: Developing fact and dimension tables optimised for analytical queries and reporting.
4. Analytical & Reporting creating SQL-based reports using Views and dashboards to deliver actionable insights for stakeholders.

---

## Project Requirements

### Building the Order Management Data Warehouse (Data Engineering)

#### Objective:
Develop a modern data warehouse using SQL to consolidate data from POS and ERP sources for each of the data for Sales, shipment, customers, stores, products,
sales person data, making it ready for analysis and reporting.

##### Specifications: 
- **Data Sources**: All data used in this project is **simulated** and generated for learning purposes.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Consolidate data from ERP and POS into a single, user-friendly data model designed
  for analytical queries and reporting.
- **Documentation**: Provide clear documentation of the data model to support business both business
  stakeholders and analytics team.

  
---

### Data Analysis (Business Intelligence & Reporting)

####  Objective:

Develop SQL-based analytic reports to deliver detailed insights into:
- **Customer Purchasing Behaviour**
- **Product Performance**
- **Sales order Trends**
- **Shipment Efficency**
  
  These insights empower stakeholders within the business identify/track key business metrics,
  enabling informed decision-making

  ---
## 📊 Data Architecture  
The warehouse follows a Medallion Architecture:
* **Bronze Layer**: Raw data ingested from ERP and POS systems
* **Silver Layer**: Cleaned and standardised data ready for analysis.
* **Gold Layer**: Analytical aggregates, business-ready queries, and KPIs views for business users.
---
Below is the Medallion Architecture (Bronze → Silver → Gold) used in this project:

![](medallion_architecture_diagram.svg)

---


## About Me

Hi, I am **Solomon Yakubu**, a data professional with 4 years of experience building solutions that enables technical and non-technical teams make better decisions. I have rcently completed a data warehouse    project using MYSQL database where i applied medallion architecture best practices to turn raw data into business ready data.
