---> list all procedures
SHOW PROCEDURES;

SELECT * FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER
LIMIT 100;

---> see the latest and earliest order timestamps so we can determine what we want to delete
SELECT MAX(ORDER_TS), MIN(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER;

---> save the max timestamp
SET max_ts = (SELECT MAX(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER);

SELECT $max_ts;

SELECT DATEADD('DAY',-180,$max_ts);

---> determine the necessary cutoff to go back 180 days
SET cutoff_ts = (SELECT DATEADD('DAY',-180,$max_ts));

---> note how you can use the cutoff_ts variable in the WHERE clause
SELECT MAX(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER
WHERE ORDER_TS < $cutoff_ts;

USE DATABASE TASTY_BYTES;

---> create your procedure
CREATE OR REPLACE PROCEDURE delete_old()
RETURNS BOOLEAN
LANGUAGE SQL
AS
$$
DECLARE
  max_ts TIMESTAMP;
  cutoff_ts TIMESTAMP;
BEGIN
  max_ts := (SELECT MAX(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER);
  cutoff_ts := (SELECT DATEADD('DAY',-180,:max_ts));
  DELETE FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER
  WHERE ORDER_TS < :cutoff_ts;
END;
$$
;

SHOW PROCEDURES;

---> see information about your procedure
DESCRIBE PROCEDURE delete_old();

---> run your procedure
CALL DELETE_OLD();

---> confirm that that made a difference
SELECT MIN(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER;

---> it did! We deleted everything from before the cutoff timestamp
SELECT $cutoff_ts;https://login.microsoftonline.com/5b973f99-77df-4beb-b27d-aa0c70b8482c/saml2?client-request-id=15cd9274-7a40-4589-b5ef-706bc1313a82&sso_nonce=AwABEgEAAAADAOz_BQD0_0V2b1N0c0FydGlmYWN0cwUAAAAAAGSZYSJoKrcVTv6Eqq62QHaEhOhM4Q95hho_JOw6O315In0wOsx8mzVvhRE4BfkGivOLuNOTQh0F0_FdRO1o2mAgAA&mscrid=15cd9274-7a40-4589-b5ef-706bc1313a82



select 
    data:Department as department,
    sum(o.value:Sales) as sales
    -- d. as sales
from json_test t
 ,lateral flatten(input => data:Zone) z
 ,lateral flatten(input => z.value:Division) div
 ,lateral flatten(input => div.value:Orders) o
 group by 1;

 