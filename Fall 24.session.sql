-- use fall24;
-- -- ============================
-- -- CREATE TABLES
-- -- ============================

-- CREATE TABLE Employee (
--     employee_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     salary DECIMAL(10,2)
-- );

-- CREATE TABLE Showroom (
--     showroom_id INT PRIMARY KEY,
--     location VARCHAR(100) NOT NULL,
--     opening_date DATE NOT NULL,
--     manager_id INT,
--     FOREIGN KEY (manager_id) REFERENCES Employee(employee_id)
-- );

-- CREATE TABLE Customer (
--     customer_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     email VARCHAR(100),
--     phone_number VARCHAR(20),
--     address VARCHAR(200)
-- );

-- CREATE TABLE Product (
--     product_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     description TEXT,
--     unit_price DECIMAL(10,2),
--     stock_quantity INT
-- );

-- CREATE TABLE `OrderTable` (   -- "Order" is a reserved keyword, so renaming to OrderTable
--     order_id INT PRIMARY KEY,
--     order_date DATE,
--     customer_id INT,
--     showroom_id INT,
--     FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
--     FOREIGN KEY (showroom_id) REFERENCES Showroom(showroom_id)
-- );

-- CREATE TABLE OrderDetails (
--     order_id INT,
--     product_id INT,
--     quantity INT,
--     total_price DECIMAL(10,2),
--     PRIMARY KEY (order_id, product_id),
--     FOREIGN KEY (order_id) REFERENCES `OrderTable`(order_id),
--     FOREIGN KEY (product_id) REFERENCES Product(product_id)
-- );

-- -- ============================
-- -- INSERT DUMMY DATA
-- -- ============================

-- -- Employees
-- INSERT INTO Employee VALUES
-- (1, 'Alice Johnson', 55000),
-- (2, 'Bob Smith', 60000),
-- (3, 'Charlie Brown', 58000),
-- (4, 'David Lee', 62000),
-- (5, 'Eva Green', 59000);

-- -- Showrooms
-- INSERT INTO Showroom VALUES
-- (1, 'New York', '2020-05-15', 1),
-- (2, 'Los Angeles', '2019-11-20', 2),
-- (3, 'Chicago', '2021-03-10', 3),
-- (4, 'Houston', '2022-07-01', 4);

-- -- Customers
-- INSERT INTO Customer VALUES
-- (1, 'Michael Scott', 'michael@dundermail.com', '123-456-7890', '1725 Slough Ave, Scranton'),
-- (2, 'Pam Beesly', 'pam@dundermail.com', '234-567-8901', '1725 Slough Ave, Scranton'),
-- (3, 'Jim Halpert', 'jim@dundermail.com', '345-678-9012', '1725 Slough Ave, Scranton'),
-- (4, 'Dwight Schrute', 'dwight@dundermail.com', '456-789-0123', 'Schrute Farms, PA'),
-- (5, 'Angela Martin', 'angela@dundermail.com', '567-890-1234', 'Scranton, PA');

-- -- Products
-- INSERT INTO Product VALUES
-- (1, 'Laptop', 'High performance laptop', 1200.00, 50),
-- (2, 'Smartphone', 'Latest model smartphone', 800.00, 100),
-- (3, 'Tablet', '10-inch tablet', 400.00, 70),
-- (4, 'Headphones', 'Wireless headphones', 150.00, 200),
-- (5, 'Smartwatch', 'Fitness smartwatch', 200.00, 150);

-- -- Orders
-- INSERT INTO `OrderTable` VALUES
-- (1, '2025-01-01', 1, 1),
-- (2, '2025-01-05', 2, 1),
-- (3, '2025-01-07', 3, 2),
-- (4, '2025-01-10', 4, 3),
-- (5, '2025-01-12', 5, 4);

-- -- OrderDetails
-- INSERT INTO OrderDetails VALUES
-- (1, 1, 1, 1200.00),
-- (1, 4, 2, 300.00),
-- (2, 2, 1, 800.00),
-- (2, 5, 1, 200.00),
-- (3, 3, 2, 800.00),
-- (4, 1, 1, 1200.00),
-- (4, 2, 1, 800.00),
-- (5, 4, 3, 450.00),
-- (5, 5, 2, 400.00);


-- ALTER TABLE Employee
-- -- ADD column showroom_id INT;
-- ADD CONSTRAINT fk_showroom_id 
-- FOREIGN KEY(showroom_id) REFERENCES Showroom(showroom_id); 

-- SELECT name, description, stock_quantity FROM Product
-- WHERE unit_price>1000;

-- SELECT e.name FROM Employee e
-- Join Showroom s ON s.manager_id=e.employee_id
-- JOIN Employee m ON s.manager_id=m.employee_id
-- WHERE e.salary>m.salary;

-- SELECT p.product_id, p.name, Count(od.order_id) as times_ordered
-- From Product p
-- LEFT JOIN OrderDetails od ON p.product_id=od.product_id
-- GROUP BY p.product_id, p.name
-- ORDER BY times_ordered DESC;

-- SELECT s.showroom_id, s.location, Count(e.employee_id) as total_employee
-- FROM Employee e
-- JOIN Showroom s on e.showroom_id=s.showroom_id
-- GROUP BY showroom_id, s.location
-- ORDER BY total_employee DESC
-- LIMIT 3;
