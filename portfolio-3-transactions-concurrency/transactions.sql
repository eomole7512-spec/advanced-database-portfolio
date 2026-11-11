-- Portfolio 3: Transactions and Concurrency

-- Demo 1: Successful transfer (COMMIT)
BEGIN;
UPDATE accounts SET balance = balance - 20000 WHERE account_number = '9000000001';
UPDATE accounts SET balance = balance + 20000 WHERE account_number = '9000000002';
INSERT INTO transactions (account_id, txn_type, amount, reference, description)
SELECT account_id, 'TRANSFER_OUT', 20000, 'TRF-DEMO-1', 'Transfer to 9000000002'
FROM accounts WHERE account_number = '9000000001';
INSERT INTO transactions (account_id, txn_type, amount, reference, description)
SELECT account_id, 'TRANSFER_IN', 20000, 'TRF-DEMO-1', 'Transfer from 9000000001'
FROM accounts WHERE account_number = '9000000002';
COMMIT;

-- Demo 2: Failed transfer (ROLLBACK). The CHECK constraint rejects a negative balance
BEGIN;
UPDATE accounts SET balance = balance + 500000 WHERE account_number = '9000000002';
UPDATE accounts SET balance = balance - 500000 WHERE account_number = '9000000001';
-- ERROR: violates check constraint "accounts_balance_check"
ROLLBACK;

-- Demo 3: Concurrency (run in two psql windows)
-- Window 1:
BEGIN;
UPDATE accounts SET balance = balance - 10000 WHERE account_number = '9000000001';
-- (do not commit yet)
-- Window 2 (waits for the row lock):
BEGIN;
UPDATE accounts SET balance = balance - 5000 WHERE account_number = '9000000001';
-- Window 1:
COMMIT;
-- Window 2 now continues:
COMMIT;
-- Final balance of 9000000001 = 65000.00