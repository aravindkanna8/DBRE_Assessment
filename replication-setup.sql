-- On Master
CREATE PUBLICATION orders_pub FOR TABLE orders;

-- On Replica
CREATE SUBSCRIPTION orders_sub
CONNECTION 'host=pg_master port=5432 user=replica_user password=replica_password dbname=testDB'
PUBLICATION orders_pub;
