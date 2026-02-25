1) Which Snowflake stage type is fully managed within Snowflake’s storage?
A. External stage
B. Internal named stage
C. Cloud provider stage
D. External integration stage

Correct Answer: B

Explanation:
Internal stages (user, table, and named) reside within Snowflake‑managed storage. External stages reference cloud storage (e.g., S3, GCS, Azure Blob) via URL and credentials/integrations. An “internal named stage” is created with CREATE STAGE <name>; without a URL.

2) Which statement creates an internal named stage?
A. CREATE STAGE mystage URL='s3://bucket/path';
B. CREATE STAGE mystage;
C. CREATE EXTERNAL STAGE mystage;
D. CREATE STAGE mystage TYPE=INTERNAL URL='@~';

Correct Answer: B

Explanation:
Omitting URL creates an internal named stage. Specifying a URL makes it an external stage. @~ refers to the user stage, not a named stage.

3) What is a user stage?
A. A shared external stage for all users
B. A per‑user internal stage available as @~
C. A stage only admins can access
D. A temporary external stage

Correct Answer: B

Explanation:
Every user has a built‑in user stage (internal) referenced as @~. It’s convenient for ad hoc tests and small loads from local via PUT.

4) What is the recommended compressed file size for efficient bulk loads with COPY INTO <table>?
A. 1–10 MB
B. 10–50 MB
C. 100–250 MB
D. >1 GB

Correct Answer: C

Explanation:
Snowflake commonly recommends 100–250 MB compressed files for loading to balance parallelism and metadata overhead. Too many tiny files cause overhead; very large files reduce parallelism.

5) Which folder strategy generally improves bulk loading performance and manageability?
A. Deeply nested folders with many levels
B. Flat or shallow folders, optionally partitioned by date/hour prefixes
C. One file per folder
D. Folders mixing many file formats and encodings

Correct Answer: B

Explanation:
A flat or shallow layout reduces listing overhead. If you need partitioning, use predictable prefixes (e.g., /dt=YYYY-MM-DD/) so COPY can target subsets and minimize scanning.

6) Ad hoc loading from a local machine typically uses:
A. PUT to internal stage + COPY INTO <table>
B. GET from stage + INSERT
C. CREATE EXTERNAL TABLE
D. CREATE PIPE with notifications

Correct Answer: A

Explanation:
For quick, local loads: upload files with PUT to an internal stage and then load with COPY INTO <table>. GET downloads from stage to local (opposite direction).

7) Bulk batch loading from cloud storage typically uses:
A. INSERT statements only
B. External or internal stages + COPY INTO <table>
C. GET to local, then PUT back
D. Only Snowpipe

Correct Answer: B

Explanation:
For high‑throughput, use staged files (internal/external) and load with COPY INTO <table>. Snowpipe is for continuous ingestion, not strictly batch.

8) Snowpipe is best described as:
A. A batch job scheduler
B. Serverless continuous ingestion triggered by events or REST calls
C. A view refresher
D. A compression utility

Correct Answer: B

Explanation:
Snowpipe loads new files automatically as they arrive via cloud notifications or via REST API calls, using serverless compute billed per usage.

9) Which command defines how files should be parsed?
A. CREATE STAGE
B. CREATE PIPE
C. CREATE FILE FORMAT
D. CREATE EXTERNAL TABLE

Correct Answer: C

Explanation:
A file format captures parsing rules: type (CSV/JSON/PARQUET/AVRO/ORC/…); delimiters; quotes; compression; NULL handling; date/time formats; etc. Stages and pipes can reference it.

10) What does a Pipe (created by CREATE PIPE) define?
A. A materialized view refresh job
B. A secured view for files
C. A Snowpipe ingestion object that runs a COPY INTO definition
D. A schema‑level network policy

Correct Answer: C

Explanation:
A pipe encapsulates a COPY INTO

FROM @stage
statement for
continuous
ingestion. With
AUTO_INGEST=TRUE
, it listens to cloud
event notifications
.
11) CREATE EXTERNAL TABLE is used to:
A. Load files directly into permanent tables
B. Expose files in external cloud storage as a queryable table
C. Create a stage with directory listing
D. Build a Snowpipe pipeline

Correct Answer: B

Explanation:
External tables allow you to query data in place on cloud storage (e.g., S3/GCS/Azure) via an external stage and file format—no data is copied into Snowflake storage.

12) Which of the following loads staged files into a table?
A. PUT @stage
B. COPY INTO <table>
C. GET @stage
D. CREATE EXTERNAL TABLE

Correct Answer: B

Explanation:
COPY INTO <table> ingests from stages (internal/external) into tables. PUT/GET transfer files between local and internal stages.

13) INSERT OVERWRITE is best used when you need to:
A. Append a subset of rows
B. Replace all table data (or a partition) atomically in one operation
C. Update matching rows
D. Merge two tables

Correct Answer: B

Explanation:
INSERT OVERWRITE replaces the table (or partition subset) contents atomically with the new result set. For appends, use INSERT INTO. For upserts, use MERGE.

14) The PUT command:
A. Uploads local files → internal stage
B. Downloads stage files → local
C. Loads data into a table
D. Requires an external stage

Correct Answer: A

Explanation:
PUT is a client-side command (e.g., in SnowSQL) that copies files from your local machine to an internal stage (user, table, or named). It doesn’t work for external stages.

15) To inspect load errors without ingesting rows, you can:
A. COPY INTO ... ON_ERROR=ABORT_STATEMENT
B. COPY INTO ... VALIDATION_MODE='RETURN_ERRORS'
C. GET @stage
D. CREATE PIPE with VALIDATE=TRUE

Correct Answer: B

Explanation:
VALIDATION_MODE='RETURN_ERRORS' runs data validation without loading, returning problematic rows. After a load, you can also query the VALIDATE() table function with the COPY job ID.

16) Which of the following is true about compression?
A. Only GZIP is supported
B. Snowflake supports common codecs (e.g., GZIP, BZ2, ZSTD, Brotli, DEFLATE), and Parquet/ORC have built‑in compression
C. Compression must be disabled for JSON
D. Compression is not supported for unloading

Correct Answer: B

Explanation:
For text formats (CSV, JSON), you can specify compression via the file format. Columnar formats (Parquet/ORC/Avro) have internal compression (e.g., Snappy) that Snowflake handles automatically.

17) How can empty strings be treated as NULL during load?
A. It’s not supported
B. By using ON_ERROR=CONTINUE
C. Using file format options like EMPTY_FIELD_AS_NULL=TRUE or NULL_IF=('')
D. By enabling Snowpipe

Correct Answer: C

Explanation:
EMPTY_FIELD_AS_NULL and NULL_IF control how empty fields and specific tokens (e.g., 'NULL', '\N') are mapped to NULL.

18) To unload one single file to a stage from a query:
A. COPY INTO @mystage FROM (...) MAX_FILE_SIZE=0;
B. COPY INTO @mystage/path FROM (...) SINGLE=TRUE;
C. PUT with SINGLE=TRUE
D. INSERT OVERWRITE @stage

Correct Answer: B

Explanation:
Use COPY INTO @stage FROM (SELECT ...) SINGLE=TRUE to consolidate output into one file (size limits apply; for very large outputs, Snowflake may split by necessity).

19) Unloading a relational table to CSV in a stage uses:
A. GET
B. COPY INTO @stage/prefix FROM my_table FILE_FORMAT=(TYPE=CSV ...);
C. INSERT OVERWRITE
D. CREATE EXTERNAL TABLE

Correct Answer: B

Explanation:
To unload, reverse the direction of COPY: output goes into a stage. You can unload from a table or a SELECT.

20) GET does which of the following?
A. Uploads local files to internal stage
B. Loads files into a table
C. Downloads files from an internal stage to local
D. Creates an external stage

Correct Answer: C

Explanation:
GET is the counterpart to PUT. It retrieves files from an internal stage to your local environment.

21) LIST @stage/prefix PATTERN='.*\\.csv.gz' is used to:
A. Unload to CSV
B. Load CSV files
C. List files in the stage matching a pattern
D. Validate files in the stage

Correct Answer: C

Explanation:
LIST displays stage contents, optionally filtered by a PATTERN (regex). This helps confirm paths and filenames before COPY.

22) Which statement about COPY INTO <table> load history is correct?
A. Snowflake never remembers loaded files
B. Snowflake tracks loaded files and skips reloading the same file unless FORCE=TRUE
C. Tracking requires an external table
D. Tracking only works for internal stages

Correct Answer: B

Explanation:
Snowflake maintains load history for files. If the same staged file is encountered again, it’s skipped unless you force a reload (e.g., for reprocessing).

23) Which option helps when source files have extra columns beyond the target table?
A. ON_ERROR=CONTINUE
B. ERROR_ON_COLUMN_COUNT_MISMATCH=FALSE
C. TRUNCATECOLUMNS=FALSE
D. MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE

Correct Answer: B

Explanation:
ERROR_ON_COLUMN_COUNT_MISMATCH=FALSE allows loads when the column counts differ. You can also use MATCH_BY_COLUMN_NAME to align columns by name rather than position.

24) Which is true of MATCH_BY_COLUMN_NAME for COPY INTO <table>?
A. It matches input fields to table columns by name (case‑sensitive or insensitive)
B. It only works for JSON
C. It is required for Parquet
D. It renames table columns

Correct Answer: A

Explanation:
MATCH_BY_COLUMN_NAME supports CASE_SENSITIVE or CASE_INSENSITIVE matching—useful when file column order differs from the table.

25) Which is true for CREATE FILE FORMAT for CSV?
A. JSON options must be set
B. Options include FIELD_DELIMITER, SKIP_HEADER, FIELD_OPTIONALLY_ENCLOSED_BY, NULL_IF, TRIM_SPACE, COMPRESSION, etc.
C. Only delimiter is supported
D. Compression is not supported

Correct Answer: B

Explanation:
CSV file formats are flexible. Properly defining delimiter, quote handling, header skipping, NULL mapping, and compression is essential for clean loads.

26) For JSON file formats, which option helps when the file is an array of objects?
A. FIELD_DELIMITER=','
B. STRIP_OUTER_ARRAY=TRUE
C. DATE_FORMAT='AUTO'
D. BINARY_FORMAT=HEX

Correct Answer: B

Explanation:
If your JSON file wraps records in an outer array, STRIP_OUTER_ARRAY=TRUE tells Snowflake to treat each element as a row.

27) Which is true about Parquet loading?
A. Requires manual compression settings
B. Schema and types are derived from Parquet; compression (e.g., Snappy) is handled automatically
C. Only supports VARIANT
D. Not supported by COPY INTO

Correct Answer: B

Explanation:
Parquet is self‑describing; Snowflake can infer types. You can load Parquet into typed columns or into VARIANT if you prefer schema‑on‑read.

28) Which statement about Snowpipe costs is correct?
A. Snowpipe uses serverless compute billed per usage
B. Snowpipe is free for all regions
C. Snowpipe requires a dedicated warehouse running 24/7
D. Snowpipe charges per file name

Correct Answer: A

Explanation:
Snowpipe leverages serverless compute to parse and load files, so charges are based on compute used, not a dedicated warehouse.

29) What is required to make Snowpipe auto‑ingest files from cloud storage?
A. A running warehouse
B. A pipe with AUTO_INGEST=TRUE and cloud event notifications configured
C. GET/PUT commands
D. A directory table

Correct Answer: B

Explanation:
Auto‑ingest relies on event notifications (e.g., S3, GCS, Azure events) that trigger the pipe’s COPY automatically.

30) CREATE EXTERNAL TABLE ... WITH LOCATION=@ext_stage/prefix ... requires:
A. A table stage
B. An external stage and a file format
C. A running pipe
D. PUT/GET permissions

Correct Answer: B

Explanation:
External tables reference files in external cloud storage through an external stage (URL=...) and file format describing the files.

31) Which statement about VALIDATE (table function) is correct?
A. It edits invalid rows
B. It returns load error details for a specific COPY job (by job ID)
C. It deletes failed files
D. It must be run before COPY

Correct Answer: B

Explanation:
After a COPY operation, you can call VALIDATE(<table>, <job_id>) to inspect errors captured during that load.

32) Which behavior best describes NULL vs empty strings when unloading?
A. NULLs always become empty strings
B. Representation depends on file format options (e.g., NULL_IF, EMPTY_FIELD_AS_NULL, FIELD_OPTIONALLY_ENCLOSED_BY)
C. NULLs are exported as 0
D. Snowflake refuses to unload NULLs

Correct Answer: B

Explanation:
When unloading, formatting and NULL/empty handling are controlled by the file format—the same concepts used for loading.

33) When unloading large result sets, which format is often recommended for efficient storage and downstream processing?
A. XML
B. Parquet
C. CSV with no compression
D. Fixed‑width text

Correct Answer: B

Explanation:
Parquet is columnar, compressed by default, efficient for analytics, and often more compact than CSV, reducing storage and egress.

34) Which COPY INTO option helps diagnose formatting issues without loading any rows?
A. ON_ERROR=CONTINUE
B. VALIDATION_MODE='RETURN_ERRORS'
C. PURGE=TRUE
D. FORCE=TRUE

Correct Answer: B

Explanation:
VALIDATION_MODE returns parsing errors for staged files; it’s the safest first step to validate your file format and input data.

35) What does PURGE=TRUE do in COPY INTO <table>?
A. Deletes the target table
B. Removes successfully loaded files from the stage
C. Purges table micro‑partitions
D. Clears the result cache

Correct Answer: B

Explanation:
When PURGE=TRUE, files that loaded successfully are deleted from the stage to avoid reprocessing and reduce storage.

36) Which statement about PUT and GET is correct?
A. They work for external and internal stages
B. They only work with internal stages (user, table, named)
C. They require a running warehouse
D. They automatically create file formats

Correct Answer: B

Explanation:
PUT/GET transfer between local and internal stages. For external locations, you interact via stages + COPY/Snowpipe rather than PUT/GET.

37) Which is a good practice for CSV loads to handle quotes in data?
A. Disable quoting
B. Use FIELD_OPTIONALLY_ENCLOSED_BY='"'
C. Use JSON instead
D. Use Parquet only

Correct Answer: B

Explanation:
Defining the quote character ensures fields containing delimiters or line breaks are parsed correctly.

38) How can you prevent duplicate loads when files are retried?
A. PURGE=FALSE
B. FORCE=TRUE
C. Rely on Snowflake’s load history; do not force unless reprocessing is intended
D. Use GET instead of COPY

Correct Answer: C

Explanation:
By default, Snowflake skips files found in load history. Use FORCE=TRUE only when you need to reload the same file.

39) Which metadata pseudo‑column helps identify the source file name during load or external table queries?
A. SYSTEM$FILE
B. METADATA$FILENAME
C. METADATA$PATHONLY
D. FILE_ID()

Correct Answer: B

Explanation:
When selecting from stages (or external tables), Snowflake exposes metadata columns like METADATA$FILENAME (and others such as METADATA$FILE_ROW_NUMBER) to help trace lineage.

40) To create a CSV file format that treats empty fields as NULL and skips headers, which is valid?
A.




SQL
CREATE FILE FORMAT my_csv TYPE=CSV;
B.




SQL
CREATE FILE FORMAT my_csv TYPE=CSV 
  SKIP_HEADER=1;
C.




SQL
CREATE FILE FORMAT my_csv TYPE=CSV 
  EMPTY_FIELD_AS_NULL=TRUE 
  NULL_IF=('') 
  SKIP_HEADER=1 
  FIELD_OPTIONALLY_ENCLOSED_BY='"';
D.




SQL
CREATE FILE FORMAT my_csv TYPE=CSV 
  STRIP_OUTER_ARRAY=TRUE;
Correct Answer: C

Explanation:
For CSV, you can combine EMPTY_FIELD_AS_NULL, NULL_IF, SKIP_HEADER, and FIELD_OPTIONALLY_ENCLOSED_BY to control empty string → NULL behavior, header handling, and quoting. STRIP_OUTER_ARRAY is a JSON option.