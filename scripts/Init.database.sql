/*
============================================================================================================
Create Database and Schemas
============================================================================================================
Sript Purpose:
This script creates a new database named 'Order_management' after checking if it already exists
If the database exists, it is dropped and recreated. 


WARNING:
Running this script will drop the entire 'Order_Management' database if it exists
All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups
before running this script.

*/

-- Drop and recreate the 'Order_management' database

DROP DATABASE IF EXISTS Order_management;

CREATE DATABASE IF NOT EXISTS Order_management;

USE Order_management;

