1) In Snowflake, “estimation functions” are primarily used to:
A. Guarantee exact results with lower cost
B. Provide approximate results faster and with less memory
C. Compress results in the result cache
D. Eliminate the need for statistics
Correct Answer: B
Explanation: Estimation (approximate) functions trade precision for speed and lower resource usage. Typical use cases include approximating distinct counts and percentiles at scale when exactness isn’t critical.

2) Which function is commonly used for approximate distinct counts at scale?
A. COUNT(DISTINCT …)
B. APPROX_COUNT
C. APPROX_COUNT_DISTINCT
D. HLL_ESTIMATE_COUNT
Correct Answer: C
Explanation: APPROX_COUNT_DISTINCT returns a fast, approximate distinct count that’s often accurate enough for analytics while being more efficient than an exact COUNT(DISTINCT ...) on very large datasets.

3) Which statement about SAMPLE and TABLESAMPLE is true?
A. They are different and return incompatible results
B. SAMPLE is deprecated; use TABLESAMPLE
C. They are synonyms; both provide sampling from a table
D. Only SAMPLE supports seeded reproducibility
Correct Answer: C
Explanation: In Snowflake, SAMPLE and TABLESAMPLE are synonyms; both support percent‑based and fixed‑size sampling and optional seeding for repeatable samples.

4) Which are Snowflake’s sampling methods?
A. HASH and BLOCK
B. BERNOULLI and SYSTEM
C. ROUND_ROBIN and HASH
D. RANDOM and SEEDED
Correct Answer: B
Explanation: BERNOULLI (row‑level, independent probability per row) and SYSTEM (block‑level sampling for larger blocks of data) are supported. SYSTEM is often faster on large tables because it samples data blocks.

5) Which query samples 10% of rows using BERNOULLI?
A. SELECT * FROM T SAMPLE SYSTEM (10);
B. SELECT * FROM T TABLESAMPLE (10 ROWS);
C. SELECT * FROM T SAMPLE BERNOULLI (10);
D. SELECT * FROM T SAMPLE (10 ROWS) BERNOULLI;
Correct Answer: C
Explanation: Fraction‑based sampling uses a percentage. BERNOULLI (10) returns ~10% of rows chosen independently.

6) Which query samples a fixed number of rows (e.g., 5,000)?
A. SELECT * FROM T SAMPLE (5,000);
B. SELECT * FROM T SAMPLE (5000 ROWS);
C. SELECT * FROM T TABLESAMPLE SYSTEM (5000);
D. SELECT * FROM T SAMPLE BERNOULLI (5000%);
Correct Answer: B
Explanation: Fixed‑size sampling uses the ROWS keyword: SAMPLE (N ROWS). Snowflake attempts to return approximately N rows.

7) How do you make a sampled query repeatable?
A. Add ORDER BY
B. Provide a SEED to the sampling clause
C. Use SYSTEM instead of BERNOULLI
D. Disable micro‑partition pruning
Correct Answer: B
Explanation: SAMPLE ... SEED(<int>) produces a repeatable pseudo‑random sample so the same seed yields the same sample (assuming underlying data is unchanged).

8) Which is an example of a system (scalar) function in Snowflake?
A. FLATTEN
B. GENERATOR
C. COALESCE
D. EXTERNAL FUNCTION
Correct Answer: C
Explanation: System functions (often called scalar functions) operate on values and return a single value per row (e.g., COALESCE, TO_DATE, TRY_TO_NUMBER).

9) Which is a table function?
A. NVL
B. FLATTEN
C. ROUND
D. GET_DDL
Correct Answer: B
Explanation: Table functions (e.g., FLATTEN, SPLIT_TO_TABLE, INFER_SCHEMA) return a set of rows and are used in the FROM clause (often with LATERAL).

10) What is an external function?
A. A UDF that runs in JavaScript
B. A function that calls out to an external service via a secure integration
C. A function that reads the result cache
D. A function only for file I/O
Correct Answer: B
Explanation: External functions enable secure, governed calls from Snowflake SQL to external endpoints (e.g., API gateways) to enrich or score data.

11) Snowflake UDFs can be written in:
A. SQL only
B. Java only
C. SQL or JavaScript (and with Snowpark, also Java/Python/Scala in certain patterns)
D. Bash
Correct Answer: C
Explanation: Core Snowflake supports SQL and JavaScript UDFs. With Snowpark, developers commonly implement UDF‐style logic in Java/Python/Scala (the underlying execution details vary by feature and edition).

12) Snowflake stored procedures can be authored in:
A. Java only
B. JavaScript and Snowflake Scripting (SQL procedural language)
C. Python only
D. Bash
Correct Answer: B
Explanation: Stored procedures run procedural logic on the server side. Snowflake supports JavaScript procedures and Snowflake Scripting (SQL‑based procedural language) for branching, loops, exceptions, etc.

13) A stream on a table is primarily used to:
A. Improve query performance
B. Store historical backups
C. Track change data (inserts/updates/deletes) for CDC
D. Enforce masking policies
Correct Answer: C
Explanation: A stream captures row changes since last consumption, enabling incremental processing patterns (e.g., ELT pipelines).

14) Which is a common pattern with streams and tasks?
A. Task runs on a schedule, reads from a stream, processes only new changes
B. Task runs only when a user logs in
C. Stream auto‑writes into target tables
D. Task deletes stream history automatically
Correct Answer: A
Explanation: A scheduled task queries the stream (delta changes) and writes to downstream tables, supporting reliable incremental pipelines.

15) Which is true about tasks in Snowflake?
A. Tasks require external schedulers
B. Tasks can run on a warehouse or as serverless (where supported)
C. Tasks can only call stored procedures
D. Tasks cannot be chained
Correct Answer: B
Explanation: Tasks can execute SQL or stored procedures on a schedule; you can choose a warehouse or serverless mode and build DAGs via AFTER dependencies.

16) Which data formats are commonly supported for loading/unloading?
A. CSV and YAML
B. CSV, JSON, PARQUET, AVRO, ORC, XML
C. PDF and DOCX
D. HTML and TXT only
Correct Answer: B
Explanation: Snowflake natively supports popular structured and semi‑structured formats. YAML, PDF, DOCX are not supported load formats.

17) What is the VARIANT data type used for?
A. Binary image storage in tables
B. Storing semi‑structured data (JSON, AVRO, PARQUET values)
C. Encrypting results
D. Defining external tables
Correct Answer: B
Explanation: VARIANT holds hierarchical/semi‑structured values. You access fields with colon notation (e.g., v:customer.id) or functions (GET, GET_PATH).

18) Which query correctly extracts a nested JSON field from a VARIANT column payload?
A. SELECT payload["customer.id"] FROM t;
B. SELECT payload:"customer"."id" FROM t;
C. SELECT payload['customer.id'] FROM t;
D. SELECT payload.customer.id FROM t;
Correct Answer: B
Explanation: In JSON path notation for VARIANT, use colon : and quote keys as needed: payload:"customer"."id". Dots and quotes must follow JSON path rules.

19) Which usage of FLATTEN is correct to explode an array in payload:items?
A. SELECT * FROM FLATTEN(payload:items) t;
B. SELECT * FROM LATERAL FLATTEN(payload, 'items');
C. SELECT f.value FROM LATERAL FLATTEN(input => payload:"items") AS f;
D. SELECT FLATTEN(value => payload:items) FROM t;
Correct Answer: C
Explanation: FLATTEN is a table function used in the FROM clause with LATERAL. The value column contains each element. Typical form:
FROM t, LATERAL FLATTEN(input => t.payload:"items") f.

20) What does LATERAL mean in LATERAL FLATTEN(...)?
A. Execute FLATTEN after GROUP BY
B. Allow FLATTEN to reference columns from the current row of the left table
C. Run FLATTEN in parallel only
D. Make FLATTEN deterministic
Correct Answer: B
Explanation: LATERAL allows a table function to access columns from the row currently being processed from the left side of the join.

21) Which pair creates and manipulates arrays/objects in SQL?
A. MAKE_ARRAY, MAKE_OBJECT
B. ARRAY_CONSTRUCT, OBJECT_CONSTRUCT
C. ARRAY_BUILD, OBJECT_BUILD
D. JSON_ARRAY, JSON_OBJECT
Correct Answer: B
Explanation: Snowflake provides constructors like ARRAY_CONSTRUCT(…) and OBJECT_CONSTRUCT(…), plus helpers (e.g., ARRAY_APPEND, OBJECT_INSERT, OBJECT_DELETE, OBJECT_KEYS).

22) Which are type predicate functions for VARIANT?
A. IS_JSON, IS_XML
B. IS_COMPLEX, IS_SCALAR
C. IS_ARRAY, IS_OBJECT, IS_VARCHAR, IS_INTEGER, IS_NULL_VALUE
D. IS_BINARY, IS_NUMERIC_ONLY
Correct Answer: C
Explanation: Type predicates let you test VARIANT value types (e.g., IS_OBJECT(payload)) and handle edge cases such as IS_NULL_VALUE.

23) Which statement about directory tables is correct?
A. They are created with CREATE TABLE … DIRECTORY=TRUE
B. They exist only for internal stages
C. Enabling a stage with DIRECTORY = (ENABLE = TRUE) allows querying file listings via a directory table function
D. They store file bytes inside the table
Correct Answer: C
Explanation: For external (and supported) stages, enabling DIRECTORY maintains file listings/metadata that can be queried (e.g., to detect new/changed files for pipelines).

24) A common SQL file function to infer schema from staged files is:
A. GET_DDL
B. INFER_SCHEMA
C. FILE_BYTES
D. SCAN_FILES
Correct Answer: B
Explanation: INFER_SCHEMA (table function) scans staged files and returns a proposed schema (useful for semi‑structured data and creating external tables).

25) Which are valid URL types associated with Snowflake file access?
A. s3://, gcs://, azure://, and @stage/path
B. s3://, gcs://, Azure Blob URLs (e.g., azure://...blob.core.windows.net/...) used in stages, and stage references like @db.schema.stage/prefix
C. http://, ftp:// only
D. Only stage references @stage
Correct Answer: B
Explanation: External stages reference cloud storage URLs (S3/GCS/Azure Blob). Within SQL, staged paths are addressed as @<stage>[/prefix] (optionally fully‑qualified).

26) Which is a good pattern for processing unstructured data (e.g., images, PDFs) in Snowflake?
A. Load files into VARIANT columns
B. Store files in a stage; keep a metadata table with file paths; call UDFs or external functions to process; write results back
C. Convert files to CSV first
D. Use only GET/PUT without SQL
Correct Answer: B
Explanation: Unstructured data typically resides in stages. Pipelines usually maintain a manifest table of file paths and metadata, then invoke UDFs/external functions (optionally through tasks) for analysis.

27) For unstructured data analysis, when do you use an external function vs a UDF?
A. External function when offline; UDF for streaming
B. External function to call external services/APIs; UDF for logic that can run inside Snowflake
C. Always use external functions
D. Always use UDFs
Correct Answer: B
Explanation: If your processing requires external services (e.g., OCR, vision APIs), use external functions. If the logic can execute in‑database (e.g., string transforms, lightweight parsing), use a UDF.

28) Which statement about streams on views or external tables is accurate?
A. Streams work on any object
B. Streams track row‑level changes on base tables (not arbitrary views); specialized patterns exist for external tables using directory tables
C. Streams only work on stages
D. Streams are only for semi‑structured data
Correct Answer: B
Explanation: Standard streams target tables to capture CDC. For external data, use directory enablement + metadata tables + tasks (or external tables with partition refresh patterns) rather than naive streams.

29) What’s a safe way to extract nested values and avoid runtime errors when types vary?
A. Use : and assume the type
B. Use TRY_ variants (e.g., TRY_TO_NUMBER), IS_* type predicates, and COALESCE to handle type variability
C. Force cast with ::
D. Disable errors with ON_ERROR=CONTINUE in SELECT
Correct Answer: B
Explanation: With semi‑structured data, use type predicates and TRY_ conversion functions to safely parse values without failing queries on mixed/dirty data.

30) Which best describes fixed‑size vs. fraction‑based sampling trade‑offs?
A. Fixed‑size is exact; fraction is approximate
B. Fixed‑size targets a row count (approximate), fraction targets a percentage (approximate); both are non‑deterministic unless seeded
C. Fraction is deterministic; fixed‑size is not
D. Both always return exact counts
Correct Answer: B
Explanation: Snowflake’s sampling is probabilistic; you choose N ROWS or PERCENT. Results vary slightly run‑to‑run; use a SEED for repeatability.