# \# Advanced Database Portfolio - MIT 8103

# 

# Case study: Savannah Trust Bank (simulated retail bank)

# Users: customers, tellers, auditors

# Main data: customers, branches, accounts, transactions, audit log

# Key operations: open account, deposit, withdraw, transfer, audit balances

# 

# \## Tools used

# \- PostgreSQL 18 (psql) for the relational parts

# \- MongoDB Atlas (AWS Cape Town, free tier) for the NoSQL part

# \- Git and GitHub for version control

# \- dbdiagram.io for the ER diagram

# 

# \## Contents

# | Folder | What it contains |

# |---|---|

# | portfolio-1-database-design | schema.sql, ER diagram, screenshots |

# | portfolio-2-query-optimisation | queries.sql, EXPLAIN ANALYZE screenshots before and after indexes |

# | portfolio-3-transactions-concurrency | transactions.sql, COMMIT, ROLLBACK and locking screenshots |

# | portfolio-4-nosql | mongodb\_queries.js, MongoDB Atlas screenshots |

# | portfolio-5-distributed-cloud | discussion file and Atlas replica set screenshot |

# 

# \## How to reproduce

# 1\. Create a database: CREATE DATABASE bankdb;

# 2\. Run portfolio-1-database-design/schema.sql

# 3\. Generate sample data (20,000 customers, 30,000 accounts, 300,000 transactions) using generate\_series

# 4\. Run the queries in portfolio-2-query-optimisation/queries.sql

# 5\. Run the demos in portfolio-3-transactions-concurrency/transactions.sql (use two psql windows for the concurrency demo)

# 6\. Use the filters and pipeline in portfolio-4-nosql/mongodb\_queries.js in MongoDB Atlas

# 

# \## Performance results (Portfolio 2)

# | Query | Before index | After index |

# |---|---|---|

# | Account lookup | 219.129 ms | 0.528 ms |

# | Date range | 128.859 ms | 2.997 ms |

# | Three-table join | 1.206 ms | 0.422 ms |

# 

# \## AI use declaration

# AI tool used: Claude (Anthropic).

# Used for: explaining concepts and suggesting example SQL and MongoDB scripts.

# Verification: I ran every script myself, checked the outputs and screenshots, and fixed errors as they occurred.

