1) What is the default Time Travel retention for permanent tables in Snowflake (unless changed)?
A. 0 days
B. 1 day
C. 7 days
D. 90 days
Correct Answer: B
Explanation:
Permanent tables default to 1 day Time Travel, configurable up to 90 days (edition‑dependent). Transient and temporary tables support 0–1 day only. Time Travel enables querying historical data, cloning at a point in time, and UNDROP for dropped objects.

2) Which object type supports Fail-safe?
A. Temporary tables only
B. Transient tables only
C. Permanent tables only
D. All tables
Correct Answer: C
Explanation:
Fail-safe (7 days) is only for permanent objects. It’s a last‑resort recovery window managed by Snowflake after Time Travel expires. Transient and temporary objects do not have Fail-safe.

3) Which command can recover a dropped table during the Time Travel window?
A. ROLLBACK TABLE
B. UNDROP TABLE ;
C. RESTORE TABLE ;
D. RECOVER TABLE ;
Correct Answer: B
Explanation:
Use UNDROP TABLE (and UNDROP SCHEMA/DATABASE) within the Time Travel retention. You can also query historical data with AT | BEFORE clauses, or clone at a past timestamp.

4) Which operation relies on Time Travel metadata to create objects without copying data immediately?
A. Replication
B. Failover
C. Zero‑copy cloning
D. Vacuuming
Correct Answer: C
Explanation:
Cloning leverages metadata pointers and Time Travel. The clone initially shares the same micro‑partitions; new/changed data is stored separately, making cloning fast and storage‑efficient.

5) Which statement best describes Snowflake encryption?
A. Optional at-rest encryption
B. Always‑on encryption in transit (TLS) and at rest, with hierarchical key management and automatic rotation
C. Only file‑level encryption
D. User‑managed only
Correct Answer: B
Explanation:
Snowflake provides end‑to‑end encryption: in transit via TLS, at rest via a hierarchical key model (root/account/database/table/micro‑partition) with automatic key rotation. Business Critical offers features such as Tri‑Secret Secure (customer‑managed key + Snowflake key).

6) Which is true about cloning semantics across object types?
A. Only tables can be cloned
B. Only empty objects can be cloned
C. Databases, schemas, tables, and other objects can be cloned; the result is a zero‑copy, point‑in‑time snapshot
D. Clones are full data copies immediately
Correct Answer: C
Explanation:
You can clone at the database, schema, or table level (and some other objects). Clones are instant and do not copy data at creation; only deltas accrue storage later.

7) What happens to DML on a clone vs. the source after cloning?
A. All changes propagate both ways
B. Changes propagate only from source to clone
C. Changes propagate only from clone to source
D. Changes are isolated; each object diverges independently
Correct Answer: D
Explanation:
After creation, source and clone are independent. Subsequent writes in one do not affect the other. That’s why clones are great for sandboxing and testing.

8) Which statement about Fail-safe cost is accurate?
A. Fail-safe storage is free
B. Fail-safe may incur charges and is for Snowflake‑managed recovery, not self‑service
C. Fail-safe replaces Time Travel
D. Fail-safe can be disabled per table
Correct Answer: B
Explanation:
Fail-safe exists for catastrophic recovery and may incur cost. It’s not a customer‑driven recovery tool, unlike Time Travel features (e.g., UNDROP, time‑based queries, point‑in‑time clone).

9) What is replicated when you configure cross‑region replication for a database?
A. Only table metadata
B. Only views
C. Nothing; replication is for accounts only
D. Data and metadata required to query the database on a secondary
Correct Answer: D
Explanation:
Database replication copies the data and metadata so a secondary can be promoted or used for read workloads (depending on configuration). Schedules can be manual or automatic.

10) Failover groups are used to:
A. Encrypt data at rest
B. Bundle multiple databases, shares, roles, etc., for coordinated replication and failover between accounts/regions
C. Manage user SSO
D. Replace tasks and streams
Correct Answer: B
Explanation:
Failover groups package objects (e.g., databases, grants, shares) to replicate and promote a secondary set in a target region/account as a new primary in disaster scenarios.

11) Which is true about RTO/RPO with Snowflake replication?
A. Fixed by Snowflake
B. Depends on your replication frequency/schedule and data change rate
C. RTO is always zero
D. RPO equals Fail-safe window
Correct Answer: B
Explanation:
Recovery Time Objective (RTO) and Recovery Point Objective (RPO) are determined by how frequently you replicate and how quickly you can promote the secondary (plus networking and governance factors).

12) Which of the following is not an account type in secure data sharing context?
A. Provider account
B. Consumer account
C. Optimizer account
D. Reader account
Correct Answer: C
Explanation:
In sharing:

Provider: publishes data (direct shares or listings).
Consumer: receives data (must have Snowflake).
Reader: provider‑managed Snowflake account for consumers without their own Snowflake subscription.


13) Who pays for compute when a Consumer queries shared data?
A. Consumer (their warehouse or serverless)
B. Provider only
C. Split 50/50
D. Reader account never pays
Correct Answer: A
Explanation:
Consumers use their own compute (or serverless usage they incur). For reader accounts, compute is billed to the provider who owns those reader accounts.

14) What is a “direct share”?
A. A Marketplace product
B. An external table
C. A secure share granted directly to one or more target accounts
D. A reader account
Correct Answer: C
Explanation:
Direct shares allow a provider to grant specific objects to specific consumer accounts without moving or copying data (it’s zero‑copy access).

15) Which DDL sequence is typical for creating and populating a secure share?
A. CREATE SHARE → GRANT OWNERSHIP TO SHARE → ADD ACCOUNT
B. CREATE SHARE → GRANT USAGE ON DATABASE/SCHEMA TO SHARE → GRANT SELECT ON TABLES/SECURE VIEWS TO SHARE → ALTER SHARE ... ADD ACCOUNTS
C. CREATE SHARE → COPY INTO SHARE
D. CREATE SHARE → ALTER DATABASE SET SHARE=TRUE
Correct Answer: B
Explanation:
Core pattern:

CREATE SHARE my_share;
GRANT USAGE ON DATABASE db TO SHARE my_share;
GRANT USAGE ON SCHEMA db.schema TO SHARE my_share;
GRANT SELECT ON TABLE db.schema.t TO SHARE my_share;
ALTER SHARE my_share ADD ACCOUNT = <consumer_account>;


16) Which privilege is required to create a share?
A. OWNERSHIP on database
B. USAGE on schema
C. CREATE SHARE (account‑level global privilege)
D. MANAGE GRANTS
Correct Answer: C
Explanation:
A role must have the global CREATE SHARE privilege (typically ACCOUNTADMIN or a delegated role). To add objects to a share, the role must also have sufficient privileges (e.g., OWNERSHIP or granted rights on those objects).

17) Which objects can be included in a secure share?
A. Only tables
B. Tables and non‑secure views
C. Tables, secure views, secure materialized views, and (in supported cases) secure UDFs
D. Warehouses
Correct Answer: C
Explanation:
Only secure versions of views/UDFs/materialized views are shareable. Non‑secure variants are not shareable because their definitions may expose metadata.

18) What does a Consumer do to access a direct share?
A. ALTER SHARE ... ACCEPT
B. Create a database from the share (e.g., CREATE DATABASE cons_db FROM SHARE provider_acct.my_share;)
C. Restore data into their account
D. Clone the provider schema
Correct Answer: B
Explanation:
Consumers create a database from the received share. The data remains in the provider’s account/storage; the consumer queries via zero‑copy access.

19) What is a Data Listing (Marketplace listing)?
A. A private schema export
B. A productized, discoverable listing that exposes data via secure sharing; can be public (Marketplace) or private (Data Exchange)
C. A replication container
D. An ETL job template
Correct Answer: B
Explanation:
Listings allow providers to publish offerings with terms, regions, and entitlements. Consumers “get” the listing, and Snowflake provisions the share behind the scenes.

20) What’s a key difference between Snowflake Marketplace and a Private Data Exchange?
A. Marketplace is only for CSV; Exchange is for Parquet
B. Marketplace is public (broad reach); Data Exchange is private and curated for a specific community/org
C. Marketplace requires reader accounts
D. Data Exchange is read‑only while Marketplace is not
Correct Answer: B
Explanation:
Marketplace targets public discovery. Data Exchange serves specific groups (e.g., internal business units or partners) with curated access and governance.

21) Which statement about cross‑region/cross‑cloud secure data sharing is accurate?
A. Not supported
B. Only with data copying
C. Supported via Snowflake‑managed cross‑region/cross‑cloud sharing/replication without copying data to the consumer
D. Requires exporting to files
Correct Answer: C
Explanation:
Snowflake enables cross‑region/cloud sharing through its architecture; consumers query without data movement to their storage.

22) Which role typically administers sharing at the account level?
A. SYSADMIN only
B. SECURITYADMIN only
C. ACCOUNTADMIN (or a custom role with CREATE SHARE and required object privileges)
D. ORGADMIN only
Correct Answer: C
Explanation:
ACCOUNTADMIN is the default high‑privilege role with global rights (including CREATE SHARE). Organizations often delegate via custom roles following least privilege.

23) Which SQL clause allows querying a table “as of” a past timestamp?
A. WITH TIME =
B. BEFORE STATEMENT =
C. AT | BEFORE
D. USING TIME TRAVEL
Correct Answer: C
Explanation:
Examples:
SQL-- Query as of a timestampSELECT * FROM t AT (TIMESTAMP => '2026-02-20 12:00:00');-- Query as of a statement IDSELECT * FROM t BEFORE (STATEMENT => '01a1b-...-xyz');Show more lines

24) Which is true about sharing costs for a Reader account?
A. Consumer pays
B. Split billing
C. Provider pays compute for Reader accounts (since the provider owns them)
D. No one pays
Correct Answer: C
Explanation:
Reader accounts are provider‑owned Snowflake accounts for consumers without Snowflake. The provider pays the compute for queries run in reader accounts.

25) Which command adds a Consumer account to a share?
A. GRANT TO ACCOUNT
B. ADD CONSUMER
C. ALTER SHARE my_share ADD ACCOUNT = '<account_locator_OR_url_name>';
D. CREATE SHARE ... WITH ACCOUNT
Correct Answer: C
Explanation:
Typical operation:
SQLALTER SHARE my_share ADD ACCOUNT = 'xy12345';``Show more lines
(You can also remove accounts with ALTER SHARE ... REMOVE ACCOUNT = ....)

26) Which privileges must be granted to a share to expose a table in a schema?
A. SELECT on table only
B. USAGE on database → USAGE on schema → SELECT on table (and SECURE for views/MVs/UDFs)
C. OWNERSHIP on table
D. MONITOR on warehouse
Correct Answer: B
Explanation:
A consumer must have a privilege path:

GRANT USAGE ON DATABASE db TO SHARE s;
GRANT USAGE ON SCHEMA db.schema TO SHARE s;
GRANT SELECT ON TABLE db.schema.t TO SHARE s;


27) Which statement is correct about masking/row access in shares?
A. Policies are ignored in shares
B. Policies (e.g., masking, row access) apply to shared objects; secure views are recommended to encapsulate logic and hide definitions
C. Only applies to internal users
D. Must be disabled to share data
Correct Answer: B
Explanation:
Data governance policies continue to enforce controls for consumers. Secure views/UDFs can protect logic and limit exposure.

28) Which is true about promoting a secondary database in failover?
A. Requires data export/import
B. A designated secondary can be promoted to primary on the target account/region; after promotion, writes occur there
C. Only read queries are allowed always
D. Failover is automatic in all editions
Correct Answer: B
Explanation:
Promotion switches the primary role to the secondary copy. Future writes target the promoted primary until you fail back as needed.

29) Which best practice helps control access & auditability for sharing at scale?
A. Use PUBLIC role
B. Use dedicated provider roles for shares; tag objects and use grants to share; monitor with ACCOUNT_USAGE views
C. Use ACCOUNTADMIN for all operations
D. Put all objects in one share
Correct Answer: B
Explanation:
Follow least privilege: define provider roles, tag shared objects for cost/lineage, and monitor with views like SNOWFLAKE.ACCOUNT_USAGE.GRANTS_TO_SHARES, LOGIN_HISTORY, and share/replication history views.

30) Which statement about Marketplace listings vs direct shares is accurate?
A. Direct shares provide discovery and entitlement workflow
B. Listings provide discovery, request/entitlement flows, and automated provisioning; direct shares are point‑to‑point grants
C. Listings require data copy to the consumer
D. Direct shares are not secure
Correct Answer: B
Explanation:
Listings support discovery, request, and automated grant workflows (public Marketplace or private Exchange). Direct shares are explicit, point‑to‑point grants from a provider to one/more consumer accounts.