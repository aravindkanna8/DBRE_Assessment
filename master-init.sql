-- Create orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    order_date DATE NOT NULL
);

-- Insert sample data
INSERT INTO orders (product_name, quantity, order_date)
VALUES
('Product A', 10, '2024-12-01'),
('Product B', 20, '2024-12-02'),
('Product C', 30, '2024-12-03');
