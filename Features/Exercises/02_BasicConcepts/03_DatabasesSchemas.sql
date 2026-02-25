---> create a test database
CREATE OR REPLACE DATABASE test_database;

---> Display Databases available
SHOW DATABASES;

---> Make a database and schema the default for specific users
alter user admin set default_namespace = test_database.public;

---> drop the database
DROP DATABASE test_database;

---> Display Databases available
SHOW DATABASES;

---> undrop the database
UNDROP DATABASE test_database;
/*
The retention period for undropping a database or schema in Snowflake is set to 1 day by default. However, this period can be adjusted to 0 days to disable Time Travel, or increased up to 90 days for Snowflake Enterprise Edition. Users with the ACCOUNTADMIN role can specify the retention period for their account, which will then act as the default for all objects within the account. Additionally, a minimum retention period can be set at the account level to enforce a minimum data retention time across all databases, schemas, and tables within the account
*/

-- Increase retention period to 7 days for a database
ALTER DATABASE test_database
SET DATA_RETENTION_TIME_IN_DAYS = 7;

---> Display Databases available
SHOW DATABASES;

---> Create Schema
use database test_database;
create schema test_schema 
 with 
    comment = 'Test Schema'
    data_retention_time_in_days = 5;

---> Review schemas metadata (Detailed).
show schemas;

---> Another method to list schemas within a database (Schema information).
describe database test_database;

