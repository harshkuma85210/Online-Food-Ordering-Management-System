
DROP DATABASE IF EXISTS food_ordering;
CREATE DATABASE food_ordering;
USE food_ordering;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(200)
);

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Food_Items (
    food_id INT AUTO_INCREMENT PRIMARY KEY,
    food_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (food_id) REFERENCES Food_Items(food_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers (name, phone, email, address) VALUES
('Harsh Kumar','9876543210','harsh@gmail.com','Punjab'),
('Rahul Kumar','9876543211','rahul@gmail.com','Chandigarh'),
('Aman Singh','9876543212','aman@gmail.com','Mohali'),
('Rohit Sharma','9876543213','rohit@gmail.com','Kharar'),
('Priya Singh','9876543214','priya@gmail.com','Zirakpur');

INSERT INTO Categories (category_name) VALUES
('Pizza'),
('Burger'),
('Drinks'),
('Chinese'),
('South Indian');

INSERT INTO Food_Items (food_name,price,category_id) VALUES
('Margherita Pizza',199,1),
('Cheese Burger',99,2),
('Cold Coffee',79,3),
('Veg Noodles',149,4),
('Masala Dosa',120,5),
('Farmhouse Pizza',249,1),
('Veg Burger',89,2),
('Fresh Juice',60,3);

INSERT INTO Orders (customer_id,order_date,total_amount,order_status) VALUES
(1,'2026-11-01',298,'Delivered'),
(2,'2026-11-02',149,'Pending'),
(3,'2026-11-02',199,'Preparing'),
(4,'2026-11-02',120,'Delivered'),
(5,'2026-11-02',249,'Cancelled');

INSERT INTO Order_Details (order_id,food_id,quantity,subtotal) VALUES
(1,1,1,199),
(1,2,1,99),
(2,4,1,149),
(3,1,1,199),
(4,5,1,120),
(5,6,1,249);

INSERT INTO Payments (order_id,payment_date,payment_method,payment_status) VALUES
(1,'2026-11-01','UPI','Paid'),
(2,'2026-11-02','Cash','Pending'),
(3,'2026-11-02','Card','Paid'),
(4,'2026-11-02','UPI','Paid'),
(5,'2026-11-02','Cash','Refunded');

SELECT * FROM Customers;
SELECT * FROM Categories;
SELECT * FROM Food_Items;
SELECT * FROM Orders;
SELECT * FROM Order_Details;
SELECT * FROM Payments;

SELECT * FROM Food_Items WHERE price > 100;

SELECT * FROM Food_Items ORDER BY price DESC;

SELECT COUNT(*) AS Total_Customers FROM Customers;

SELECT SUM(total_amount) AS Total_Sales
FROM Orders
WHERE order_status = 'Delivered';

SELECT Customers.name, Orders.order_id, Orders.total_amount, Orders.order_status
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id;

SELECT Orders.order_id, Customers.name, Food_Items.food_name,
Order_Details.quantity, Order_Details.subtotal
FROM Order_Details
INNER JOIN Orders ON Order_Details.order_id = Orders.order_id
INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
INNER JOIN Food_Items ON Order_Details.food_id = Food_Items.food_id;

SELECT Categories.category_name, COUNT(Food_Items.food_id) AS Total_Items
FROM Categories
LEFT JOIN Food_Items
ON Categories.category_id = Food_Items.category_id
GROUP BY Categories.category_id, Categories.category_name;

SELECT payment_method, COUNT(*) AS Total_Payments
FROM Payments
GROUP BY payment_method;

SELECT * FROM Orders WHERE order_status = 'Delivered';

SELECT food_name, price FROM Food_Items WHERE price BETWEEN 100 AND 200;

SELECT MAX(price) AS Highest_Price FROM Food_Items;

SELECT MIN(price) AS Lowest_Price FROM Food_Items;

SELECT AVG(price) AS Average_Price FROM Food_Items;

SELECT order_status, COUNT(*) AS Total_Orders
FROM Orders
GROUP BY order_status;

SELECT Customers.name, SUM(Orders.total_amount) AS Total_Order_Amount
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
GROUP BY Customers.customer_id, Customers.name;
