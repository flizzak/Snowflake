1. What does an EXPLAIN plan primarily display?
A. Result cache usage
B. Logical operations used to execute a query
C. SQL rewrite suggestions
D. Micro-partition statistics
Correct Answer: B

2. Data spilling occurs when:
A. Virtual warehouses are suspended
B. A query exceeds memory and writes temporary data to remote storage
C. Writing to stages fails
D. Caching is disabled
Correct Answer: B

3. The warehouse data cache accelerates queries by:
A. Rewriting SQL
B. Storing micro-partitions previously read from storage
C. Compressing the result set
D. Increasing virtual warehouse size
Correct Answer: B

4. Micro-partition pruning improves performance by:
A. Compressing partitions
B. Skipping partitions that do not match filter predicates
C. Splitting partitions into smaller blocks
D. Scaling up the warehouse automatically
Correct Answer: B

5. Query History helps users:
A. Track cost attribution only
B. View query execution details, performance, and errors
C. Rebuild corrupted tables
D. Change warehouse configurations
Correct Answer: B

6. A multi-cluster warehouse is typically used to:
A. Reduce credit usage
B. Automatically adjust compute to handle concurrency spikes
C. Improve time-travel queries
D. Replicate data
Correct Answer: B

7. In multi-cluster warehouses, the “Auto-scale” policy means:
A. All clusters stay active at all times
B. Clusters start and stop based on workload demand
C. Only minimum clusters run
D. Manual intervention is required
Correct Answer: B

8. “Maximized” scaling mode means:
A. Only one cluster runs at a time
B. All clusters stay running for maximum throughput
C. Clusters scale only during off-peak hours
D. Queries bypass the warehouse
Correct Answer: B

9. Warehouse sizing should be based primarily on:
A. Number of tables
B. Query complexity and volume
C. Number of schemas
D. Storage cost
Correct Answer: B

10. The ability to set warehouse auto-suspend helps:
A. Reduce storage cost
B. Reduce compute cost by pausing when idle
C. Encrypt micro-partitions
D. Improve network security
Correct Answer: B

11. Monitoring warehouse load can be done using:
A. Stages
B. Query History & Warehouse Load Charts
C. Information Schema only
D. Tags
Correct Answer: B

12. Scaling up a warehouse means:
A. Adding more clusters
B. Increasing the warehouse size (XS→S→M→L…)
C. Increasing the number of queries allowed
D. Reducing credit consumption
Correct Answer: B

13. Scaling out a warehouse means:
A. Increasing credit limits
B. Adding clusters in a multi-cluster warehouse
C. Increasing result cache size
D. Adding new databases
Correct Answer: B

14. Query Acceleration Service (QAS) is used for:
A. Automatically optimizing joins
B. Reducing latency on large, complex queries by adding ephemeral compute
C. Enabling secure data sharing
D. Compressing storage
Correct Answer: B

15. Materialized views improve performance by:
A. Caching the result of a complex query
B. Replacing the base table
C. Acting like standard views
D. Reducing storage costs
Correct Answer: A

16. SELECT … WITH clause is used for:
A. Creating temporary tables
B. Defining common table expressions (CTEs)
C. Partitioning data
D. Clustering tables
Correct Answer: B

17. Clustering is most beneficial when queries include:
A. Full table scans
B. Highly selective filters
C. Random access patterns
D. Only joins
Correct Answer: B

18. Search Optimization Service helps:
A. Speed up selective point-lookups without scanning micro-partitions
B. Improve warehouse caching
C. Replace clustering keys
D. Reduce storage size
Correct Answer: A

19. Persisted query results occur when:
A. Snowflake stores result sets in the result cache
B. Queries are fully rewritten
C. Warehouses run in multi-cluster mode
D. Queries fail
Correct Answer: A

20. Metadata cache impacts performance by:
A. Storing data in memory
B. Holding micro-partition statistics used for pruning
C. Compressing stages
D. Accelerating replication
Correct Answer: B

21. The result cache provides:
A. Reuse of results for identical queries from any user
B. Query compilation benefits
C. Cost reduction for stored results
D. Partition-level statistics
Correct Answer: A

22. The warehouse cache stores:
A. Query plans
B. Data read from cloud storage during execution
C. Role metadata
D. Security policies
Correct Answer: B

23. Materialized views incur cost primarily for:
A. User authentication
B. Automatic maintenance and refresh
C. Network bandwidth
D. Clustering
Correct Answer: B

24. Snowsight Cost Insights helps you:
A. View network policies
B. Understand compute, storage, and feature charges
C. Modify data retention policies
D. Disable warehouses
Correct Answer: B

25. Permanent tables cost more because:
A. They use more compute
B. They support long-term Time Travel and Fail-safe
C. They have larger micro-partitions
D. They auto-cluster
Correct Answer: B

26. Views incur additional cost when:
A. They reference external stages
B. They require compute every time they’re queried
C. They are secure
D. They are nested
Correct Answer: B

27. Search optimization paths increase:
A. Storage consumption
B. Network costs
C. Result cache hit rates
D. Warehouse suspension time
Correct Answer: A

28. Storage costs in Snowflake are based on:
A. Number of users
B. Compressed storage size
C. Virtual warehouse size
D. Network usage
Correct Answer: B

29. Compute costs in Snowflake are based on:
A. Number of queries
B. Credits used by warehouses and serverless features
C. Table count
D. Network egress
Correct Answer: B

30. Cloud services costs are associated with:
A. Metadata operations and transaction management
B. Virtual warehouse resizing
C. Stage creation
D. Stream maintenance
Correct Answer: A

31. Serverless feature costs depend on:
A. Warehouse size
B. Actual compute seconds consumed
C. Storage tier
D. Region count
Correct Answer: B

32. Data replication across regions may increase cost due to:
A. Query acceleration
B. Cross-region data transfers
C. Caching
D. Stored procedures
Correct Answer: B

33. Failover groups incur extra cost because:
A. They require dedicated warehouses
B. Replicated objects must be synchronized
C. They reduce compression
D. They increase query latency
Correct Answer: B

34. Resource monitors can:
A. Automatically delete data
B. Suspend warehouses when credit thresholds are reached
C. Increase cluster count
D. Refresh materialized views
Correct Answer: B

35. Snowflake Budgets allow you to:
A. Predictively autoscale
B. Track and alert on spending by categories
C. Enforce row-level security
D. Lock databases
Correct Answer: B

36. Cost attribution can be enhanced using:
A. Row access policies
B. Object tags assigned to warehouses, databases, and tables
C. Temporary schemas
D. Result caching
Correct Answer: B

37. ACCOUNT_USAGE views are used to:
A. Change billing
B. Analyze historical compute, storage, and query activity
C. Rewrite SQL automatically
D. Create secure functions
Correct Answer: B

38. A large warehouse is typically recommended for:
A. Concurrency issues
B. Compute-heavy queries needing more memory and CPU
C. Storage retrieval
D. Replication
Correct Answer: B

39. A multi-cluster small warehouse vs. a single large warehouse:
A. Costs less no matter what
B. Handles concurrency better
C. Always runs faster
D. Uses less storage
Correct Answer: B

40. Search Optimization should be used when queries:
A. Perform broad scans
B. Frequently filter on highly selective columns
C. Avoid WHERE clauses
D. Include only joins
Correct Answer: B