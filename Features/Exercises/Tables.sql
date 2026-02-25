---> drop truck_dev if not dropped previously
DROP TABLE TASTY_BYTES.RAW_POS.TRUCK_DEV;

---> create a transient table
CREATE TRANSIENT TABLE TASTY_BYTES.RAW_POS.TRUCK_TRANSIENT
    CLONE TASTY_BYTES.RAW_POS.TRUCK;

---> create a temporary table
CREATE TEMPORARY TABLE TASTY_BYTES.RAW_POS.TRUCK_TEMPORARY
    CLONE TASTY_BYTES.RAW_POS.TRUCK;

---> show tables that start with the word TRUCK
SHOW TABLES LIKE 'TRUCK%';

---> attempt (successfully) to set the data retention time to 90 days for the standard table
ALTER TABLE TASTY_BYTES.RAW_POS.TRUCK SET DATA_RETENTION_TIME_IN_DAYS = 90;

---> attempt (unsuccessfully) to set the data retention time to 90 days for the transient table
ALTER TABLE TASTY_BYTES.RAW_POS.TRUCK_TRANSIENT SET DATA_RETENTION_TIME_IN_DAYS = 90;

---> attempt (unsuccessfully) to set the data retention time to 90 days for the temporary table
ALTER TABLE TASTY_BYTES.RAW_POS.TRUCK_TEMPORARY SET DATA_RETENTION_TIME_IN_DAYS = 90;

SHOW TABLES LIKE 'TRUCK%';

---> attempt (successfully) to set the data retention time to 0 days for the transient table
ALTER TABLE TASTY_BYTES.RAW_POS.TRUCK_TRANSIENT SET DATA_RETENTION_TIME_IN_DAYS = 0;

---> attempt (successfully) to set the data retention time to 0 days for the temporary table
ALTER TABLE TASTY_BYTES.RAW_POS.TRUCK_TEMPORARY SET DATA_RETENTION_TIME_IN_DAYS = 0;

SHOW TABLES LIKE 'TRUCK%';



-- CLONING

---> create a clone of the truck table
CREATE OR REPLACE TABLE tasty_bytes.raw_pos.truck_clone 
    CLONE tasty_bytes.raw_pos.truck;

/* look at metadata for the truck and truck_clone tables from the table_storage_metrics view in the information_schema */
SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLE_STORAGE_METRICS
WHERE TABLE_NAME = 'TRUCK_CLONE' OR TABLE_NAME = 'TRUCK';

/* look at metadata for the truck and truck_clone tables from the tables view in the information_schema */
SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'TRUCK_CLONE' OR TABLE_NAME = 'TRUCK';

---> insert the truck table into the clone (thus doubling the clone’s size!)
INSERT INTO tasty_bytes.raw_pos.truck_clone
SELECT * FROM tasty_bytes.raw_pos.truck;

---> now use the tables view to look at metadata for the truck and truck_clone tables again
SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'TRUCK_CLONE' OR TABLE_NAME = 'TRUCK';

---> clone a schema
CREATE OR REPLACE SCHEMA tasty_bytes.raw_pos_clone
CLONE tasty_bytes.raw_pos;

---> clone a database
CREATE OR REPLACE DATABASE tasty_bytes_clone
CLONE tasty_bytes;

---> clone a table based on an offset (so the table as it was at a certain interval in the past) 
CREATE OR REPLACE TABLE tasty_bytes.raw_pos.truck_clone_time_travel 
    CLONE tasty_bytes.raw_pos.truck AT(OFFSET => -60*10);

SELECT * FROM tasty_bytes.raw_pos.truck_clone_time_travel;