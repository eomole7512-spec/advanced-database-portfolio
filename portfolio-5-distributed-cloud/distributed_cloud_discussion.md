# Portfolio 5: Distributed and Cloud Database

Case study: Savannah Trust Bank (simulated retail bank)

## 1. Deployment evidence
The bank's NoSQL data (customer profiles) runs on MongoDB Atlas, a cloud database service.
- Provider and region: AWS, Cape Town (af-south-1)
- Cluster: Cluster0, free tier (M0), MongoDB version 8.0.37
- Type: Replica Set with 3 nodes
- Screenshot: Screenshot/p5_atlas_replica_set.png

## 2. Replication
A replica set keeps copies of the same data on 3 servers: one primary (accepts writes)
and two secondaries (copy the primary). If the primary fails, the secondaries elect a
new primary automatically. For a bank this means customer profiles stay available
even if one server fails.

## 3. Availability and consistency (CAP theorem)
A distributed database cannot guarantee Consistency, Availability and Partition
tolerance all at once. During a network partition it must favour one.
- Money movement (balances, transfers) needs consistency, so the bank keeps this in
  PostgreSQL with ACID transactions (Portfolio 3).
- Customer profiles can tolerate brief delays between copies, so MongoDB's replica
  set, which favours availability, is suitable.

## 4. Sharding (design proposal)
Sharding splits one large collection across several servers. This was not
implemented, because the free tier does not support it, but a proposed design is:
- Shard key: customer region (for example Lagos, Kano, Abuja), or a hashed customer_id.
- Benefit: each shard holds fewer customers, so queries are faster and storage can grow.
- Trade-off: queries that cover all regions must contact every shard.

## 5. Limitations of this setup
- Backups are inactive on the free tier. A production bank would enable backups
  and disaster recovery in a second region.
- The PostgreSQL part runs on a single local server. In production it would use
  primary-replica replication.