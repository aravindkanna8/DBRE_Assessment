# DBRE_Assessment

Task 2.1: Docker Compose Setup
To set up two PostgreSQL instances (pg_master and pg_replica), we’ll use Docker Compose.

docker-compose.yml

Explanation
pg_master: The main PostgreSQL instance, initialized with a sample database (testDB).
pg_replica: A replica instance configured to connect to the master and replicate data.
Volumes: Ensure persistence of database data even if containers are restarted.
Networks: Both services are connected via a custom network (pg_network).
