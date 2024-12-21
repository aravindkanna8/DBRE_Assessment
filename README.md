# DBRE_Assessment

#Task 2.1: Docker Compose Setup
To set up two PostgreSQL instances (pg_master and pg_replica), we’ll use Docker Compose.

docker-compose.yml

Explanation

pg_master: The main PostgreSQL instance, initialized with a sample database (testDB).

pg_replica: A replica instance configured to connect to the master and replicate data.

Volumes: Ensure persistence of database data even if containers are restarted.

Networks: Both services are connected via a custom network (pg_network).

=================================================



#Task 2.2: Database Creation and Schema Setup
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

============================================




#Task 2.3: Logical Replication
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

===================================




Task 2.4: Partition the Orders Table

To partition the orders table by the order_date column without downtime:

Partitioning Commands
Create a new partitioned table:


Migrate data from the old table:

Continuous Inserts: Use a Bash script (insert-orders.sh) to insert new rows continuously.



=================================================================================================

**Execute replication-setup.sql**

On pg_master:

Run the following command to execute the publication part of the script on the pg_master container:

bash

**docker exec -i pg_master psql -U master_user -d testDB -f /replication-setup.sql**

This will execute the SQL file inside the pg_master container.

Ensure that the script includes only the CREATE PUBLICATION command for the master.

On pg_replica:

For the subscription part of the replication setup, ensure the CREATE SUBSCRIPTION command is present in the replication-setup.sql file. Then, execute it on pg_replica:

bash

**docker exec -i pg_replica psql -U replica_user -d testDB -f /replication-setup.sql**

This will establish the subscription for logical replication.

**Execute partition-setup.sql**

On pg_master:
To partition the orders table on pg_master, run the following:

bash

**docker exec -i pg_master psql -U master_user -d testDB -f /partition-setup.sql**

This will create the partitioned table and migrate data from the old orders table to the new partitioned table.

**Validate Execution**

Check Publication and Subscription

After setting up replication:

On pg_master, check the publications:

sql

**SELECT * FROM pg_publication;**

On pg_replica, check the subscriptions:

sql

**SELECT * FROM pg_subscription;**


**Verify Partitioning**

On pg_master, confirm that the partitioned table and partitions exist:

sql

\d+ orders
\d+ orders_2024
\d+ orders_2025


5. Debugging Tips

If the replication or partitioning doesn't work as expected:

Check container logs:

bash

**docker logs pg_master**

**docker logs pg_replica**


Verify network connectivity between pg_master and pg_replica:

bash

ping **pg_master**

Ensure the pg_hba.conf on pg_master allows connections from pg_replica.

====================================================================================



**Execution Workflow**


Start the Docker Compose Setup:

bash

**docker-compose up -d**

Run Initial Setup: Execute the master-init.sql script on pg_master:

bash

**docker exec -i pg_master psql -U master_user -d testDB -f /master-init.sql**

Configure Replication: Execute **replication-setup.sql** on both master and replica as appropriate.

Partition the Table: Run **partition-setup.sql** on pg_master to migrate the orders table to a partitioned table.

Start Continuous Inserts: Run the Bash script:

bash

**bash insert-orders.sh**



