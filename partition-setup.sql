-- Create a new partitioned table
CREATE TABLE orders_new (
    id SERIAL PRIMARY KEY,
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    order_date DATE NOT NULL
) PARTITION BY RANGE (order_date);

-- Create partitions
CREATE TABLE orders_2024 PARTITION OF orders_new FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
CREATE TABLE orders_2025 PARTITION OF orders_new FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Migrate data from the old table to the new partitioned table
INSERT INTO orders_new SELECT * FROM orders;

-- Rename old and new tables to complete the migration
ALTER TABLE orders RENAME TO orders_old;
ALTER TABLE orders_new RENAME TO orders;
