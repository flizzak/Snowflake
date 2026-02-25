/* 
Table Types
*/

---> Switching to Test Database & Schema
use database test_database;
use schema test_schema;

---> Create permanent/persistent table
create or replace table perm_table (
    id number,
    name varchar,
    date date
    );

--> Create transient table
create or replace TRANSIENT table transient_table ( id number,
    name varchar,
    date date
    );

--> Create temporary table
create or replace TEMPORARY table temp_table (
    id number,
    name varchar,
    date date
    );

--> Inserting values into each table type.
insert into perm_table values 
    (1, 'Edwin', '2026-01-21'),
    (2, 'Alejandro', '2025-01-21');
insert into transient_table values 
    (3, 'Camila', '2026-01-21'),
    (4, 'Quetzallí', '2025-01-21');
insert into temp_table values 
    (5, 'Karla', '2026-01-21');

--> Validate that the records have been inserted successfully.
select * from perm_table
union
select * from transient_table
union  
select * from temp_table
order by id;

---> Validate the table types using information_schema
select 
    table_name, table_type, 
    is_transient, is_temporary, 
    retention_time, created 
from information_schema.tables
where table_schema = 'TEST_SCHEMA';

---> Validate the table types using SHOW TABLES
SHOW TABLES;


---> Alter retention time for each table type
ALTER TABLE PERM_TABLE SET DATA_RETENTION_TIME_IN_DAYS = 90;
ALTER TABLE TEMP_TABLE SET DATA_RETENTION_TIME_IN_DAYS = 2;
ALTER TABLE TRANSIENT_TABLE SET DATA_RETENTION_TIME_IN_DAYS = 2;

---> Validate the retention type has been modified by using SHOW TABLES
SHOW TABLES;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
/* 
 Create a persistent table with an example of each data type available.
*/
create or replace table test_database.test_schema.test_table (
    id number(38,0) autoincrement start 1 increment 1,
    first_name string not null,
    last_name varchar(100) not null,
    active boolean not null,
    birthdate date,
    branch_name varchar(10),
    member_since datetime,
    branch_location geography,
    rate number(10,2),
    notes variant
);

---> Insert values into the persistent table using select statements.
insert into test_database.test_schema.test_table 
(first_name, last_name, active, birthdate, branch_name, member_since, branch_location, rate, notes)
    select 'Juan', 'Perez', True, to_date('1980-05-13'), 'Sucursal 1', 
            to_timestamp('2025-01-10 12:35:24'), 
            TO_GEOGRAPHY('POINT(-103.7240 19.2433)'), 9.4, 
            PARSE_JSON('{"weight":120.3, 
                         "height":172, 
                         "skills": ["Python", "SQL"]}')
    union
    select 'Juana', 'Rodriguez', False, to_date('1987-12-24'), 'Sucursal 2', 
            to_timestamp('2026-02-12 12:35:24'), 
            TO_GEOGRAPHY('POINT(-99.1332 19.4326)'), 8.34,  
            PARSE_JSON('{"weight":72.1, 
                         "height":156,
                         "skills": ["Rust", "JavaScript"]}');


---> Insert values into the persistent table.
insert into test_database.test_schema.test_table 
(first_name, last_name, active, birthdate, branch_name, member_since, branch_location, rate)
values 
    ('Edwin', 'Romero', True, '1984-05-22', 'GDS EY', '2026-01-21',
     'POINT(-103.708978 19.283174)', 9.26);

---> There's no direct method to insert variant, object or array directly. As of now, to insert only 1 record the only option available is to use functions to do so. 
update test_database.test_schema.test_table 
set notes = PARSE_JSON('{"weight":75.6, 
                         "height":172,
                         "skills": ["Python", "Spark", "SQL"]}')
where first_name = 'Edwin' and last_name = 'Romero';

---> Validate that the records have been inserted successfully.
select * from test_database.test_schema.test_table;















