# 1. Multi‑Cluster Shared Data Architecture

**Snowflake separates storage and compute. How does this architecture allow independent scaling for high‑concurrency workloads?** <br>
Because storage is centralized in cloud object storage and compute is provided by fully independent virtual warehouses, clusters can scale up/down or add multi‑cluster nodes without copying or redistributing data. All compute layers access the same shared data concurrently.


**Which Snowflake service manages metadata, query optimization, authentication, and transaction consistency?** <br>
The Cloud Services Layer, which includes metadata services, optimizer, security services, and infrastructure management.


**A Resource Monitor is configured with a credit quota and a “Suspend Immediately” action. What happens when the credit threshold is reached?** <br>
All assigned warehouses are immediately suspended and cannot resume until either the quota resets or an authorized user manually increases the limit.

# 2. Virtual Warehouses & Clustering
**What is the main operational difference between manual clustering and automatic clustering?** <br>
Manual clustering requires the creation of a cluster key and explicit reclustering using warehouse compute, whereas Automatic Clustering is fully managed by Snowflake and uses background cloud services to maintain micro‑partition order.


**In what scenario might manual clustering provide better performance than automatic clustering?** <br>
For predictable, heavy analytical workloads where a highly specific clustering strategy is needed and the team wants granular cost control by triggering reclustering only at optimal times.


**Why do virtual warehouses not share caches across warehouses, even when accessing the same data?** <br>
Each warehouse has independent local SSD cache; caches are not shared to preserve isolation, concurrency performance, and predictable scaling behavior.

# 3. Databases & Schemas
**What does a fully-qualified Snowflake object name consist of, and which parts are mandatory?** <br>
<database>.<schema>.<object> — only <object> is mandatory (if the session has a current database and schema set).


**Explain how schema-level security helps limit blast radius during privilege grants.** <br>
Permissions can be granted at schema level, allowing developers access only within specific schemas while disallowing access to databases or other schemas, limiting unintended privilege inheritance.

# 4. Table Types
**What is the key difference between permanent and transient tables regarding Fail‑safe?**<br>
Permanent tables include Fail‑safe protection (7 days). Transient tables do not include Fail‑safe and only use Time Travel retention.

**Why might temporary tables reduce storage costs in long-running ETL pipelines?**<br>
They exist only within a session, skip Fail‑safe entirely, and automatically drop at session end, minimizing long-term storage cost accumulation.

**Can a transient table be cloned with full Time Travel history?**<br>
Yes, as long as the table is within its Time Travel retention window. However, the clone also inherits no Fail‑safe protection.

# 5. Time Travel & Fail‑safe
**If a table has a Time Travel retention of 1 day, but a user drops it, how long is the table recoverable?**<br>
For 1 day under Time Travel, plus 7 additional days in Fail‑safe (if it’s a permanent table).


**Why can Fail‑safe recovery only be performed by Snowflake and not customers?**<br>
Fail‑safe relies on internal Snowflake metadata operations and immutable storage snapshots that Snowflake controls to ensure consistency and security.


**Does extending Time Travel retention increase query performance impact?**<br>
No; Time Travel relies on micro‑partition versioning in metadata. Performance is unaffected; only storage consumption increases.

# 6. Views (Non-Materialized, Materialized, Secure)
**How does Snowflake ensure a Secure View protects underlying query logic?**<br>
Secure Views are executed only through the result set sent to the consumer; Snowflake obscures the underlying SQL and disables query history exposure of sensitive logic.

**Why do Materialized Views incur additional storage costs?**<br>
Because Snowflake stores pre‑computed results in physically materialized micro‑partitions, which must be maintained and refreshed as base tables change.

**Which type of view is most appropriate for low-latency dashboards with repeatable queries over large stable datasets?**<br>
Materialized Views, due to pre‑computation and reduced need for runtime aggregation.


**What limitation applies to Materialized Views regarding base table columns?**<br>
They cannot include the following in SELECT:
* wildcard
Non-deterministic functions
Unsupported joins/expressions that impede incremental refresh


**Can a Materialized View be created on top of another Materialized View?**<br>
No, Snowflake does not allow chaining Materialized Views due to maintenance complexity and refresh dependency restrictions.


**When using Secure Views, what is a potential performance drawback?**<br>
Secure Views can prevent certain optimizations (e.g., predicate pushdown) because Snowflake must preserve data obfuscation, increasing query compute cost.

# 7 Stages
**What is the difference between an internal named stage and a table stage, and when would you choose each?**
* Internal Named Stage
    * Created explicitly via CREATE STAGE
    * Can store multiple files and folders
    * Useful for reusable loading/unloading logic

* Table Stage

    * Automatically created per table
    * Accessed via @%table_name
    * Used for quick, table‑specific loading tasks
    * Choose named stages for complex or shared workflows; choose table stages for simple, table-bound file operations.

**How does Snowflake determine file metadata when loading from an external stage?**

Snowflake pulls metadata (size, ETag, last modified timestamp) directly from the external storage provider (AWS/Azure/GCP). This metadata is used for:

* File change detection
* Deduplication using LOAD_HISTORY
* Snowpipe event notifications and auto-ingest logic

**What happens when you specify ENCRYPTION = (TYPE = NONE) for an internal stage?**

You cannot set encryption to NONE. All internal stages require Snowflake-managed encryption using AES‑256 keys. Encryption is mandatory and not user-configurable.

# 8 Loading & Unloading

**When unloading data with COPY INTO @stage, how does Snowflake determine file partitioning?**

By default, Snowflake produces multiple files based on:

* The size of the micro-partitions scanned
* Degree of parallelism available
* Using MAX_FILE_SIZE allows fine control, but exact file count cannot be forced except by using a single warehouse cluster and large file sizing.

**What is the effect of using HEADER = TRUE when unloading to CSV?**

Snowflake includes a single header line per file, not per unload operation. If multiple files are produced, each file gets its own header line.

**Why might unloading to Parquet produce fewer files than CSV?**
Parquet is columnar and compresses much more efficiently. Snowflake’s Parquet writer targets larger block sizes, often reducing file count vs. row-based formats like CSV.

**How does Snowflake ensure idempotency when loading files via COPY INTO?**

Snowflake logs file metadata in LOAD_HISTORY. A file with the same name, size, and ETag cannot be reloaded unless:

* FORCE = TRUE is used
* Files are moved/renamed
* The table is truncated (resetting history)

**What is the difference between MATCH_BY_COLUMN_NAME = CASE_SENSITIVE and MAP_BY_NAME?**

* **MATCH_BY_COLUMN_NAME**: Matches staged file columns to table columns
* **MAP_BY_NAME**: Specific to variant/object loading (e.g., JSON), maps keys to target table columns
They serve different purposes: file-column mapping vs object-key mapping.

**What happens if a file contains malformed CSV data and ON_ERROR = SKIP_FILE is used?**
* The entire file is skipped, not individual rows.
* It is logged as an error in LOAD_HISTORY with zero rows loaded.

# 9 Snowpipe
**How does Snowpipe guarantee exactly‑once loading when ingestion is based on event notifications?**
Events only trigger ingestion. <br>
Actual deduplication is achieved using Snowflake’s file metadata checks in the target table’s LOAD_HISTORY, ensuring the same file cannot be loaded twice.

**What factors impact Snowpipe auto-ingest latency?**
* Cloud provider event delivery time
* Snowpipe queue processing
* Number of files and their sizes
* Event batch size behavior (AWS sends batched events)
* Typical latency: seconds to minutes.

**Can Snowpipe load files from internal stages? Why or why not?**
No.
Snowpipe supports only external stages (S3, GCS, Azure Blob).
Internal stages do not emit cloud provider events needed for auto-ingest.

# 10 Streams
**What is the difference between an append-only stream and a standard stream?**
* Append-only stream:
    * Captures only inserted rows
    * No update or delete tracking
* Standard stream:
    * Captures inserts, updates, deletes
    * Provides metadata columns: METADATA$ACTION, METADATA$ISUPDATE

**How does Snowflake handle stream offsets when the underlying table is truncated?**
Truncation generates delete events in a standard stream.
For append-only streams, truncation invalidates the stream, requiring recreation.

**What happens when two consumers read from the same stream?**
Streams do not support shared consumption.
A stream’s offset advances once read, meaning:
* First consumer gets all change data
* Second consumer gets nothing
* Use multiple streams only if multiple consumers are needed.

# 11 UDFs & StoreProcedures
**What is a performance difference between SQL UDFs and JavaScript UDFs?**
SQL UDFs are significantly faster and should be preferred unless custom logic requires JS.
* SQL UDFs are inlined and optimized by Snowflake’s query compiler
* JavaScript UDFs run in a sandboxed engine

**Why can UDFs not perform DML operations?**
UDFs must be deterministic and side-effect free.
This allows Snowflake to:

* Optimize queries
* Cache results
* Parallelize evaluation
* DML or external calls would violate determinism.

**Why are stored procedures required for multi-statement logic instead of scripting SQL queries?**
Stored procedures allow:
* Conditional logic (IF, FOR, WHILE)
* Exception handling
* Dynamic SQL
* They support full procedural control flow, which SQL alone does not offer.

**How does Snowflake handle transactions inside JavaScript stored procedures?**
A stored procedure runs inside a single implicit transaction unless:
* AUTOCOMMIT is enabled
* Transactions are explicitly started/committed via snowflake.execute()
* Uncommitted work is rolled back if an error occurs.

**When should you use a stored procedure instead of a UDF?**
Use a stored procedure when:
* You need multi-step logic
* You must execute DML
* You need loops or branching
* You require dynamic SQL
Use a UDF when:
* You need a reusable function inside a query
* Logic must be deterministic
* You want inlined performance


1. Which function is commonly used to expand arrays in semi‑structured data?
A. PARSE_JSON
B. FLATTEN ✅
C. DECODE
D. TO_VARIANT
Explanation:
FLATTEN turns array elements (or object key/value pairs) into rows so you can join or aggregate them. PARSE_JSON parses text into VARIANT; TO_VARIANT casts a value; DECODE is unrelated to semi‑structured expansion.

2. When querying JSON using column:key::STRING, what happens if the key does not exist?
A. Query fails with an error
B. Returns NULL ✅
C. Returns an empty string
D. Returns {}
Explanation:
Snowflake’s semi‑structured accessors are nullable. When a path does not exist, the cast (::STRING, etc.) yields NULL, not an error. Empty string or {} would imply the key exists with an empty value/object.

3. Which Snowflake data type is required to store semi‑structured formats such as JSON or Avro?
A. OBJECT
B. ARRAY
C. VARIANT ✅
D. TEXT
Explanation:
VARIANT is the catch‑all type for semi‑structured data (JSON, Avro, Parquet). OBJECT and ARRAY are valid subtypes within VARIANT but don’t replace VARIANT for ingest/storage.

4. How does Snowflake optimize query performance on semi‑structured data?
A. Compresses JSON into text files
B. Creates hidden metadata for variant fields ✅
C. Converts semi‑structured data into binary blobs
D. Automatically flattens nested objects into tables
Explanation:
Snowflake extracts and maintains micro‑partition metadata (column statistics, path pruning, etc.) to accelerate queries over VARIANT without requiring schema‑on‑write. It does not auto‑flatten to relational tables.

5. Which feature allows Snowflake to preview and query unstructured data such as images and PDFs?
A. External Tables
B. File Format Wrappers
C. Snowflake Document AI
D. Directory Tables ✅
Explanation:
Directory tables provide metadata views over files in stages (including unstructured). They let you list and reference file objects and integrate with functions/UDFs for processing. External Tables target structured/semi‑structured files (e.g., Parquet/CSV), not binary content.

2) Configure Storage Integrations
6. What is the primary purpose of a Snowflake storage integration?
A. Manage Snowflake warehouses
B. Secure cloud storage access without user credentials ✅
C. Convert file formats before loading
D. Automate Snowpipe ingestion
Explanation:
Storage integrations encapsulate cloud credentials/config (IAM role/SP/service account) so users don’t handle secrets directly, enabling secure access to S3/Azure Blob/GCS. They don’t manage warehouses or transform files.

7. When configuring an S3 storage integration, which Snowflake‑generated value must be added to the IAM policy?
A. Stage URL
B. External ID ✅
C. Master Key
D. Network rule ARN
Explanation:
For AWS, Snowflake uses IAM role assumption. To prevent the confused‑deputy problem, AWS best practice requires an External ID in the role trust policy that Snowflake provides.

8. What does the STORAGE_ALLOWED_LOCATIONS parameter enforce?
A. Limits which tables can load data
B. Limits which roles access stages
C. Limits which cloud paths Snowflake can access ✅
D. Limits the number of files Snowflake can read
Explanation:
STORAGE_ALLOWED_LOCATIONS is a path allow‑list (e.g., specific S3 prefixes). It constrains which bucket paths the integration can access, reducing blast radius.

9. Which step is required to allow Snowflake to access Azure Blob Storage?
A. Create an AWS assume role
B. Add Snowflake’s service principal to the ACL ✅
C. Bind a GCP service account
D. Set a storage encryption key
Explanation:
For Azure, you grant Snowflake’s service principal appropriate permissions on the storage account/container (e.g., via RBAC or Access Policies). AWS/GCP options don’t apply here.

3) SnowSQL, Snowsight, Drivers
10. Which tool is best for automating scheduled Snowflake scripts?
A. Snowsight
B. SnowSQL ✅
C. ODBC Driver
D. Snowflake Marketplace
Explanation:
SnowSQL (the CLI) is ideal for automation in CI/CD or cron, supports scripting, environment variables, and non‑interactive auth. Snowsight is browser‑based and manual; drivers are programmatic interfaces, not schedulers.

11. Which interface provides the most advanced visualization and worksheet environment?
A. SnowSQL
B. Snowsight ✅
C. JDBC Client
D. Python Driver
Explanation:
Snowsight offers worksheets, charts, dashboards, result caching visualization, and admin UIs. SnowSQL and drivers are code/CLI oriented.

12. Which connection method is most appropriate for BI tools such as Tableau or Power BI?
A. SnowSQL
B. ODBC/JDBC Drivers ✅
C. Snowsight
D. Native App Framework
Explanation:
BI tools use ODBC/JDBC for standardized connectivity, query pushdown, and authentication integration. SnowSQL/Snowsight aren’t designed as BI sources.

13. What must be provided when connecting via the Python Connector?
A. Stage authentication token
B. URL, account, warehouse, and key/password ✅
C. Virtual warehouse filesystem
D. Azure CLI credentials
Explanation:
The Python Connector requires Snowflake account identifier, user auth (password or key‑pair/OAuth), and optionally warehouse, database, schema, role. No stage tokens or cloud‑CLI creds are needed.

4) Implement Streams, Tasks, Zero‑Copy Cloning
14. What does a stream track on a base table?
A. External data files
B. Permissions
C. DML changes ✅
D. Storage usage
Explanation:
Streams provide change data capture (CDC)—inserts/updates/deletes since the last consumption point—using hidden metadata and offsets.

15. Which metadata columns appear in standard streams?
A. METADATA$TABLE_SIZE
B. METADATA$FILE_NAME
C. METADATA$ACTION ✅
D. METADATA$WAREHOUSE
Explanation:
Standard streams surface METADATA$ACTION (INSERT/DELETE) and METADATA$ISUPDATE among others. File/warehouse/table‑size metadata are not per‑row CDC attributes.

16. A task is configured with AFTER STREAM. What happens?
A. Runs on a fixed schedule
B. Runs only if the stream has new changes ✅
C. Must be manually triggered
D. Runs once and disables itself
Explanation:
Tasks can be set to run conditionally when a stream has unread changes (event‑driven). Otherwise, tasks run on a schedule or dependency chain.

17. Under which condition will a zero‑copy clone consume additional storage?
A. When created in a different region
B. When DML modifies data in the clone or source ✅
C. When read
D. When the clone contains semi‑structured data
Explanation:
Zero‑copy clones initially point to the same micro‑partitions. New storage is only consumed as divergent changes occur (copy‑on‑write). Reads don’t create new storage.

5) Multi‑Cloud Strategy
18. Which Snowflake feature allows secure sharing of live data across AWS, Azure, and GCP?
A. Replication Failover
B. Snowpipe Streaming
C. Cross‑Cloud Secure Data Sharing ✅
D. Data Marketplace
Explanation:
Secure Data Sharing enables live, read‑through sharing to consumer accounts, including cross‑cloud via Snowflake’s global services layer—no copying or ETL required. Marketplace is a publishing venue, not the mechanism itself.

19. Which architectural principle enables Snowflake to function consistently across clouds?
A. Shared‑Disk
B. Shared‑Nothing ✅
C. Hybrid Mesh
D. Unified Query Gateway
Explanation:
Snowflake is a shared‑nothing architecture (separate elastic compute clusters over centralized cloud storage) implemented consistently across AWS/Azure/GCP, enabling predictable behavior regardless of provider.

20. Which capability supports cross‑region and cross‑cloud disaster recovery?
A. Zero‑copy cloning
B. Data Exchange
C. Replication & Failover Groups ✅
D. Materialized views
Explanation:
Replication & Failover/Failback groups replicate databases/objects across regions and clouds and manage controlled cutover for Disaster Recovery. Zero‑copy clones are local and don’t replicate data across regions/clouds.



