# DBRE_Assessment

Task 2.1: Docker Compose Setup
To set up two PostgreSQL instances (pg_master and pg_replica), we’ll use Docker Compose.

docker-compose.yml

Explanation
pg_master: The main PostgreSQL instance, initialized with a sample database (testDB).
pg_replica: A replica instance configured to connect to the master and replicate data.
Volumes: Ensure persistence of database data even if containers are restarted.
Networks: Both services are connected via a custom network (pg_network).

Task 2.2: Database Creation and Schema Setup
We need to create a table named orders and populate it with sample data inside the pg_master.

master-init.sql
This script initializes the database schema and inserts sample rows into the orders table.

Testing

After running docker-compose up -d, you can connect to the pg_master database and verify that the table and data were created:

bash

  "**docker exec -it pg_master psql -U master_user -d testDB**"

Run:

sql query

   "**SELECT * FROM orders;**"


Task 2.3: Logical Replication
1. Enable Replication on pg_master
We modify PostgreSQL configuration to enable logical replication.

2. Configure pg_replica as a Subscriber
To enable replication, we create a publication on the master and subscribe to it from the replica.


3. Validation
Insert new data into the orders table on pg_master:

sql

" **INSERT INTO orders (product_name, quantity, order_date) VALUES ('Product D', 15, '2024-12-04');** "

Connect to pg_replica and verify the replicated data:

sql

" **SELECT * FROM orders;** " 
