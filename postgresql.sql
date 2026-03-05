
1. What is postgreSQL ?
    * PostgresSQL is an open source Object Relational Database Management System(ORDBMS)
    * That supports Advanced SQL features
        * ACID Compliance
        * MVCC indexing
        * JSONB

2. What is MVCC?
    * MVCC - (Multi-Version Concurrency Control) allows Multiple transaction to access the same data without locking conflicts
      By maintaining multiple version of rows.

    * Readers don’t block writers and writers don’t block readers.

3. Difference Between SERIAL and BIGSERIAL?
    * SERIAL → 4-byte integer (max ~2.1B)
    * BIGSERIAL → 8-byte integer (very large range)
    (Both create a sequence automatically.)

4. What is the difference between JSON and JSONB?
    JSON → Stored as text
    JSONB → Stored in binary format
    JSONB supports indexing (GIN) and faster querying

    In production → JSONB is preferred.

----------------------------------------------------------------------------------------------------------------------------------------

PERFORMANCE & OPTIMIZATION QUESTIONS

----------------------------------------------------------------------------------------------------------------------------------------

5. What is EXPLAIN?
    * EXPLAIN shows the Query Execution plan used by PostgreSQL.
    * EXPLAIN shows actual execution time.

6. What is Seq Scan?
    * Sequential Scan means PostgreSQL scans the entire table row by row.
    * Used when:
        No index
        Table small
        Many rows match

7. Why PostgreSQL ignores index sometimes?
    * Low selectivity
    * Table small

----------------------------------------------------------------------------------------------------------------------------------------

CREATE TYPE user_status AS ENUM (
    'active',
    'inactive',
    'blocked'
);

CREATE TABLE users (
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    small_num smallint,
    age integer,
    big_number bigint,
    salary numeric(10,2),
    rating real,
    score double precision,
    username varchar(100),
    bio text,
    fixed_code char(5),
    is_active boolean DEFAULT true,
    birth_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    user_uuid uuid DEFAULT gen_random_uuid(),
    profile json,
    settings jsonb,
    tags text[],
    status user_status,
    ip_address inet,
    search_vector tsvector,
    PRIMARY KEY (id),
    UNIQUE (username)
);

CREATE INDEX idx_user_age
ON users (age);
CREATE INDEX idx_user_age_salary
ON users (age, salary);
CREATE INDEX idx_active_users
ON users (age)
WHERE is_active = true;
CREATE INDEX idx_active_users
ON users (age)
WHERE is_active = true;
CREATE INDEX idx_users_created_at_brin
ON users
USING brin (created_at);
CREATE INDEX idx_users_hash_username
ON users
USING hash (username);
CREATE INDEX idx_users_search
ON users
USING gin (search_vector);
CREATE INDEX idx_users_settings_gin
ON users
USING gin (settings);
CREATE INDEX idx_users_tags_gin
ON users
USING gin (tags);
CREATE UNIQUE INDEX idx_users_username
ON users (username);
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-----------------------------------------------------------------------------------------------------------

INSERT INTO users (
    small_num,
    age,
    big_number,
    salary,
    rating,
    score,
    username,
    bio,
    fixed_code,
    is_active,
    birth_date,
    updated_at,
    profile,
    settings,
    tags,
    status,
    ip_address,
    search_vector
) VALUES
(1, 25, 1000000001, 45000.50, 4.2, 88.5, 'arun', 'Node.js developer', 'A1234', true, '1999-06-03', NOW(),
 '{"city":"Chennai","language":"Tamil"}',
 '{"theme":"dark","notifications":true}',
 ARRAY['nodejs','backend','developer'],
 'active',
 '192.168.1.10',
 to_tsvector('Node js backend developer'))

-----------------------------------------------------------------------------------------------------------

-- Get All Active Users
SELECT * FROM users WHERE is_active = true;

-- Get Users Age Range
SELECT * FROM users WHERE age BETWEEN 18 AND 30;

-- Sort Users by Salary
select id, salary, age from users order by salary ASC; 

-- Get top 5 highest paid users
SELECT id, username, salary FROM users ORDER BY salary DESC LIMIT 5;

-- Find users created today
-- PGSQL
SELECT * FROM users WHERE created_at::date = CURRENT_DATE;
-- MYSQL
SELECT * FROM users WHERE DATE(created_at) = CURDATE();

-- Find users created in last 7 days
-- PGSQL
select age, username, created_at from users where created_at >= now() - interval '7 days';
-- MYSQL
SELECT age, username, created_at FROM users WHERE created_at >= NOW() - INTERVAL 7 DAY;

-- Query JSON column
-- PGSQL
select age, username, created_at, profile from users where profile ->> 'firstName' = 'User1';
-- MYSQL
SELECT age, username, created_at, profile FROM users WHERE profile ->> '$.firstName' = 'User1';

-- Quey JSONB column
select age, username, created_at, profile, settings from users where settings ->> 'theme' = 'light';

-- Query Array column
select * from users where 'nodejs' = any(tags); --tags is the array column name

-- tsvector search
-- tsvector is a data type in postgresql that is used to store processed searchable text.
-- tsquery is a data type in postgresql that is used to store processed search queries.
-- to_tsquery is a function in postgresql that is used to convert a string into a tsquery.
-- PGSQL
SELECT * FROM users WHERE search_vector @@ to_tsquery('developer & remote');

-- Update JSONB column
-- jsonb_set is a function in postgresql that is used to update a value in a jsonb column.
update users
set settings = jsonb_set(settings, '{theme}', '"light"')
where id = 19;

-- Insert a new user with JSON and Array data
INSERT INTO users (
 username,
 age,
 salary,
 tags,
 profile
)
VALUES (
 'arun',
 28,
 50000,
 ARRAY['developer','nodejs'],
 '{"city":"Chennai"}'
);

-- Case In-Sensitive Search
SELECT *
FROM users
WHERE username ILIKE '%arun%';

-- 1. How to optimize PostgreSQL query ?
--      * Use indexes
--      * Avoid SELECT *
--      * Filter using indexed columns
--      * Use EXPLAIN ANALYZE
--      * Optimize joins
--      * Use LIMIT and OFFSET
--      * Avoid unnecessary functions
--      * Use proper indexes for JSON and text search

-- 2. How connection pooling works ?
--        * Connection Pooling is a technique used to reuse database connections instead of creating a new connection for every request

-- Imagine a backend API connected to PostgreSQL.
Client Request
     ↓
Create DB Connection
     ↓
Run Query
     ↓
Close Connection

 -- A connection pool maintains a set of reusable database connections.

Client Request
     ↓
Take connection from pool
     ↓
Run Query
     ↓
Return connection to pool

-- Pool Queue Mechanism

Pool Size = 5
Active Queries = 5
New Request → Wait in Queue

-- Example in Node.js
const { Pool } = require("pg");

const pool = new Pool({
  host: "localhost",
  user: "postgres",
  password: "password",
  database: "testdb",
  max: 10
});

const result = await pool.query(
  "SELECT * FROM users WHERE id = $1",
  [1]
);

-----------------------------------------------------------------------------------------------------------

-- How transactions work
    group of one or more SQL operations executed as a single unit of work.

-- Transaction Syntax
BEGIN;

UPDATE accounts 
SET balance = balance - 1000 
WHERE name = 'Arun';

UPDATE accounts 
SET balance = balance + 1000 
WHERE name = 'Ravi';

COMMIT;

-- Transaction Flow

BEGIN
   ↓
Execute Queries
   ↓
COMMIT → Save changes permanently
OR
ROLLBACK → Undo all changes

-- Transaction in Node.js

const client = await pool.connect();

try {
  await client.query("BEGIN");

  await client.query(
    "UPDATE accounts SET balance = balance - 1000 WHERE name='Arun'"
  );

  await client.query(
    "UPDATE accounts SET balance = balance + 1000 WHERE name='Ravi'"
  );

  await client.query("COMMIT");
} catch (err) {
  await client.query("ROLLBACK");
} finally {
  client.release();
}

-- How indexes improve performance ?
    * Indexes in PostgreSQL improve performance by allowing the database to find rows quickly without scanning the entire table.
    * Think of an index like the index page of a book
    * Instead of reading the whole book to find a topic, you go to the index and directly jump to the page.
    * Indexes improve performance by creating a data structure that allows the database to locate rows quickly without scanning the entire table,
      reducing query execution time significantly.