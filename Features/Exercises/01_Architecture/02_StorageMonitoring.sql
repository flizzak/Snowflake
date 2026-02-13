--> Switching to Super user account.
USE ROLE ACCOUNTADMIN;


--> Most detailed information:
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS
order by table_catalog;


--> Create a new database to view new metrics.
CREATE OR REPLACE DATABASE STORAGE_TEST;
CREATE OR REPLACE TABLE STORAGE_TEST.PUBLIC.TEST_TABLE (COLUMN_1 VARCHAR);
INSERT INTO STORAGE_TEST.PUBLIC.TEST_TABLE VALUES ('Text1Text2Text3');


--> View new metrics
-- Using ACCOUNT_USAGE
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS
where TABLE_CATALOG = 'STORAGE_TEST';

-- Using INFORMATION_SCHEMA
SELECT * FROM STORAGE_TEST.INFORMATION_SCHEMA.TABLE_STORAGE_METRICS
ORDER BY TABLE_CATALOG;

-- Less information using SHOW TABLES command.
USE DATABASE STORAGE_TEST;
USE SCHEMA PUBLIC;
SHOW TABLES;

/*  ##### Resource Monitors #### */
--> Create Resource Monitors
CREATE RESOURCE MONITOR test_resource_monitor
WITH 
    CREDIT_QUOTA = 30 -- 20 credits
    FREQUENCY = daily -- reset the monitor daily
    START_TIMESTAMP = immediately -- begin tracking immediately
    TRIGGERS 
        ON 80 PERCENT DO NOTIFY -- notify accountadmins at 80%
        ON 100 PERCENT DO SUSPEND -- suspend warehouse at 100 percent, let queries finish
        ON 110 PERCENT DO SUSPEND_IMMEDIATE; -- suspend warehouse and cancel all queries at 110 percent

---> see all resource monitors
SHOW RESOURCE MONITORS;

---> assign a resource monitor to a warehouse
ALTER WAREHOUSE COMPUTE_WH SET RESOURCE_MONITOR = test_resource_monitor;

SHOW RESOURCE MONITORS;

---> change the credit quota on a resource monitor
ALTER RESOURCE MONITOR test_resource_monitor
  SET CREDIT_QUOTA=50;

SHOW RESOURCE MONITORS;

---> drop a resource monitor
DROP RESOURCE MONITOR test_resource_monitor;
    
SHOW RESOURCE MONITORS;