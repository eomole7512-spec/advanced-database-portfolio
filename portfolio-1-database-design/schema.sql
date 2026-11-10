CREATE TABLE branches (
    branch_id    SERIAL PRIMARY KEY,
    branch_name  VARCHAR(100) NOT NULL UNIQUE,
    city         VARCHAR(80)  NOT NULL
);

CREATE TABLE customers (
    customer_id  SERIAL PRIMARY KEY,
    first_name   VARCHAR(60)  NOT NULL,
    last_name    VARCHAR(60)  NOT NULL,
    email        VARCHAR(120) NOT NULL UNIQUE,
    phone        VARCHAR(20),
    created_at   TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE accounts (
    account_id      SERIAL PRIMARY KEY,
    account_number  CHAR(10) NOT NULL UNIQUE,
    customer_id     INT NOT NULL REFERENCES customers(customer_id),
    branch_id       INT NOT NULL REFERENCES branches(branch_id),
    account_type    VARCHAR(10) NOT NULL CHECK (account_type IN ('SAVINGS','CURRENT')),
    balance         NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
    status          VARCHAR(10) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','FROZEN','CLOSED')),
    opened_at       TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE transactions (
    transaction_id  BIGSERIAL PRIMARY KEY,
    account_id      INT NOT NULL REFERENCES accounts(account_id),
    txn_type        VARCHAR(15) NOT NULL CHECK (txn_type IN ('DEPOSIT','WITHDRAWAL','TRANSFER_IN','TRANSFER_OUT')),
    amount          NUMERIC(14,2) NOT NULL CHECK (amount > 0),
    txn_time        TIMESTAMP NOT NULL DEFAULT now(),
    reference       VARCHAR(40),
    description     TEXT
);

CREATE TABLE audit_log (
    audit_id     BIGSERIAL PRIMARY KEY,
    account_id   INT REFERENCES accounts(account_id),
    action       VARCHAR(50) NOT NULL,
    details      TEXT,
    logged_at    TIMESTAMP NOT NULL DEFAULT now()
);