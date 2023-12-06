-- This SQL script creates a database schema for a soccer league. It defines several tables to store information about teams, players, referees, seasons, matches, and goals.

DROP DATABASE IF EXISTS fake_soccer_league_db;

CREATE DATABASE fake_soccer_league_db;

\c fake_soccer_league_db

-- The "Teams" table stores information about each team participating in the league, including a unique team ID and the team name.
CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    CONSTRAINT team_name UNIQUE (team_name)
);

-- The "Players" table stores information about each player, including a unique player ID, player name, and the team they belong to. The team ID is a foreign key referencing the "Teams" table.
CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id),
    CONSTRAINT player_name UNIQUE (player_name)
);

-- The "Referees" table stores information about each referee, including a unique referee ID and the referee name.
CREATE TABLE Referees (
    referee_id INT PRIMARY KEY,
    referee_name VARCHAR(100) NOT NULL UNIQUE
    
);

-- The "Seasons" table stores information about each season, including a unique season ID, start date, and end date.
CREATE TABLE Seasons (
    season_id INT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- The "Matches" table stores information about each match, including a unique match ID, the IDs of the two teams playing, the ID of the referee officiating the match, the ID of the season the match belongs to, and the match date. The team IDs, referee ID, and season ID are foreign keys referencing the respective tables.
CREATE TABLE Matches (
    match_id INT PRIMARY KEY UNIQUE,
    team1_id INT,
    team2_id INT,
    referee_id INT UNIQUE,
    season_id INT UNIQUE,
    match_date DATE NOT NULL,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
    FOREIGN KEY (referee_id) REFERENCES Referees(referee_id),
    FOREIGN KEY (season_id) REFERENCES Seasons(season_id)
);

-- The "Goals" table stores information about each goal scored in a match, including a unique goal ID, the ID of the player who scored the goal, the ID of the match the goal was scored in, and the time of the goal. The player ID and match ID are foreign keys referencing the "Players" and "Matches" tables respectively.
CREATE TABLE Goals (
    goal_id INT PRIMARY KEY,
    player_id INT UNIQUE,
    match_id INT UNIQUE,
    goal_time TIME NOT NULL,
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);

INSERT INTO Teams 
(team_id, team_name) 
VALUES
(1, 'Team A'),
(2, 'Team B'),
(3, 'Team C');

INSERT INTO Players 
(player_id, player_name, team_id) 
VALUES
(1, 'Player 1', 1),
(2, 'Player 2', 2),
(3, 'Player 3', 3);


INSERT INTO Referees 
(referee_id, referee_name) 
VALUES
(1, 'Referee 1'),
(2, 'Referee 2'),
(3, 'Referee 3');

INSERT INTO Seasons 
(season_id, start_date, end_date) 
VALUES
(1, '2022-01-01', '2022-12-31'),
(2, '2023-01-01', '2023-12-31'),
(3, '2024-01-01', '2024-12-31');

INSERT INTO Matches 
(match_id, team1_id, team2_id, referee_id, season_id, match_date) 
VALUES
(1, 1, 2, 1, 1, '2022-01-01'),
(2, 2, 3, 2, 2, '2023-01-01'),
(3, 3, 1, 3, 3, '2024-01-01');

INSERT INTO Goals 
(goal_id, player_id, match_id, goal_time) 
VALUES
(1, 1, 1, '00:30:00'),
(2, 2, 2, '00:45:00'),
(3, 3, 3, '00:60:00');