// Portfolio 4: NoSQL (MongoDB Atlas)
// Database: bankdb_nosql   Collection: customers

// Document structure (accounts and profile are EMBEDDED in the customer)
// { customer_id, first_name, last_name, email, phone,
//   accounts: [ { account_number, type, balance } ],
//   profile: { occupation, city, preferred_channel },
//   business: {...}   <- only some customers (flexible schema)
//   devices: [...]    <- only some customers (flexible schema) }

// Query A: search inside an embedded object
{ "profile.city": "Lagos" }

// Query B: find documents that have a field others lack
{ "business": { "$exists": true } }

// Query C: search inside an array
{ "accounts.type": "SAVINGS" }

// Aggregation: total balance per city
// Stage 1
{ "$unwind": "$accounts" }
// Stage 2
{ "$group": {
    "_id": "$profile.city",
    "total_balance": { "$sum": "$accounts.balance" },
    "num_accounts": { "$sum": 1 }
} }