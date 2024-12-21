#!/bin/bash
while true; do
  docker exec -i pg_master psql -U master_user -d testDB -c \
    "INSERT INTO orders (product_name, quantity, order_date) VALUES ('Product E', 20, NOW());"
  sleep 1  # Insert a new row every second
done
