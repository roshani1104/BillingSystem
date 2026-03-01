CREATE DATABASE IF NOT EXISTS food_order;
USE food_order;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;

CREATE TABLE menu_items (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100) NOT NULL,
    category VARCHAR(50)  NOT NULL,
    price    DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    ref        VARCHAR(20)    NOT NULL UNIQUE,
    subtotal   DECIMAL(10,2)  NOT NULL,
    tax        DECIMAL(10,2)  NOT NULL,
    total      DECIMAL(10,2)  NOT NULL,
    created_at DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    order_id   INT            NOT NULL,
    item_name  VARCHAR(100)   NOT NULL,
    quantity   INT            NOT NULL,
    unit_price DECIMAL(10,2)  NOT NULL,
    line_total DECIMAL(10,2)  NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

INSERT INTO menu_items (name, category, price) VALUES
('Poha', 'Breakfast', 40),('Upma', 'Breakfast', 45),('Idli (2 pcs)', 'Breakfast', 30),
('Medu Vada (2 pcs)', 'Breakfast', 35),('Masala Dosa', 'Breakfast', 80),
('Onion Dosa', 'Breakfast', 90),('Rava Dosa', 'Breakfast', 100),
('Aloo Paratha', 'Breakfast', 70),('Paneer Paratha', 'Breakfast', 90),('Chai', 'Breakfast', 15);

INSERT INTO menu_items (name, category, price) VALUES
('Paneer Butter Masala', 'North Indian', 180),('Shahi Paneer', 'North Indian', 190),
('Kadhai Paneer', 'North Indian', 170),('Dal Makhani', 'North Indian', 150),
('Dal Tadka', 'North Indian', 120),('Mix Veg', 'North Indian', 140),
('Jeera Rice', 'North Indian', 80),('Veg Biryani', 'North Indian', 160),
('Butter Naan', 'North Indian', 30),('Tandoori Roti', 'North Indian', 20);

INSERT INTO menu_items (name, category, price) VALUES
('Sambhar', 'South Indian', 40),('Chutney', 'South Indian', 20),
('Uttapam', 'South Indian', 90),('Pongal', 'South Indian', 70),
('Filter Coffee', 'South Indian', 50),('Ghee Dosa', 'South Indian', 100),
('Rava Idli', 'South Indian', 60),('Bisi Bele Bath', 'South Indian', 110),
('Vada Sambar', 'South Indian', 70),('Curd Rice', 'South Indian', 60);

INSERT INTO menu_items (name, category, price) VALUES
('Veg Noodles', 'Chinese', 90),('Hakka Noodles', 'Chinese', 100),
('Schezwan Noodles', 'Chinese', 110),('Fried Rice', 'Chinese', 100),
('Schezwan Fried Rice', 'Chinese', 120),('Manchurian Dry', 'Chinese', 110),
('Manchurian Gravy', 'Chinese', 130),('Spring Rolls', 'Chinese', 80),
('Veg Momos', 'Chinese', 90),('Hot & Sour Soup', 'Chinese', 60);

INSERT INTO menu_items (name, category, price) VALUES
('Margherita', 'Pizza', 185),('Cheese Burst', 'Pizza', 250),('Farmhouse', 'Pizza', 220),
('Mexican Green Wave', 'Pizza', 230),('Peppy Paneer', 'Pizza', 240),
('Veggie Paradise', 'Pizza', 200),('Double Cheese', 'Pizza', 210),
('Paneer Tikka Pizza', 'Pizza', 240),('BBQ Pizza', 'Pizza', 250),('Garlic Bread', 'Pizza', 70);

INSERT INTO menu_items (name, category, price) VALUES
('Veg Burger', 'Burgers', 60),('Cheese Burger', 'Burgers', 80),
('Paneer Burger', 'Burgers', 90),('Aloo Tikki Burger', 'Burgers', 50),
('Double Patty Burger', 'Burgers', 120),('Mexican Burger', 'Burgers', 100),
('BBQ Burger', 'Burgers', 110),('Fries', 'Burgers', 50),
('Peri Peri Fries', 'Burgers', 70),('Onion Rings', 'Burgers', 60);

INSERT INTO menu_items (name, category, price) VALUES
('Veg Sandwich', 'Sandwiches', 50),('Grilled Sandwich', 'Sandwiches', 70),
('Cheese Sandwich', 'Sandwiches', 80),('Club Sandwich', 'Sandwiches', 100),
('Paneer Sandwich', 'Sandwiches', 90),('Corn Sandwich', 'Sandwiches', 70),
('Chocolate Sandwich', 'Sandwiches', 80),('Toast Sandwich', 'Sandwiches', 50),
('Garlic Sandwich', 'Sandwiches', 60),('Veg Sub', 'Sandwiches', 110);

INSERT INTO menu_items (name, category, price) VALUES
('Pasta White Sauce', 'Italian', 120),('Pasta Red Sauce', 'Italian', 110),
('Alfredo Pasta', 'Italian', 150),('Arrabbiata Pasta', 'Italian', 140),
('Mac & Cheese', 'Italian', 160),('Spaghetti', 'Italian', 130),
('Veg Lasagna', 'Italian', 180),('Bruschetta', 'Italian', 90),
('Penne Arrabiata', 'Italian', 140),('Tiramisu', 'Italian', 150);

INSERT INTO menu_items (name, category, price) VALUES
('Veg Salad', 'Salads', 50),('Greek Salad', 'Salads', 80),('Sprouts Salad', 'Salads', 60),
('Fruit Salad', 'Salads', 70),('Cucumber Salad', 'Salads', 40),('Tomato Salad', 'Salads', 35),
('Corn Salad', 'Salads', 50),('Mix Salad', 'Salads', 60),('Carrot Salad', 'Salads', 45),
('Healthy Salad', 'Salads', 90);

INSERT INTO menu_items (name, category, price) VALUES
('Quinoa Bowl', 'Healthy Bowls', 150),('Brown Rice Bowl', 'Healthy Bowls', 140),
('Veg Bowl', 'Healthy Bowls', 120),('Sprouts Bowl', 'Healthy Bowls', 100),
('Salad Bowl', 'Healthy Bowls', 110),('Protein Bowl', 'Healthy Bowls', 180),
('Fruit Bowl', 'Healthy Bowls', 90),('Oatmeal Bowl', 'Healthy Bowls', 80),
('Greek Yogurt Bowl', 'Healthy Bowls', 120),('Chia Seed Bowl', 'Healthy Bowls', 150);

INSERT INTO menu_items (name, category, price) VALUES
('Gulab Jamun', 'Desserts', 40),('Rasgulla', 'Desserts', 50),('Rasmalai', 'Desserts', 70),
('Brownie', 'Desserts', 120),('Pastry', 'Desserts', 50),('Ice Cream', 'Desserts', 60),
('Sundae', 'Desserts', 100),('Moong Dal Halwa', 'Desserts', 90),
('Gajar Ka Halwa', 'Desserts', 100),('Jalebi', 'Desserts', 50);

INSERT INTO menu_items (name, category, price) VALUES
('Cold Coffee', 'Beverages', 70),('Hot Coffee', 'Beverages', 50),('Tea', 'Beverages', 20),
('Lassi (Sweet)', 'Beverages', 60),('Lassi (Salted)', 'Beverages', 50),
('Buttermilk', 'Beverages', 25),('Milkshake', 'Beverages', 90),
('Orange Juice', 'Beverages', 70),('Lemon Soda', 'Beverages', 40),('Soft Drink', 'Beverages', 20);

SELECT DISTINCT category FROM menu_items;
SELECT COUNT(*) AS total_items FROM menu_items;
