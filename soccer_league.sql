-- This SQL script creates a database schema for a soccer league. It defines several tables to store information about teams, players, referees, seasons, matches, and goals.

-- Drop the database if it already exists
DROP DATABASE IF EXISTS fake_soccer_league_db;

-- Create a new database
CREATE DATABASE fake_soccer_league_db;

-- Connect to the newly created database
\c fake_soccer_league_db

-- The "Teams" table stores information about each team participating in the league, including a unique team ID and the team name.
CREATE TABLE Teams (
    team_id INT PRIMARY KEY, -- Unique identifier for each team
    team_name VARCHAR(100) NOT NULL, -- Name of the team
    CONSTRAINT team_name UNIQUE (team_name) -- Ensure team names are unique
);

-- The "Players" table stores information about each player, including a unique player ID, player name, and the team they belong to. The team ID is a foreign key referencing the "Teams" table.
CREATE TABLE Players (
    player_id INT PRIMARY KEY, -- Unique identifier for each player
    player_name VARCHAR(100) NOT NULL, -- Name of the player
    team_id INT, -- ID of the team the player belongs to
    FOREIGN KEY (team_id) REFERENCES Teams(team_id) ON DELETE SET NULL, -- Establish a relationship with the "Teams" table
    CONSTRAINT player_name UNIQUE (player_name) -- Ensure player names are unique
);

-- The "Referees" table stores information about each referee, including a unique referee ID and the referee name.
CREATE TABLE Referees (
    referee_id INT PRIMARY KEY, -- Unique identifier for each referee
    referee_name VARCHAR(100) NOT NULL UNIQUE -- Name of the referee (must be unique)
);

-- The "Seasons" table stores information about each season, including a unique season ID, start date, and end date.
CREATE TABLE Seasons (
    season_id INT PRIMARY KEY, -- Unique identifier for each season
    start_date DATE NOT NULL, -- Start date of the season
    end_date DATE NOT NULL -- End date of the season
);

-- The "Matches" table stores information about each match, including a unique match ID, the IDs of the two teams playing, the ID of the referee officiating the match, the ID of the season the match belongs to, and the match date. The team IDs, referee ID, and season ID are foreign keys referencing the respective tables.
CREATE TABLE Matches (
    match_id INT PRIMARY KEY UNIQUE, -- Unique identifier for each match
    team1_id INT, -- ID of the first team
    team2_id INT, -- ID of the second team
    referee_id INT UNIQUE, -- ID of the referee
    season_id INT UNIQUE, -- ID of the season
    match_date DATE NOT NULL, -- Date of the match
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id) ON DELETE SET NULL, -- Establish a relationship with the "Teams" table
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id) ON DELETE SET NULL, -- Establish a relationship with the "Teams" table
    FOREIGN KEY (referee_id) REFERENCES Referees(referee_id) ON DELETE SET NULL, -- Establish a relationship with the "Referees" table
    FOREIGN KEY (season_id) REFERENCES Seasons(season_id) ON DELETE SET NULL -- Establish a relationship with the "Seasons" table
);

-- The "Goals" table stores information about each goal scored in a match, including a unique goal ID, the ID of the player who scored the goal, the ID of the match the goal was scored in, and the time of the goal. The player ID and match ID are foreign keys referencing the "Players" and "Matches" tables respectively.
CREATE TABLE Goals (
    goal_id INT PRIMARY KEY, -- Unique identifier for each goal
    player_id INT UNIQUE, -- ID of the player who scored the goal
    match_id INT UNIQUE, -- ID of the match the goal was scored in
    goal_time TIME NOT NULL, -- Time of the goal
    FOREIGN KEY (player_id) REFERENCES Players(player_id) ON DELETE SET NULL, -- Establish a relationship with the "Players" table
    FOREIGN KEY (match_id) REFERENCES Matches(match_id) ON DELETE SET NULL -- Establish a relationship with the "Matches" table
);

-- Insert sample data into the "Teams" table
INSERT INTO Teams 
(team_id, team_name) 
VALUES
(1, 'Team A'),
(2, 'Team B'),
(3, 'Team C');

-- Insert sample data into the "Players" table
INSERT INTO Players 
(player_id, player_name, team_id) 
VALUES
(1, 'Player 1', 1),
(2, 'Player 2', 2),
(3, 'Player 3', 3);

-- Insert sample data into the "Referees" table
INSERT INTO Referees 
(referee_id, referee_name) 
VALUES
(1, 'Referee 1'),
(2, 'Referee 2'),
(3, 'Referee 3');

-- Insert sample data into the "Seasons" table
INSERT INTO Seasons 
(season_id, start_date, end_date) 
VALUES
(1, '2022-01-01', '2022-12-31'),
(2, '2023-01-01', '2023-12-31'),
(3, '2024-01-01', '2024-12-31');

-- Insert sample data into the "Matches" table
INSERT INTO Matches 
(match_id, team1_id, team2_id, referee_id, season_id, match_date) 
VALUES
(1, 1, 2, 1, 1, '2022-01-01'),
(2, 2, 3, 2, 2, '2023-01-01'),
(3, 3, 1, 3, 3, '2024-01-01');

-- Insert sample data into the "Goals" table
INSERT INTO Goals 
(goal_id, player_id, match_id, goal_time) 
VALUES
(1, 1, 1, '00:30:00'),
(2, 2, 2, '00:45:00'),
(3, 3, 3, '00:60:00');