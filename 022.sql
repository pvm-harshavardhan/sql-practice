USE sql_practice;

-- List all tables in a given database
show tables from your_database_name;

-- List all columns in a table using INFORMATION_SCHEMA
select column_name, data_type, is_nullable, column_default
from information_schema.columns
where table_schema = 'sql_practice' and table_name = 'employees';

-- Find all foreign keys in a database
select table_name, constraint_name, column_name, referenced_table_name, referenced_column_name
from information_schema.key_column_usage
where table_schema = 'sql_practice' and referenced_table_name is not null;

-- Get data types of all columns in a table
select column_name, data_type, character_maximum_length
from information_schema.columns
where table_schema = 'sql_practice' and table_name = 'employees';

-- Find all indexes and their columns
show indexes from employees;

-- List all views in a schema
select table_name as view_name
from information_schema.views
where table_schema = 'sql_practice';

-- Find constraints applied on a column
select constraint_name, constraint_type, table_name
from information_schema.table_constraints
where table_schema = 'sql_practice';

-- Retrieve all stored procedures and their parameters
select specific_name, parameter_name, data_type, dtd_identifier
from information_schema.parameters
where specific_schema = 'sql_practice';

-- Get table row counts from system catalogs
-- (Approximate count, use COUNT(*) for exact)
select table_name, table_rows
from information_schema.tables
where table_schema = 'sql_practice';

-- Find tables without primary keys
select table_name
from information_schema.tables
where table_schema = 'sql_practice'
and table_name not in (
  select table_name
  from information_schema.table_constraints
  where constraint_type = 'primary key' and table_schema = 'sql_practice'
);

-- Get column nullability and default values
select column_name, is_nullable, column_default
from information_schema.columns
where table_schema = 'sql_practice' and table_name = 'employees';

-- Track table creation and last update time (InnoDB tables only)
select table_name, create_time, update_time
from information_schema.tables
where table_schema = 'sql_practice';

-- Query for recently modified views or triggers (by create time)
select trigger_name, event_manipulation, action_timing, created
from information_schema.triggers
where trigger_schema = 'sql_practice';

-- List all users and their roles (if supported)
select user, host from mysql.user; -- MySQL 8.0+ required

-- Query storage size of each table (in MB)
select 
  table_name,
  round((data_length + index_length) / 1024 / 1024, 2) as total_mb
from information_schema.tables
where table_schema = 'sql_practice'
order by total_mb desc;

-- Retrieve execution statistics or cache hits (DBMS-specific)
-- MySQL doesn't offer native query cache stats in INFORMATION_SCHEMA post-5.7
-- For example, in performance_schema:
select * from performance_schema.events_statements_summary_by_digest
order by avg_timer_wait desc
limit 10;