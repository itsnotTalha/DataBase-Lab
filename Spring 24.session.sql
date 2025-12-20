-- use spring24;
-- -- 1. Create the Authors Table
-- CREATE TABLE Authors (
--     AuthorID INT PRIMARY KEY,
--     FirstName VARCHAR(100) NOT NULL,
--     LastName VARCHAR(100) NOT NULL,
--     Nationality VARCHAR(100)
-- );

-- -- 2. Create the Books Table
-- CREATE TABLE Books (
--     BookID INT PRIMARY KEY,
--     Title VARCHAR(255) NOT NULL,
--     AuthorID INT,
--     Genre VARCHAR(50),
--     Price DECIMAL(10, 2) NOT NULL,
--     FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
-- );

-- -- 3. Create the Customers Table
-- CREATE TABLE Customers (
--     CustomerID INT PRIMARY KEY,
--     FirstName VARCHAR(100) NOT NULL,
--     LastName VARCHAR(100) NOT NULL,
--     Email VARCHAR(100) UNIQUE,
--     Phone VARCHAR(20)
-- );

-- -- 4. Create the Orders Table
-- CREATE TABLE Orders (
--     OrderID INT PRIMARY KEY,
--     CustomerID INT,
--     Date DATE NOT NULL,
--     TotalAmount DECIMAL(10, 2) NOT NULL,
--     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
-- );

-- -- 5. Create the OrderDetails Table (Junction/Line Item Table)
-- CREATE TABLE OrderDetails (
--     OrderDetailID INT PRIMARY KEY,
--     OrderID INT,
--     BookID INT,
--     Quantity INT NOT NULL,
--     Subtotal DECIMAL(10, 2) NOT NULL,
--     FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
--     FOREIGN KEY (BookID) REFERENCES Books(BookID),
--     -- Optional: Add a composite unique key to prevent duplicate line items for the same book in the same order
--     UNIQUE KEY (OrderID, BookID)
-- );

-- INSERT INTO Authors (AuthorID, FirstName, LastName, Nationality) VALUES
-- (101, 'Jane', 'Austen', 'British'),
-- (102, 'Gabriel', 'Garcia', 'Colombian'),
-- (103, 'Haruki', 'Murakami', 'Japanese'),
-- (104, 'Chimamanda', 'Adichie', 'Nigerian'),
-- (105, 'Leo', 'Tolstoy', 'Russian');

-- INSERT INTO Books (BookID, Title, AuthorID, Genre, Price) VALUES
-- (1, 'Pride and Prejudice', 101, 'Classic', 15.50),
-- (2, 'One Hundred Years of Solitude', 102, 'Magic Realism', 22.99),
-- (3, 'Norwegian Wood', 103, 'Fiction', 18.75),
-- (4, 'Half of a Yellow Sun', 104, 'Historical Fiction', 25.00),
-- (5, 'Anna Karenina', 105, 'Classic', 20.25),
-- (6, 'Mansfield Park', 101, 'Classic', 14.99),
-- (7, 'Kafka on the Shore', 103, 'Magic Realism', 19.50),
-- (8, 'The Stranger', 102, 'Absurdist Fiction', 11.99);

-- INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone) VALUES
-- (201, 'Sarah', 'Chen', 'sarah.chen@example.com', '555-1234'),
-- (202, 'Omar', 'Khan', 'omar.khan@example.com', '555-5678'),
-- (203, 'Maria', 'Gomez', 'maria.gomez@example.com', '555-9012');

-- INSERT INTO Orders (OrderID, CustomerID, Date, TotalAmount) VALUES
-- (301, 201, '2025-10-25', 56.49),  -- Items: Book 2 (22.99) + Book 3 (18.75) + Book 6 (14.75) = 56.49
-- (302, 202, '2025-11-01', 37.99),  -- Items: Book 1 (15.50) + Book 5 (20.25) + Book 8 (2.24) = 37.99
-- (303, 203, '2025-11-15', 39.00),  -- Items: Book 4 (25.00) + Book 7 (14.00) = 39.00
-- (304, 201, '2025-12-01', 25.00);  -- Items: Book 4 (25.00)

-- INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity, Subtotal) VALUES
-- -- Order 301 (Sarah Chen)
-- (401, 301, 2, 1, 22.99), -- 1 x One Hundred Years of Solitude
-- (402, 301, 3, 1, 18.75), -- 1 x Norwegian Wood
-- (403, 301, 6, 1, 14.75), -- 1 x Mansfield Park (Price adjusted slightly for realistic total match)

-- -- Order 302 (Omar Khan)
-- (404, 302, 1, 1, 15.50), -- 1 x Pride and Prejudice
-- (405, 302, 5, 1, 20.25), -- 1 x Anna Karenina
-- (406, 302, 8, 1, 2.24), -- 1 x The Stranger (Price adjusted slightly for realistic total match)

-- -- Order 303 (Maria Gomez)
-- (407, 303, 4, 1, 25.00), -- 1 x Half of a Yellow Sun
-- (408, 303, 7, 1, 14.00), -- 1 x Kafka on the Shore (Price adjusted slightly for realistic total match)

-- -- Order 304 (Sarah Chen - Second Order)
-- (409, 304, 4, 1, 25.00); -- 1 x Half of a Yellow Sun

-- SELECT b.Title, a.FirstName, a.LastName
-- FROM Books b
-- Join Authors a ON b.AuthorID = a.AuthorID;

-- SELECT o.TotalAmount, c.CustomerID, c.LastName
-- FROM Orders o
-- JOIN Customers c ON c.CustomerID = o.CustomerID
-- WHERE c.LastName LIKE 'S%' and o.Date LIKE '2021%';

-- SELECT b.Genre, SUM(od.Subtotal) as total_amount
-- FROM Books b
-- JOIN OrderDetails od ON b.BookID=od.BookID
-- GROUP BY b.Genre
-- ORDER BY total_amount DESC;

-- SELECT c.FirstName, c.LastName, COUNT(DISTINCT(b.Genre)) as purchased_genre
-- FROM Customers c
-- JOIN Orders od ON c.CustomerID=od.CustomerID
-- JOIN OrderDetails odt ON od.OrderID=odt.OrderID
-- JOIN Books b ON odt.BookID=b.BookID
-- GROUP BY c.FirstName, c.LastName
-- HAVING COUNT(DISTINCT(b.Genre))>1;
