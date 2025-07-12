-- Find Second Heighst Salary in table using with out sub query
select distinct(salary) as distinctSalary from tbl_role order by salary desc limit 1 offset 1;
-- With sub query
select MAX(salary) from tbl_role where salary < (select MAX(salary) from tbl_role);

-- Find All Employees in a Specific Department
select e.first_name firstName, e.last_name as lastName, r.role_name as roleName from employee e inner join tbl_role r on e.role_id = r.id;

-- Count of Employees in Each Department
select r.role_name roleName, count(e.id) as employeeCount from tbl_role r left join employee e on e.role_id = r.id group by r.role_name order by r.id asc;

-- List All Unique Job Titles
select distinct(role_name) roleName as role_name from tbl_role;

-- Employees with Salaries Above Department Average
 select e.first_name as firstName, e.last_name lastName, r.role_name roleName, r.salary as salary from employee e inner join tbl_role r on e.role_id = r.id where r.salary > (select AVG(salary) as avgSalary from tbl_role);

-- Get Top High Paid Employee on each role
select * from (
    select first_name,
           last_name,
           role_id,
           salary,
           ROW_NUMBER() OVER(
                PARTITION BY role_id ORDER BY salary DESC
           ) as ranking
           from employee
) as employee_data where ranking <= 3;

-- Get Format Date
SELECT DATE_FORMAT(NOW(), '%d-%m-%Y %H:%i:%s') as currentDateTime;

-- Select Current Records
select * from employee where DATE(created_date) = CURDATE();
select * from employee where YEARWEEK(created_date, 1) = YEARWEEK(CURDATE(), 1)(
select * from employee where YEAR(created_date) = YEAR(CURDATE()) and MONTH(created_date) = MONTH(CURDATE());
select * from employee where YEAR(created_date) = YEAR(CURDATE());
-- Select Previous Records
SELECT * from employee where DATE(created_date) - INTERVAL 1 DAY;
SELECT * from employee where YEARWEEK(created_date, 1) = YEARWEEK(CURDATE() - INTERVAL 1 WEEK, 1);
select * from employee where MONTH(created_date) = MONTH(CURDATE() - INTERVAL 1 MONTH) and YEAR(created_date) = YEAR(CURDATE());
select * from employee where YEAR(created_date) = YEAR(CURDATE() - INTERVAL 1 YEAR)
-----------------------------------------------------------------------------------------------------------------
-- ---------------------------------------- Stored Procedure ----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

*) Stored Procedure means precombined collection of SQL statement.
*) store Procedure can execute multiple times with different inputs.
*) improve performance by reducing network traffic
*) Can Accept Parameter types IN, OUT, INOUT

-- SYNTAXM
DELIMITER //
     CREATE PROCEDURE procedure_name(IN employeeId INT, OUT firstName VARCHAR(255))
          BEGIN
               select first_name as firstName from employee where id = employeeId;
     END //
DEIMITER ;

CALL procedure_name(arguments) -- With Out OUT
call empDetailsWithId(1, @name); -- With OUT use "@name"

-- condition logic
IF salary > 50000 THEN
   SET status = 'High';
ELSE
   SET status = 'Normal';
END IF;

CASE role
   WHEN 'admin' THEN SET level = 1;
   WHEN 'user' THEN SET level = 2;
   ELSE SET level = 0;
END CASE;

-- loops
DECLARE i INT DEFAULT 1;

WHILE i <= 5 DO
   INSERT INTO logs(msg) VALUES (CONCAT('Loop ', i));
   SET i = i + 1;
END WHILE;
 -------------------------------------------------- Stored Function ---------------------
*) Stroed Procedue Returns single value.
CREATE FUNCTION getFullName(eid INT) RETURNS VARCHAR(255)
BEGIN
   DECLARE name VARCHAR(255);
   SELECT CONCAT(first_name, ' ', last_name) INTO name FROM employee WHERE id = eid;
   RETURN name;
END;
---------------------------------------------------------------------------------------------------------
                                   triggers
---------------------------------------------------------------------------------------------------------
Trigger is set of SQL statements.
Its automatically execute with certain Events.
ON (INSERT, UPDATE, DELETE)

📌 Syntax:
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements
END;
---------------------------------------------------------------------------------------------------------
                                        views
---------------------------------------------------------------------------------------------------------
View is a virtual statement based on sql select query.
Views simplify development,
Prevents code duplication,

CREATE VIEW employee_summary AS
SELECT first_name, last_name, salary
FROM employee;

drop view if exists view_name;
---------------------------------------------------------------------------------------------------------
                                          Indexes
---------------------------------------------------------------------------------------------------------
What is Indexes ?
Index is a data structure that improve speed of retrival operation.

✅ Why Use Indexes?
Faster SELECT queries

Improve performance when using:

WHERE conditions

JOIN statements

ORDER BY, GROUP BY

Useful for large tables with many rows.


❌ When NOT to Use Too Many Indexes:
Indexes consume disk space

Slow down INSERT, UPDATE, DELETE, because indexes also need to be updated

| Type              | Description                                                       |
| ----------------- | ----------------------------------------------------------------- |
| **PRIMARY KEY**   | Automatically creates a unique index.                             |
| **UNIQUE INDEX**  | Ensures all values are unique.                                    |
| **INDEX / KEY**   | Normal index for faster searches.                                 |
| **FULLTEXT**      | Used for full-text search (e.g., searching words in a paragraph). |
| **SPATIAL INDEX** | Used in spatial (geographical) data.                              |

-- Create Index
create index index_name on employee(first_name, last_name);
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    age INT,
    INDEX idx_name_age (first_name, age)
);
DROP INDEX index_name ON table_name;
---------------------------------------------------------------------------------------------------------
                                 Transaction
---------------------------------------------------------------------------------------------------------
A transaction is group of SQL queries that run together as one unit.

Real-Time Example:-
-------------------

💡 Real-Life Example:
Imagine you are transferring ₹1000 from Account A to Account B:

Take ₹1000 from Account A

Add ₹1000 to Account B

This is a transaction.
If step 1 works but step 2 fails, we cancel everything — so no money is lost.

START TRANSACTION;     -- Start the transaction

UPDATE account SET balance = balance - 1000 WHERE id = 1;
UPDATE account SET balance = balance + 1000 WHERE id = 2;

COMMIT;                -- Save the changes

A transaction = group of actions that must succeed together or fail together.

---------------------------------------------------------------------------------------------------------
                               ACID
---------------------------------------------------------------------------------------------------------
ACID is a set of rules - That a database is follows means to keep your data safe.

💧 A = Atomicity - Do everything or do nothing.
🧠 Example:
You buy something online →

₹100 is taken from your account

Order is created

If order creation fails → ₹100 is not taken.
Everything must succeed together.
----------------------------------------------------
🧼 C = Consistency
Keep Data Correct

Data should always follow the rules.

🧠 Example:
Your bank balance cant be negative (rule).
If a mistake breaks this rule, the action is stopped.
-----------------------------------------------------
🧍‍♂️ I = Isolation
No Mix-Up

🧠 Example:
Two people book the last train ticket at the same time.
Only one gets it, no confusion.
------------------------------------------------------
🔒 D = Durability
Saved Forever

Once saved, it stays saved — even if power goes off.

🧠 Example:
You paid a bill, and it says “Payment Successful.”
That info is never lost, even if the server shuts down.
---------------------------------------------------------------------------------------------------------
🟢 Basic Level
What is MySQL? How is it different from SQL?
*) Mysql is an open-source relational database management system(RDBMS).
*) It is based on Structure Query anguage(SQL).
*) Managing and organizing data in relational Database.

:) My-SQL is a software that stores and manages data using SQL.

SQL:-
SQL is a language used to intract with relational database.
it is used for (Create database and table)
               (INSERT, update, DELETE) data
               (Managing Access and Permissions)
:) SQL is a language, it is used to talk with database.

---------------------------------------------------------------------------------------------------------
What are the different data types in MySQL?
🔹 1. Numeric Data Types
| Data Type      | Description                     |
| -------------- | ------------------------------- |
| `INT`          | Integer (whole numbers)         |
| `TINYINT`      | Very small integer (1 byte)     |
| `SMALLINT`     | Small integer (2 bytes)         |
| `MEDIUMINT`    | Medium integer (3 bytes)        |
| `BIGINT`       | Very large integer (8 bytes)    |
| `DECIMAL(p,s)` | Exact decimal (for money, etc.) |
| `FLOAT`        | Small floating-point number     |
| `DOUBLE`       | Large floating-point number     |
| `BIT`          | Binary value (0 or 1)           |

🔹 2. String (Character/Text) Data Types
| Data Type    | Description                                       |
| ------------ | ------------------------------------------------- |
| `CHAR(n)`    | Fixed-length text (e.g., `CHAR(10)`)              |
| `VARCHAR(n)` | Variable-length text (e.g., names, emails)        |
| `TEXT`       | Long text (up to 65,535 characters)               |
| `TINYTEXT`   | Very short text                                   |
| `MEDIUMTEXT` | Medium-length text                                |
| `LONGTEXT`   | Very large text                                   |
| `ENUM`       | A list of allowed values (e.g., 'male', 'female') |
| `SET`        | A set of multiple predefined values               |

🔹 3. Date and Time Data Types
| Data Type   | Description                        |
| ----------- | ---------------------------------- |
| `DATE`      | Date only (`YYYY-MM-DD`)           |
| `TIME`      | Time only (`HH:MM:SS`)             |
| `DATETIME`  | Date and time                      |
| `TIMESTAMP` | Date and time (auto-updated often) |
| `YEAR`      | Year (e.g., 2025)                  |

---------------------------------------------------------------------------------------------------------
What is the difference between CHAR and VARCHAR?
Char:
It always stores fixed number of characters.
VARCHAR:
It stores only the actual number of characters you type.

| `CHAR(n)`                           | `VARCHAR(n)`                         |
| ----------------------------------- | ------------------------------------ |
| Always uses `n` spaces              | Uses **only** what’s needed          |
| Wastes space if text is short       | Saves space                          |
| Can be faster for fixed-length data | Slower if lengths are very different |
| Good for: PIN codes, country codes  | Good for: names, emails, addresses   |
---------------------------------------------------------------------------------------------------------
What is a primary key? Can a table have multiple primary keys?
*) A Unique ID for each row in a table.
*) It Must be Unique.
*) It Can not be null.

🔸 Can a table have multiple primary keys?
❌ No, a table can have only ONE primary key.

But One Primary Key can include multiple columns - This is called a composite key.

CREATE TABLE student_course (
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id)
);
Here:
Neither student_id nor course_id alone is unique.

But together, they form a unique pair.
---------------------------------------------------------------------------------------------------------
What is the difference between PRIMARY KEY, UNIQUE, and INDEX?
| Feature        | **PRIMARY KEY**                 | **UNIQUE**                           | **INDEX**                     |
| -------------- | ------------------------------- | ------------------------------------ | ----------------------------- |
| ✅ Uniqueness   | Must be unique                  | Must be unique                       | Can have duplicates           |
| ❌ NULL allowed | ❌ Not allowed (must have value) | ✅ Allowed (but only one NULL row)    | ✅ Allowed                     |
| 🔢 Count/table | Only **one** primary key        | Can have **many** unique constraints | Can have **many** indexes     |
| 🔎 Purpose     | Uniquely identify each row      | Enforce no duplicate values          | Speed up search (performance) |
| 📌 Auto index  | ✅ Automatically creates index   | ✅ Automatically creates index        | ✅ Just an index               |

---------------------------------------------------------------------------------------------------------
What is the purpose of AUTO_INCREMENT in MySQL?
To automatically create unique values, usually for the primary key.
No need to manually type ID numbers.
---------------------------------------------------------------------------------------------------------
What are the different types of joins in MySQL? Explain with examples.
🔗 1. INNER JOIN
Returns only matching rows from both tables.

🟢 2. LEFT JOIN (or LEFT OUTER JOIN)
Returns all rows from the left table, and matched rows from the right. If no match, right side will be NULL.

🔵 3. RIGHT JOIN (or RIGHT OUTER JOIN)
Returns all rows from the right table, and matched rows from the left. If no match, left side will be NULL.

🔴 4. FULL JOIN (or FULL OUTER JOIN)
Returns all rows from both tables, matched where possible. If no match, NULLs are shown.

SELECT e.name, d.department_name
FROM employee e
LEFT JOIN department d ON e.department_id = d.id

UNION

SELECT e.name, d.department_name
FROM employee e
RIGHT JOIN department d ON e.department_id = d.id;
🎯 Result: Combines all employees and departments, even if they don’t match.

---------------------------------------------------------------------------------------------------------
What is the difference between INNER JOIN and LEFT JOIN?
| Feature            | `INNER JOIN`                                    | `LEFT JOIN` (or LEFT OUTER JOIN)                                                             |
| ------------------ | ----------------------------------------------- | -------------------------------------------------------------------------------------------- |
| **Matching Rows**  | Returns only rows that **match** in both tables | Returns **all rows** from the **left table**, and the **matching rows** from the right table |
| **Unmatched Rows** | Unmatched rows are **excluded**                 | Unmatched rows in right table become **NULL**                                                |
| **Performance**    | Slightly faster                                 | May be slower due to returning more data                                                     |

---------------------------------------------------------------------------------------------------------
What is the use of GROUP BY and HAVING clause?
🔸 GROUP BY Clause
✅ Use:
GROUP BY is used to group rows that have the same values in one or more columns.
Its often used with aggregate functions like COUNT(), SUM(), AVG(), MAX(), MIN() to perform calculations per group.

🔸 HAVING Clause
✅ Use:
HAVING is used to filter groups after the GROUP BY has been applied.
Its like a WHERE clause, but for groups, not individual rows.
---------------------------------------------------------------------------------------------------------
How do you retrieve the current date and time in MySQL?
-- ✅ To retrieve the current **date and time** in MySQL, use:
SELECT NOW();

-- 📅 To get only the **current date**:
SELECT CURDATE();

-- 🕒 To get only the **current time**:
SELECT CURTIME();

-- 🔄 To format the current date and time in a custom format:
SELECT DATE_FORMAT(NOW(), '%d-%m-%Y %H:%i:%s') AS formatted_datetime;
---------------------------------------------------------------------------------------------------------
===🟡 Intermediate Level===
---------------------------------------------------------------------------------------------------------
What are aggregate functions in MySQL?

Examples: SUM(), COUNT(), AVG(), MAX(), MIN()
-- ✅ Aggregate functions in MySQL perform a calculation on a set of values and return a single value.
-- They're commonly used with GROUP BY.

-- 🔢 1. COUNT(): Returns the number of rows
SELECT COUNT(*) FROM employee;

-- 🔢 2. SUM(): Returns the total sum of a numeric column
SELECT SUM(salary) FROM employee;

-- 🔢 3. AVG(): Returns the average value
SELECT AVG(salary) FROM employee;

-- 🔢 4. MAX(): Returns the maximum value
SELECT MAX(salary) FROM employee;

-- 🔢 5. MIN(): Returns the minimum value
SELECT MIN(salary) FROM employee;

-- 📊 Example with GROUP BY:
SELECT department_id, AVG(salary) AS avg_salary
FROM employee
GROUP BY department_id;
---------------------------------------------------------------------------------------------------------
What is a subquery? What are its types?
-- 📘 What is a Subquery?
-- A subquery is a query nested inside another SQL query.
-- It is used to perform operations that depend on the result of another query.

-- ✅ Example:
SELECT name, salary
FROM employee
WHERE salary > (
  SELECT AVG(salary)
  FROM employee
);

-- 📂 Types of Subqueries:

-- 1. 🟡 Single-row Subquery: Returns only one row
SELECT name FROM employee
WHERE department_id = (
  SELECT id FROM department WHERE department_name = 'Sales'
);

-- 2. 🟠 Multi-row Subquery: Returns multiple rows
SELECT name FROM employee
WHERE department_id IN (
  SELECT id FROM department WHERE location = 'Chennai'
);

-- 3. 🔵 Correlated Subquery: Refers to column from the outer query
SELECT e.name FROM employee e
WHERE salary > (
  SELECT AVG(salary)
  FROM employee
  WHERE department_id = e.department_id
);

-- 4. 🟣 Nested Subquery: A subquery inside another subquery
SELECT name FROM employee
WHERE department_id = (
  SELECT id FROM department
  WHERE location = (
    SELECT location FROM branch WHERE city = 'Mumbai'
  )
);

---------------------------------------------------------------------------------------------------------
What is the difference between WHERE and HAVING clause?
-- 📘 WHERE vs HAVING in MySQL

-- ✅ WHERE Clause:
-- Filters rows before grouping or aggregation.
-- Used with SELECT, UPDATE, DELETE.

SELECT *
FROM employee
WHERE salary > 30000;  -- Filters individual rows

-- ✅ HAVING Clause:
-- Filters groups after GROUP BY and aggregation.
-- Used only with GROUP BY.

SELECT department_id, AVG(salary) AS avg_salary
FROM employee
GROUP BY department_id
HAVING avg_salary > 50000;  -- Filters grouped results

-- 🔁 Key Differences:
-- WHERE filters rows BEFORE aggregation
-- HAVING filters groups AFTER aggregation

---------------------------------------------------------------------------------------------------------
How do you prevent SQL injection in MySQL?
sql injection - means security vulnerability.
-- ❌ Example of Vulnerable Query:
-- Assuming userInput = "' OR '1'='1"
query = "SELECT * FROM users WHERE username = '" + userInput + "'";
-- Final Query becomes:
-- SELECT * FROM users WHERE username = '' OR '1'='1';
-- This returns all users and can be exploited to bypass login or extract data.

-- ✅ Safe Version Using Prepared Statements (Node.js Example):
connection.execute("SELECT * FROM users WHERE username = ?", [userInput]);

----------- In Node JS ------------
// ❌ Avoid this (vulnerable to SQL injection)
// const query = `SELECT * FROM users WHERE username = '${userInput}'`;

// ✅  Use ORM (like Sequelize or Prisma) for added safety
Uses safe, parameterized queries
// Example (Sequelize):
// const user = await User.findOne({ where: { username: userInput } });

---------------------------------------------------------------------------------------------------------
How can you optimize a slow-running query in MySQL?
-- 🚀 How to Optimize a Slow-Running Query in MySQL

-- ✅ 1. Use EXPLAIN to Analyze the Query Plan
EXPLAIN SELECT * FROM employee WHERE department_id = 3;
-- Shows how MySQL executes the query (indexes used, row scans, etc.)

-- ✅ 2. Add Indexes to Speed Up Searches
CREATE INDEX idx_department_id ON employee(department_id);
-- Indexes improve WHERE, JOIN, ORDER BY, and GROUP BY performance

-- ✅ 3. Avoid SELECT *
-- Only fetch the columns you need
SELECT name, salary FROM employee;

-- ✅ 4. Use LIMIT When Possible
-- Limits the number of rows processed
SELECT * FROM logs ORDER BY created_at DESC LIMIT 100;

-- ✅ 5. Optimize WHERE Conditions
-- Use indexed columns in WHERE clauses
SELECT * FROM orders WHERE status = 'active';

-- ✅ 6. Use Proper Data Types
-- Avoid unnecessarily large data types (e.g., use INT instead of BIGINT if possible)

-- ✅ 7. Archive or Partition Large Tables
-- Archive old data or split tables by date to reduce scanning size

-- ✅ 8. Analyze Slow Queries
-- Enable slow query log to find slow SQL:
SET GLOBAL slow_query_log = 'ON';

-- ✅ 9. Avoid Functions on Indexed Columns in WHERE
-- ❌ WHERE YEAR(date) = 2023
-- ✅ WHERE date >= '2023-01-01' AND date < '2024-01-01'

---------------------------------------------------------------------------------------------------------
What is the difference between IN and EXISTS?
-- 🆚 IN vs EXISTS in MySQL
-- Both IN and EXISTS are used to filter results based on a subquery, but behave differently in performance and logic.

-- ✅ IN: Checks if a value exists in a list of values
SELECT name FROM employee
WHERE department_id IN (
  SELECT id FROM department WHERE location = 'Chennai'
);

-- ✅ EXISTS: Checks if the subquery returns any rows
SELECT name FROM employee e
WHERE EXISTS (
  SELECT 1 FROM department d
  WHERE d.id = e.department_id AND d.location = 'Chennai'
);

-- 🔍 Key Differences:
-- 1. IN compares values directly; EXISTS checks for existence.
-- 2. IN is better for small datasets.
-- 3. EXISTS is more efficient with large subqueries and correlated queries.
-- 4. EXISTS stops processing once it finds a match (short-circuit).

-- 📝 Tip:
-- Use EXISTS when the subquery returns many rows.
-- Use IN when the subquery returns a small static list.

---------------------------------------------------------------------------------------------------------
What is normalization? Explain 1NF, 2NF, and 3NF.
-- 📘 What is Normalization?
-- Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.
-- It breaks large tables into smaller ones and defines relationships between them.

-- ✅ 1NF (First Normal Form)
-- 🎯 Rule: Each column should have atomic (indivisible) values, and each row must be unique.
-- ❌ Bad:
-- | ID | Name   | Hobbies          |
-- |----|--------|------------------|
-- | 1  | Alice  | Reading, Singing |
-- ✅ Good:
-- | ID | Name   | Hobby     |
-- |----|--------|-----------|
-- | 1  | Alice  | Reading   |
-- | 1  | Alice  | Singing   |

-- ✅ 2NF (Second Normal Form)
-- 🎯 Rule: Must be in 1NF + all non-key columns must depend on the whole primary key.
-- ❌ Bad:
-- A table with composite key where one column depends only on part of the key.
-- ✅ Good:
-- Split the table so each piece of data depends on the entire key.

-- ✅ 3NF (Third Normal Form)
-- 🎯 Rule: Must be in 2NF + no column should depend on another non-key column.
-- ❌ Bad:
-- | ID | Name | Zip   | City   |
-- |----|------|-------|--------|
-- | 1  | John | 600001| Chennai|
-- (City depends on Zip, not on ID)
-- ✅ Good:
-- Split into:
-- Table1: ID, Name, Zip
-- Table2: Zip, City

---------------------------------------------------------------------------------------------------------
What is a stored procedure? How do you create one in MySQL?
-- 📘 What is a Stored Procedure?
-- A stored procedure is a saved block of SQL code that can be reused and executed later.
-- It helps organize logic, improves performance, and reduces duplication.

-- ✅ Benefits:
-- 1. Reusable code
-- 2. Improved performance
-- 3. Centralized business logic

-- 🔧 How to Create a Stored Procedure in MySQL:
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dept_id INT)
BEGIN
  SELECT * FROM employee WHERE department_id = dept_id;
END //
DELIMITER ;

-- ▶️ How to Call the Stored Procedure:
CALL GetEmployeesByDept(3);

-- 📝 Note:
-- DELIMITER // is used to tell MySQL where the procedure ends, so it doesn't get confused by semicolons inside the procedure.

---------------------------------------------------------------------------------------------------------
How do you create and use triggers in MySQL?
-- 🔔 What is a Trigger?
-- A trigger is a special procedure that automatically runs in response to certain events on a table (INSERT, UPDATE, DELETE).

-- ✅ Use Case Example:
-- Log every time a new employee is added.

-- 📦 Step 1: Create a log table
CREATE TABLE employee_log (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  employee_name VARCHAR(100),
  action_time DATETIME
);

-- ⚙️ Step 2: Create the Trigger
DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
  INSERT INTO employee_log (employee_name, action_time)
  VALUES (NEW.name, NOW());
END //
DELIMITER ;

-- 🧪 Result: When a new employee is added, their name and time are logged automatically.

-- 🧹 How to Drop the Trigger:
DROP TRIGGER IF EXISTS after_employee_insert;

---------------------------------------------------------------------------------------------------------
Explain UNION vs UNION ALL.
-- 🆚 UNION vs UNION ALL in MySQL
-- Both combine results from two or more SELECT queries.

-- ✅ UNION
-- Removes duplicate rows from the combined result.
SELECT name FROM employee
UNION
SELECT name FROM manager;

-- ✅ UNION ALL
-- Includes all rows (with duplicates) from all SELECT queries.
SELECT name FROM employee
UNION ALL
SELECT name FROM manager;

-- 🔍 Key Differences:
-- 1. UNION performs DISTINCT (slower with large datasets)
-- 2. UNION ALL is faster but includes duplicates
-- 3. Use UNION when you need unique results
-- 4. Use UNION ALL when you want all rows for performance

-- 📝 Tip: All SELECTs must have the same number and order of columns

---------------------------------------------------------------------------------------------------------
=======🔴 Advanced Level=======
---------------------------------------------------------------------------------------------------------
What is indexing in MySQL? How does it improve performance?
An index is a data structure used to speed up data retrieval in a database table — like a book index that helps you quickly find a topic.

📌 Makes SELECT queries faster by avoiding full table scans.

⚡ Speeds up WHERE, JOIN, ORDER BY, and GROUP BY.

🔍 Allows MySQL to jump directly to the matching rows.

CREATE INDEX idx_department_id ON employee(department_id);


⚠️ Things to Remember:
🗃️ Indexes take extra disk space.

🐢 They may slow down INSERT, UPDATE, DELETE — because indexes must be updated too.

🧠 Only add indexes to columns that are:

Frequently searched

Used in joins

Used in sorting/grouping

---------------------------------------------------------------------------------------------------------
What are the different types of indexes in MySQL?
-- 📘 Types of Indexes in MySQL

-- ✅ 1. PRIMARY KEY
-- Unique identifier for each row; automatically creates a unique index
CREATE TABLE employee (
  id INT PRIMARY KEY,
  name VARCHAR(100)
);

-- ✅ 2. UNIQUE INDEX
-- Ensures all values in the column are unique
CREATE UNIQUE INDEX idx_email ON employee(email);

-- ✅ 3. INDEX (a.k.a. Normal or Non-Unique Index)
-- Speeds up queries but allows duplicate values
CREATE INDEX idx_name ON employee(name);

-- ✅ 4. FULLTEXT INDEX
-- Used for full-text search (only on MyISAM and InnoDB with CHAR, VARCHAR, TEXT columns)
CREATE FULLTEXT INDEX idx_bio ON employee(bio);

-- ✅ 5. SPATIAL INDEX
-- Used for spatial (geometry) data types
CREATE SPATIAL INDEX idx_location ON geo_table(location);

-- 📝 Tip:
-- Use EXPLAIN to check if your query is using an index:
EXPLAIN SELECT * FROM employee WHERE name = 'Alice';

---------------------------------------------------------------------------------------------------------
What is the difference between MyISAM and InnoDB storage engines?

📘 What is a Storage Engine in MySQL?
A storage engine is the component of MySQL that handles how data is stored, retrieved, and managed in tables.
-- 🆚 MyISAM vs InnoDB Storage Engines in MySQL

-- ✅ 1. Transaction Support
-- InnoDB: Supports transactions (COMMIT, ROLLBACK)
-- MyISAM: No transaction support

-- ✅ 2. Foreign Key Support
-- InnoDB: Supports foreign key constraints
-- MyISAM: Does not support foreign keys

-- ✅ 3. Locking Mechanism
-- InnoDB: Uses row-level locking (better for concurrent writes)
-- MyISAM: Uses table-level locking (slower for updates)

-- ✅ 4. Crash Recovery
-- InnoDB: Has automatic crash recovery
-- MyISAM: Can cause data corruption after crash

-- ✅ 5. Performance
-- InnoDB: Better for write-intensive applications
-- MyISAM: Slightly faster for read-heavy workloads

-- ✅ 6. Storage
-- InnoDB: Stores data and indexes together in a tablespace
-- MyISAM: Stores data and indexes separately

-- 📝 Default Engine: InnoDB (recommended for most use cases)

---------------------------------------------------------------------------------------------------------
What is a transaction? What are ACID properties?
-- 📘 What is a Transaction in MySQL?
-- A transaction is a sequence of one or more SQL operations executed as a single unit of work.
-- It ensures data integrity by grouping multiple queries together.

-- ✅ Example:
START TRANSACTION;
UPDATE accounts SET balance = balance - 500 WHERE id = 1;
UPDATE accounts SET balance = balance + 500 WHERE id = 2;
COMMIT;
-- If anything goes wrong before COMMIT, you can ROLLBACK;

-- 🔐 ACID Properties of Transactions:

-- ✅ A - Atomicity
-- All operations in a transaction are done or none are done.

-- ✅ C - Consistency
-- The database remains in a valid state before and after the transaction.

-- ✅ I - Isolation
-- Transactions are isolated from each other (no interference).

-- ✅ D - Durability
-- Once committed, changes are permanent even after system crashes.

-- 📝 Tip:
-- Use COMMIT to save changes, and ROLLBACK to undo changes if needed.
---------------------------------------------------------------------------------------------------------
What is the difference between ROLLBACK, COMMIT, and SAVEPOINT?

### 🔄 Difference Between `COMMIT`, `ROLLBACK`, and `SAVEPOINT` in MySQL

These are **transaction control statements** used to manage changes made during a transaction.

---

### ✅ `COMMIT`

* Saves all changes made during the current transaction.
* Once committed, changes are permanent.

```sql
START TRANSACTION;
UPDATE users SET balance = balance - 100 WHERE id = 1;
COMMIT;
```

---

### ✅ `ROLLBACK`

* Undoes all changes made in the current transaction since the last `START TRANSACTION` or `SAVEPOINT`.

```sql
START TRANSACTION;
UPDATE users SET balance = balance - 100 WHERE id = 1;
ROLLBACK;  -- Cancels the change
```

---

### ✅ `SAVEPOINT`

* Sets a point within a transaction that you can roll back to.
* Allows partial undo of a transaction.

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
SAVEPOINT step1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
ROLLBACK TO step1;  -- Only undoes the second update
COMMIT;             -- Commits the first update
```

---

### 🧠 Summary Table:

| Command                 | Action                                                     |
| ----------------------- | ---------------------------------------------------------- |
| `COMMIT`                | Makes all changes permanent                                |
| `ROLLBACK`              | Cancels all changes since the transaction began            |
| `SAVEPOINT`             | Sets a checkpoint to roll back to a specific part of a txn |
| `ROLLBACK TO SAVEPOINT` | Undoes changes after a specific savepoint only             |

Let me know if you want real-world use cases (e.g., order placement, banking).
---------------------------------------------------------------------------------------------------------
What is query execution plan? How do you use EXPLAIN to analyze a query?
-- 📘 What is a Query Execution Plan?
-- It shows how MySQL will execute a query: which tables it reads from, the order, and whether it uses indexes.
-- Helps identify slow queries and performance bottlenecks.

-- 🔍 How to View Execution Plan:
EXPLAIN SELECT * FROM employee WHERE department_id = 3;

-- 📊 EXPLAIN Output Columns:
-- id         : The order of operations in the query
-- select_type: Type of SELECT (e.g., SIMPLE, PRIMARY, SUBQUERY)
-- table      : Table being accessed
-- type       : Join type (e.g., ALL, index, ref, const)
-- possible_keys: Indexes that might be used
-- key        : Actual index used
-- rows       : Estimated number of rows to scan
-- Extra      : Additional info (e.g., Using where, Using index)

-- ✅ Example:
EXPLAIN SELECT name FROM employee WHERE department_id = 3;

-- 📝 Tip:
-- Always check for "type = ALL" — it means full table scan, which is slow.
-- Aim for "type = ref" or better.
-- Use indexes to improve execution plans.

---------------------------------------------------------------------------------------------------------
What is a view? When should you use views?
-- 📘 What is a View in MySQL?
-- A view is a virtual table based on the result of a SELECT query.
-- It does not store data itself, but provides a way to simplify complex queries.

-- ✅ Why Use Views?
-- 1. Simplify complex joins or queries
-- 2. Improve code readability and reusability
-- 3. Provide specific access to parts of data (security)
-- 4. Help in reporting and analytics

-- 🔧 How to Create a View:
CREATE VIEW active_employees AS
SELECT id, name, department
FROM employee
WHERE status = 'active';

-- ▶️ How to Use a View:
SELECT * FROM active_employees;

-- 🧹 How to Drop a View:
DROP VIEW IF EXISTS active_employees;

-- 📝 Tip:
-- Views can be queried like normal tables, but cannot always be updated directly depending on the complexity of the underlying query.
---------------------------------------------------------------------------------------------------------
How does MySQL handle concurrency and locking?
-- 🔐 How MySQL Handles Concurrency and Locking
-- Concurrency is the ability of MySQL to allow multiple users to access the database at the same time.
-- Locking is how MySQL controls access to data to prevent conflicts.

-- ✅ Types of Locks in MySQL:

-- 1. Table-level Lock (used by MyISAM)
--   - Locks the whole table during read/write
--   - Simpler but less concurrent

-- 2. Row-level Lock (used by InnoDB)
--   - Locks only the rows being modified
--   - Allows better concurrency (multiple users can work on different rows)

-- ✅ Locking Modes in InnoDB:
--   - Shared Lock (S): Allows reading but not writing
--   - Exclusive Lock (X): Allows both reading and writing, blocks others

-- ✅ Example (Transaction with Locks):
START TRANSACTION;
SELECT * FROM accounts WHERE id = 1 FOR UPDATE; -- Acquires exclusive lock on row
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
COMMIT;

-- ✅ Isolation Levels (Control how transactions interact):
-- 1. READ UNCOMMITTED: Dirty reads allowed
-- 2. READ COMMITTED: Only committed data is read
-- 3. REPEATABLE READ (default): Prevents non-repeatable reads
-- 4. SERIALIZABLE: Highest isolation, full locking

-- 📝 Tip:
-- Use InnoDB for better concurrency control
-- Use proper isolation level to avoid data anomalies

---------------------------------------------------------------------------------------------------------
What are temporary tables?
-- 📘 What are Temporary Tables in MySQL?
-- Temporary tables are special tables used to store data temporarily during a session.
-- They are deleted automatically when the session ends or the connection closes.

-- ✅ Why Use Temporary Tables?
-- 1. Store intermediate results
-- 2. Break complex queries into smaller parts
-- 3. Avoid using permanent disk space for short-term data

-- 🔧 How to Create a Temporary Table:
CREATE TEMPORARY TABLE temp_orders (
  id INT,
  customer_name VARCHAR(100),
  total DECIMAL(10,2)
);

-- ▶️ How to Use It:
INSERT INTO temp_orders VALUES (1, 'Alice', 250.00);
SELECT * FROM temp_orders;

-- 🧹 How to Manually Drop:
DROP TEMPORARY TABLE IF EXISTS temp_orders;

-- ⚠️ Notes:
-- - Only visible to the current session
-- - Cannot be shared between users or sessions
-- - Automatically removed when the session ends

---------------------------------------------------------------------------------------------------------
How do you handle replication in MySQL?
-- 🔄 MySQL Replication Overview
-- Replication in MySQL allows you to copy data from one server (Master) to one or more servers (Slaves).
-- It improves availability, backups, and read scalability.

-- ✅ Key Components:
-- 1. Master Server: Accepts write operations
-- 2. Slave Server(s): Copies and applies changes from master

-- 📦 Common Use Cases:
-- - Load balancing (read from slaves)
-- - Backups without affecting production
-- - High availability

-- 🔧 Basic Steps to Set Up Replication:
-- 1. Configure Master
--    - Enable binary logging
--    - Create replication user
--    - Note master status (file, position)

-- 2. Configure Slave
--    - Set master host, log file, and position
--    - Start the replication thread

-- 🛠 Example:
-- On Master:
--   my.cnf: server-id=1, log-bin=mysql-bin
--   GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'password';
--   SHOW MASTER STATUS;

-- On Slave:
--   my.cnf: server-id=2
--   CHANGE MASTER TO MASTER_HOST='master_ip',
--     MASTER_USER='repl', MASTER_PASSWORD='password',
--     MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=120;
--   START SLAVE;

-- ✅ Monitoring:
-- SHOW SLAVE STATUS \G
-- Look for: Slave_IO_Running: Yes, Slave_SQL_Running: Yes

---------------------------------------------------------------------------------------------------------
⚙️ Practical Task-Based Questions
Write a query to find the second highest salary from a table.

Write a query to find duplicate records in a table.

Write a query to transpose rows to columns using CASE.

Write a query to get the total salary of each department.

Write a query to list employees who joined in the last 7 days.

