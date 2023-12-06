-- This SQL script creates the necessary tables for a Craigslist-like database.
-- The tables include Regions, Users, Categories, and Posts.

DROP DATABASE IF EXISTS fake_craigslist_db;

CREATE DATABASE fake_craigslist_db;

\c fake_craigslist_db

-- The Regions table stores information about different regions.
CREATE TABLE Regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL
);

-- The Users table stores information about users, including their preferred region.
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL UNIQUE,
    preferred_region_id INT,
    FOREIGN KEY (preferred_region_id) REFERENCES Regions(region_id) ON DELETE SET NULL
);

-- The Categories table stores information about different categories of posts.
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- The Posts table stores information about individual posts, including the user, location, region, and category.
CREATE TABLE Posts (
    post_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    text TEXT NOT NULL,
    user_id INT,
    location VARCHAR(100) NOT NULL,
    region_id INT,
    category_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (region_id) REFERENCES Regions(region_id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

INSERT INTO Regions 
(region_id, region_name) 
VALUES
(1, 'San Francisco'),
(2, 'Atlanta'),
(3, 'Seattle');

INSERT INTO Users 
(user_id, user_name, preferred_region_id) 
VALUES
(1, 'JohnDoe', 1),
(2, 'JaneDoe', 2),
(3, 'JimBrown', 3);

INSERT INTO Categories 
(category_id, category_name) 
VALUES
(1, 'Electronics'),
(2, 'Cars'),
(3, 'Furniture');

INSERT INTO Posts 
(post_id, title, text, user_id, location, region_id, category_id) 
VALUES
(1, 'Selling iPhone', 'Brand new iPhone for sale', 1, 'San Francisco', 1, 1),
(2, 'Used Car', 'Used car in good condition', 2, 'Atlanta', 2, 2),
(3, 'Sofa', 'Comfortable sofa for sale', 3, 'Seattle', 3, 3);