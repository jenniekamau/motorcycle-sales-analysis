CREATE TABLE sales (
    order_number VARCHAR(20) PRIMARY KEY,
    date DATE,
    warehouse VARCHAR(50),
    client_type VARCHAR(50),
    product_line VARCHAR(100),
    quantity INT,
    unit_price NUMERIC(10, 2),
    total NUMERIC(10, 2),
    payment VARC(50),
    payment_fee FLOAT
);

COPY sales_staging 
FROM 'C:/Users/Public/sales_data.csv' 
DELIMITER ',' 
CSV HEADER;

SELECT*
FROM sales_staging
LIMIT 5;

INSERT INTO sales (
    date, 
    warehouse, 
    client_type, 
    product_line, 
    quantity, 
    unit_price, 
    total, 
    payment
)
SELECT 
    date::DATE,
    warehouse,
    client_type,
    product_line,
    quantity::INT,
    unit_price::FLOAT,
    total::FLOAT,
    payment
FROM sales_staging;

SELECT*
FROM sales
LIMIT 5;

