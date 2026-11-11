-- Query 1: account lookup
EXPLAIN ANALYZE SELECT * FROM transactions WHERE account_id = 12345;
CREATE INDEX idx_transactions_account_id ON transactions(account_id);

-- Query 2: date range
EXPLAIN ANALYZE SELECT * FROM transactions WHERE txn_time >= now() - interval '2 days';
CREATE INDEX idx_transactions_txn_time ON transactions(txn_time);
-- Query 3: join across three tables
EXPLAIN ANALYZE
SELECT c.first_name, c.last_name, a.account_number,
       COUNT(t.transaction_id) AS txn_count,
       SUM(t.amount) AS total_amount
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
JOIN transactions t ON t.account_id = a.account_id
WHERE c.customer_id = 500
GROUP BY c.first_name, c.last_name, a.account_number;
CREATE INDEX idx_accounts_customer_id ON accounts(customer_id);