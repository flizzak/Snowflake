---> Switch to test database
use database test_database;
use schema test_schema;

---> Keywords
/*
 AT|BEFORE
 timestamp => '2026-02-11 12:00:00' Specific time.
 offset => '20' Number of seconds.
 statement => '01c260be-0005-267c-0000-6fbd0001be6a' Query ID
*/

---> Check current session timezone
SHOW PARAMETERS LIKE 'TIMEZONE' IN SESSION;

---> Modify the current session timezone.
alter session set timezone = 'UTC';

---> Check the current status of the previously created tables.
select table_name, created, last_altered, last_ddl, retention_time
from information_schema.tables
where table_schema = 'TEST_SCHEMA';

---> Check the current records of the table
select * from test_table;

---> Show the successful insert statements to collect the query IDs
SELECT
    query_id,
    query_text,
    user_name,
    execution_status,
    end_time,
    total_elapsed_time/1000 AS elapsed_seconds
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE query_type = 'INSERT'
  AND database_name = 'TEST_DATABASE'
  AND schema_name = 'TEST_SCHEMA'
  AND execution_status = 'SUCCESS'
  AND start_time >= DATEADD(day, -30, CURRENT_TIMESTAMP) -- last 30 days
ORDER BY start_time DESC;

---> Check all query types executed successfully.
select distinct query_type 
from SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
where execution_status = 'SUCCESS';

---> Use time travel BEFORE with statement
select * from test_table 
BEFORE(statement => '01c260b4-0005-267c-0000-6fbd0001be22');

---> Use time travel AT with statement
select * from test_table 
AT(statement => '01c260b4-0005-267c-0000-6fbd0001be22');

---> Calculate the number of seconds for a given timestamp and current time.
select 
 datediff(
    second,
    to_timestamp('2026-02-12 22:36:53.014 -0600'),
    current_timestamp
 ) as seconds_diff;

---> Use time travel BEFORE with OFFSET
select * from test_table
BEFORE(OFFSET => -53000);

---> Use time travel AT with OFFSET
select * from test_table
AT(OFFSET => -52751);

---> Use time travel BEFORE with TIMESTAMP
select * from test_table
BEFORE(TIMESTAMP => '2026-02-13 00:00:00'::timestamp);

---> Use time travel AT with TIMESTAMP
select * from test_table
AT(TIMESTAMP => '2026-02-13 04:45:00'::timestamp);







