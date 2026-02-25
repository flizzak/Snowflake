--> Switching to Super user account.
USE ROLE ACCOUNTADMIN;

--> Create Resource Monitors
CREATE RESOURCE MONITOR bank_mgmt_resmon
WITH 
    CREDIT_QUOTA = 100 
    FREQUENCY = weekly 
    START_TIMESTAMP = immediately 
    TRIGGERS 
        ON 75 PERCENT DO NOTIFY 
        ON 90 PERCENT DO SUSPEND 
        ON 199 PERCENT DO SUSPEND_IMMEDIATE; 

---> Create a Virtual Warehouse using provide a high-performance ML version
CREATE WAREHOUSE BankMgmt_WH
with 
    COMMENT = 'Bank management warehouse'
    WAREHOUSE_SIZE = 'XSmall'
    MIN_CLUSTER_COUNT = 1
    MAX_CLUSTER_COUNT = 3
    WAREHOUSE_TYPE = 'Standard'
    AUTO_SUSPEND = 180
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    SCALING_POLICY = 'ECONOMY'
    RESOURCE_MONITOR = bank_mgmt_resmon
    MAX_CONCURRENCY_LEVEL = 10;


---> Switch Virtual Warehouse
USE WAREHOUSE BANKMGMT_WH;

---> Create database
CREATE OR REPLACE DATABASE BANK
 WITH COMMENT = "Bank mock data to be ingested into Snowflake";

---> Switching to Bank database
USE DATABASE BANK;

---> Create schema Raw (Bronze layer).
CREATE OR REPLACE SCHEMA BRONZE
 WITH 
    COMMENT = 'Raw state of the data'
    DATA_RETENTION_TIME_IN_DAYS = 90;

---> Switch to bronze schema
USE SCHEMA BRONZE;

---> Create table to load data
CREATE TABLE Branches (
  branch_id VARCHAR(10) PRIMARY KEY,
  branch_name VARCHAR(100) NOT NULL,
  address VARCHAR(120),
  city VARCHAR(80),
  state VARCHAR(80),
  postal_code VARCHAR(10),
  phone VARCHAR(20),
  opened_date VARCHAR(20)
);

---> Load local all CSV files into USER stage
put file://C:\Projects\Snowflake\Snowflake\Scenarios\BankManagement\Data\*.csv @~/bank_data/staged overwrite=True;

---> Validate that all CSV files are availabe in stage
list @~;

---> Copy data from stage into a persistent table
copy into branches
from @~/bank_data/staged/branches
file_format = (type = 'CSV' skip_header=1);

select * from branches;

