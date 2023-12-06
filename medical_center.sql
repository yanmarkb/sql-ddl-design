-- This SQL script creates tables for a medical center database.
-- The tables include Doctors, Patients, Visits, and Diseases.

DROP DATABASE IF EXISTS fake_medical_center_db;

CREATE DATABASE fake_medical_center_db;

\c fake_medical_center_db

-- The Doctors table stores information about the doctors, including their ID and name.
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY UNIQUE,
    doctor_name VARCHAR(100) NOT NULL UNIQUE
);

-- The Patients table stores information about the patients, including their ID and name.
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY UNIQUE,
    patient_name VARCHAR(100) NOT NULL UNIQUE
);

-- The Visits table stores information about the visits made by patients to doctors, including the visit ID, doctor ID, patient ID, and visit date.
CREATE TABLE Visits (
    visit_id INT PRIMARY KEY UNIQUE,
    doctor_id INT UNIQUE,
    patient_id INT UNIQUE,
    visit_date DATE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- The Diseases table stores information about the diseases diagnosed during the visits, including the disease ID, disease name, and visit ID.
CREATE TABLE Diseases (
    disease_id INT PRIMARY KEY UNIQUE,
    disease_name VARCHAR(100) NOT NULL UNIQUE,
    visit_id INT,
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id)
);

-- The tables are linked through foreign key constraints to ensure data integrity.

INSERT INTO Doctors 
(doctor_id, doctor_name) 
VALUES
(1, 'Dr. Smith'),
(2, 'Dr. Johnson'),
(3, 'Dr. Williams');

INSERT INTO Patients 
(patient_id, patient_name) 
VALUES
(1, 'John Doe'),
(2, 'Jane Doe'),
(3, 'Jim Brown');

INSERT INTO Visits 
(visit_id, doctor_id, patient_id, visit_date) 
VALUES
(1, 1, 1, '2022-01-01'),
(2, 2, 2, '2022-01-02'),
(3, 3, 3, '2022-01-03');

INSERT INTO Diseases 
(disease_id, disease_name, visit_id) 
VALUES
(1, 'Flu', 1),
(2, 'Cold', 2),
(3, 'COVID-19', 3);