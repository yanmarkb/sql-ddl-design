-- This SQL script creates the necessary tables for a Craigslist-like database.
-- The tables include Regions, Users, Categories, and Posts.

-- Drop the database if it already exists
DROP DATABASE IF EXISTS fake_craigslist_db;

-- Create a new database called fake_craigslist_db
CREATE DATABASE fake_craigslist_db;

-- Connect to the newly created database
\c fake_craigslist_db

-- The Regions table stores information about different regions.
CREATE TABLE Regions (
    region_id INT PRIMARY KEY, -- Unique identifier for each region
    region_name VARCHAR(100) NOT NULL -- Name of the region
);

-- The Users table stores information about users, including their preferred region.
CREATE TABLE Users (
    user_id INT PRIMARY KEY, -- Unique identifier for each user
    user_name VARCHAR(100) NOT NULL UNIQUE, -- Name of the user (must be unique). Could use PRIMARY KEY here instead of UNIQUE and NOT NULL?
    preferred_region_id INT, -- The region preferred by the user
    FOREIGN KEY (preferred_region_id) REFERENCES Regions(region_id) ON DELETE SET NULL -- Foreign key constraint to ensure the preferred region exists in the Regions table
);

-- The Categories table stores information about different categories of posts.
CREATE TABLE Categories (
    category_id INT PRIMARY KEY, -- Unique identifier for each category
    category_name VARCHAR(100) NOT NULL -- Name of the category
);

-- The Posts table stores information about individual posts, including the user, location, region, and category.
CREATE TABLE Posts (
    post_id INT PRIMARY KEY, -- Unique identifier for each post
    title VARCHAR(100) NOT NULL, -- Title of the post
    text TEXT NOT NULL, -- Text content of the post
    user_id INT, -- The user who created the post. Maybe this should be UNIQUE? 
    location VARCHAR(100) NOT NULL, -- Location of the post
    region_id INT, -- The region associated with the post
    category_id INT, -- The category of the post
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL, -- Foreign key constraint to ensure the user exists in the Users table
    FOREIGN KEY (region_id) REFERENCES Regions(region_id) ON DELETE SET NULL, -- Foreign key constraint to ensure the region exists in the Regions table
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL -- Foreign key constraint to ensure the category exists in the Categories table
);

-- Insert sample data into the Regions table
INSERT INTO Regions 
(region_id, region_name) 
VALUES
(1, 'San Francisco'),
(2, 'Atlanta'),
(3, 'Seattle');

-- Insert sample data into the Users table
INSERT INTO Users 
(user_id, user_name, preferred_region_id) 
VALUES
(1, 'JohnDoe', 1), 
(2, 'JaneDoe', 2), 
(3, 'JimBrown', 3); 

-- Insert sample data into the Categories table
INSERT INTO Categories 
(category_id, category_name) 
VALUES
(1, 'Electronics'), 
(2, 'Cars'), 
(3, 'Furniture'); 

-- Insert sample data into the Posts table
INSERT INTO Posts 
(post_id, title, text, user_id, location, region_id, category_id) 
VALUES
(1, 'Selling iPhone', 'Brand new iPhone for sale', 1, 'San Francisco', 1, 1), 
(2, 'Used Car', 'Used car in good condition', 2, 'Atlanta', 2, 2), 
(3, 'Sofa', 'Comfortable sofa for sale', 3, 'Seattle', 3, 3); 
