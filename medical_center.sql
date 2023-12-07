-- This SQL script creates tables for a medical center database.
-- The tables include Doctors, Patients, Visits, Diseases, and Diagnoses.

-- Drop the database if it already exists
DROP DATABASE IF EXISTS fake_medical_center_db;

-- Create a new database
CREATE DATABASE fake_medical_center_db;

-- Connect to the newly created database
\c fake_medical_center_db

-- The Doctors table stores information about the doctors, including their ID and name.
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY UNIQUE, -- Unique identifier for each doctor. DOES PRIMARY KEY IMPLY UNIQUE?
    doctor_name VARCHAR(100) NOT NULL UNIQUE -- Name of the doctor. Maybe not a good idea to have purely unique names, but this is just an example. Is there an order NOT NULL and UNIQUE have to be in? Discuss with Ben.
);

-- The Patients table stores information about the patients, including their ID and name.
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY UNIQUE, -- Unique identifier for each patient
    patient_name VARCHAR(100) NOT NULL UNIQUE -- Name of the patient
);

-- The Visits table stores information about the visits made by patients to doctors, including the visit ID, doctor ID, patient ID, and visit date.
CREATE TABLE Visits (
    visit_id INT PRIMARY KEY UNIQUE, -- Unique identifier for each visit
    doctor_id INT UNIQUE, -- ID of the doctor associated with the visit.  Maybe make this NOT NULL?
    patient_id INT UNIQUE, -- ID of the patient associated with the visit. This too!
    visit_date DATE, -- Date of the visit.
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL, -- Ensures that the doctor ID references a valid doctor in the Doctors table
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE SET NULL -- Ensures that the patient ID references a valid patient in the Patients table
);

-- The Diseases table stores information about the diseases diagnosed during the visits, including the disease ID, disease name, and visit ID.
CREATE TABLE Diseases (
    disease_id INT PRIMARY KEY UNIQUE, -- Unique identifier for each disease
    disease_name VARCHAR(100) NOT NULL UNIQUE, -- Name of the disease. Maybe could use PRIMARY KEY here instead of UNIQUE and NOT NULL?
    visit_id INT, -- ID of the visit associated with the disease
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id) ON DELETE SET NULL -- Ensures that the visit ID references a valid visit in the Visits table
);

-- The Diagnoses table stores information about the diagnoses made during the visits, including the diagnosis ID, visit ID, disease ID, and notes.
CREATE TABLE Diagnoses (
    diagnosis_id INT PRIMARY KEY UNIQUE, -- Unique identifier for each diagnosis
    visit_id INT, -- ID of the visit associated with the diagnosis
    disease_id INT, -- ID of the disease associated with the diagnosis
    notes VARCHAR(255), -- Additional notes for the diagnosis
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id) ON DELETE SET NULL, -- Ensures that the visit ID references a valid visit in the Visits table
    FOREIGN KEY (disease_id) REFERENCES Diseases(disease_id) ON DELETE SET NULL -- Ensures that the disease ID references a valid disease in the Diseases table
);

-- The tables are linked through foreign key constraints to ensure data integrity.

-- Insert sample data into the Doctors table
INSERT INTO Doctors 
(doctor_id, doctor_name) 
VALUES
(1, 'Dr. Smith'),
(2, 'Dr. Johnson'),
(3, 'Dr. Williams');

-- Insert sample data into the Patients table
INSERT INTO Patients 
(patient_id, patient_name) 
VALUES
(1, 'John Doe'),
(2, 'Jane Doe'),
(3, 'Jim Brown');

-- Insert sample data into the Visits table
INSERT INTO Visits 
(visit_id, doctor_id, patient_id, visit_date) 
VALUES
(1, 1, 1, '2022-01-01'),
(2, 2, 2, '2022-01-02'),
(3, 3, 3, '2022-01-03');

-- Insert sample data into the Diseases table
INSERT INTO Diseases 
(disease_id, disease_name, visit_id) 
VALUES
(1, 'Flu', 1),
(2, 'Cold', 2),
(3, 'COVID-19', 3);

-- Insert sample data into the Diagnoses table
INSERT INTO Diagnoses 
(diagnosis_id, visit_id, disease_id, notes) 
VALUES
(1, 1, 1, 'Patient has high fever'),
(2, 2, 2, 'Patient has a runny nose'),
(3, 3, 3, 'Patient tested positive for COVID-19');
