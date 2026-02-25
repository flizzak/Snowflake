What is the purpose of network policies in Snowflake?
A. Encrypting stored data
B. Restricting allowed IP ranges for client access
C. Enabling replication
D. Monitoring compute usage
Correct Answer: B

2. Multi-Factor Authentication (MFA) in Snowflake provides:
A. Row-level access control
B. An additional authentication step beyond password
C. Automatically assigned roles
D. Network security scanning
Correct Answer: B

3. Snowflake federated authentication allows:
A. Automatic warehouse scaling
B. Users to authenticate through an external identity provider
C. Encryption key rotation
D. Native token generation
Correct Answer: B

4. Key pair authentication requires:
A. A username and database password
B. A private key stored locally
C. MFA validation
D. A Snowflake OAuth token
Correct Answer: B

5. Single Sign-On (SSO) in Snowflake enables:
A. Database load reduction
B. Connecting through the Snowflake SQL API
C. Logging in via an identity provider using SAML or OAuth
D. Automatic schema creation
Correct Answer: C

6. Snowflake uses which model for access control?
A. Discretionary Access Control (DAC) only
B. Role-Based Access Control (RBAC)
C. Password-Based Access Control
D. Object-Based Access Control only
Correct Answer: B

7. A privilege in Snowflake defines:
A. The type of data in a column
B. What actions a role can perform on an object
C. What IPs can access the account
D. Which warehouse runs a query
Correct Answer: B

8. Which command grants a privilege to a role?
A. SHARE PRIVILEGE
B. ALLOW PRIVILEGE
C. GRANT
D. ENABLE PRIVILEGE
Correct Answer: C

9. Revoking a privilege from a role is done using:
A. DELETE PRIVILEGE
B. REMOVE PRIVILEGE
C. REVOKE
D. DROP PRIVILEGE
Correct Answer: C

10. In Snowflake’s role hierarchy, privileges:
A. Do not inherit
B. Inherit upward (child → parent)
C. Inherit downward (parent → child roles)
D. Must be manually duplicated
Correct Answer: C

11. A Snowflake account belongs to:
A. A user
B. A single organization
C. Multiple organizations at once
D. A warehouse
Correct Answer: B

12. An organization in Snowflake manages:
A. Users and roles
B. All accounts and billing under one umbrella
C. Network rules
D. Databases only
Correct Answer: B

13. A secure view ensures that:
A. Data is replicated across regions
B. The underlying query logic is hidden
C. Network protection is enabled
D. Compute costs are lower
Correct Answer: B

14. Secure functions ensure:
A. Caching of results across sessions
B. The function’s definition is hidden
C. Tables auto‑cluster
D. Enhanced encryption of warehouses
Correct Answer: B

15. Information schema views provide:
A. Direct modification of metadata
B. Metadata about objects such as tables, schemas, and privileges
C. Real-time replication logs
D. Compute cost information only
Correct Answer: B

16. Access History helps track:
A. User password changes
B. Read and write activity on data objects
C. Virtual warehouse performance
D. Storage compression ratios
Correct Answer: B

17. Access History can be used to detect:
A. Micro-partition merges
B. Sensitive data access patterns
C. Warehouse auto-suspension
D. Stage file failures
Correct Answer: B

18. Row-level security allows Snowflake to:
A. Restrict which rows a user can query
B. Encrypt individual micro‑partitions
C. Auto-cluster data
D. Validate stages
Correct Answer: A

19. Column-level security is used to:
A. Mask or restrict access to specific columns
B. Partition tables
C. Create materialized views
D. Establish replication routes
Correct Answer: A

20. Object tags are used to:
A. Assign privileges
B. Label objects with metadata such as classification
C. Determine warehouse size
D. Block IP ranges
Correct Answer: B

21. Tags can be applied to which objects?
A. Only tables
B. Tables, columns, warehouses, and more
C. Only databases
D. Only internal stages
Correct Answer: B

22. Which authentication method provides the strongest protection against credential theft?
A. Username and password
B. Key pair authentication
C. IP whitelisting only
D. Warehouse impersonation
Correct Answer: B

23. Which Snowflake feature ensures that only authorized networks can connect?
A. MFA
B. Network policies
C. OAuth tokens
D. Temporary roles
Correct Answer: B

24. To enforce MFA for all users, an admin must:
A. Set a user policy
B. Enable account-level MFA
C. Modify warehouse access
D. Configure a storage integration
Correct Answer: B

25. What is the default access control behavior in Snowflake?
A. New objects inherit privileges automatically
B. All privileges must be explicitly granted
C. Users can read all tables by default
D. Only SYSADMIN can create roles
Correct Answer: B

26. Which role manages global account-level objects?
A. SYSADMIN
B. SECURITYADMIN
C. ORGADMIN
D. PUBLIC
Correct Answer: C

27. Secure views require:
A. Dedicated warehouses
B. SECURITYADMIN permissions
C. The SECURE keyword in view creation
D. Federated authentication enabled
Correct Answer: C

28. What does the USAGE privilege allow on a warehouse?
A. Running queries immediately
B. Suspending and resuming the warehouse
C. Referencing the warehouse in a session
D. Altering its size
Correct Answer: C

29. The ability to grant privileges to another role requires:
A. The OWNERSHIP privilege
B. The GRANT OPTION on that privilege
C. ORGADMIN rights
D. MFA to be enabled
Correct Answer: B

30. Which Snowflake object tracks who accessed which columns and when?
A. Information Schema
B. Access History
C. Data Marketplace logs
D. Query History only
Correct Answer: B