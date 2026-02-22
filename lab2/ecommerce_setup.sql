-- Lab 02: E-Commerce Dataset Setup
-- Author: Amin
-- Date: 2026-02-22

-- Drop tables if they exist (clean slate) [cite: 67-71]
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 1. Create CUSTOMERS table [cite: 73-84]
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(80),
    signup_date DATE NOT NULL
);

-- 2. Create PRODUCTS table [cite: 86-93]
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(60) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock_qty INTEGER NOT NULL DEFAULT 0
);

-- 3. Create ORDERS table [cite: 95-107]
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers (customer_id),
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'pending',
    total_amount DECIMAL (10,2) NOT NULL,
    shipped_date DATE
);

-- 4. Create ORDER_ITEMS table [cite: 109-119]
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    product_id INTEGER NOT NULL REFERENCES products (product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL (10,2) NOT NULL
);

-- 5. INSERT CUSTOMER DATA [cite: 123]
INSERT INTO customers (name, email, city, signup_date) VALUES
('Ali Hassan', 'ali.hassan@gmail.com', 'Peshawar', '2023-03-12'),
('Sara Khan', 'sara.khan@yahoo.com', 'Lahore', '2023-05-20'),
('Usman Tariq', 'usman.tariq@gmail.com', 'Karachi', '2023-07-08'),
('Fatima Malik', 'fatima.malik@hotmail.com', 'Islamabad', '2023-08-15'),
('Bilal Ahmed', 'bilal.ahmed@gmail.com', 'Peshawar', '2023-09-01'),
('Ayesha Noor', 'ayesha.noor@gmail.com', 'Lahore', '2023-10-10'),
('Hamza Sheikh', 'hamza.sheikh@outlook.com', 'Karachi', '2023-11-22'),
('Zainab Iqbal', 'zainab.iqbal@gmail.com', 'Quetta', '2024-01-05');

-- 6. INSERT PRODUCT DATA [cite: 123]
INSERT INTO products (product_name, category, price, stock_qty) VALUES
('Wireless Mouse', 'Electronics', 1850.00, 45),
('USB-C Hub 7-in-1', 'Electronics', 3200.00, 30),
('Mechanical Keyboard', 'Electronics', 7500.00, 20),
('Laptop Stand Aluminium', 'Electronics', 4200.00, 35),
('Noise Cancelling Headset', 'Electronics', 12500.00, 15),
('Python Programming Book', 'Books', 1200.00, 60),
('Data Science Handbook', 'Books', 1800.00, 40),
('Machine Learning Guide', 'Books', 2200.00, 25);

-- 7. INSERT ORDER DATA [cite: 126-147]
INSERT INTO orders (customer_id, order_date, status, total_amount, shipped_date) VALUES
(1, '2024-09-05', 'delivered', 3050.00, '2024-09-07'),
(2, '2024-09-12', 'delivered', 8700.00, '2024-09-14'),
(3, '2024-10-01', 'delivered', 12500.00, '2024-10-03'),
(4, '2024-10-15', 'delivered', 4200.00, '2024-10-17');

-- 8. INSERT ORDER ITEMS [cite: 275-289]
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1850.00),
(1, 6, 1, 1200.00),
(2, 3, 1, 7500.00),
(2, 7, 1, 1200.00),
(3, 5, 1, 12500.00),
(4, 4, 1, 4200.00);


