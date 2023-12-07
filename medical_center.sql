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
    doctor_id INT PRIMARY KEY, -- Unique identifier for each doctor
    doctor_name VARCHAR(100) NOT NULL -- Name of the doctor
);

-- The Patients table stores information about the patients, including their ID and name.
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY, -- Unique identifier for each patient
    patient_name VARCHAR(100) NOT NULL -- Name of the patient
);

-- The Visits table stores information about the visits made by patients to doctors, including the visit ID, doctor ID, patient ID, and visit date.
CREATE TABLE Visits (
    visit_id INT PRIMARY KEY, -- Unique identifier for each visit
    doctor_id INT NOT NULL, -- ID of the doctor associated with the visit
    patient_id INT NOT NULL, -- ID of the patient associated with the visit
    visit_date DATE, -- Date of the visit.
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL, -- Ensures that the doctor ID references a valid doctor in the Doctors table
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE SET NULL -- Ensures that the patient ID references a valid patient in the Patients table
);

-- The Diseases table stores information about the diseases diagnosed during the visits, including the disease ID, disease name.
CREATE TABLE Diseases (
    disease_id INT PRIMARY KEY, -- Unique identifier for each disease
    disease_name VARCHAR(100) NOT NULL -- Name of the disease
);

-- The Diagnoses table stores information about the diagnoses made during the visits, including the diagnosis ID, visit ID, disease ID, and notes.
CREATE TABLE Diagnoses (
    diagnosis_id INT PRIMARY KEY, -- Unique identifier for each diagnosis
    visit_id INT, -- ID of the visit associated with the diagnosis
    disease_id INT, -- ID of the disease associated with the diagnosis
    notes VARCHAR(255), -- Additional notes for the diagnosis
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id) ON DELETE SET NULL, -- Ensures that the visit ID references a valid visit in the Visits table
    FOREIGN KEY (disease_id) REFERENCES Diseases(disease_id) ON DELETE SET NULL -- Ensures that the disease ID references a valid disease in the Diseases table
);

-- The tables are linked through foreign key constraints to ensure data integrity.

-- Create a table to store the relationship between visits and diseases
CREATE TABLE VisitDiseases (
    visit_id INT,
    disease_id INT,
    PRIMARY KEY (visit_id, disease_id),
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id) ON DELETE CASCADE,
    FOREIGN KEY (disease_id) REFERENCES Diseases(disease_id) ON DELETE CASCADE
);

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
(disease_id, disease_name) 
VALUES
(1, 'Flu'),
(2, 'Cold'),
(3, 'COVID-19');

-- Insert sample data into the Diagnoses table
INSERT INTO Diagnoses 
(diagnosis_id, visit_id, disease_id, notes) 
VALUES
(1, 1, 1, 'Patient has high fever'),
(2, 2, 2, 'Patient has a runny nose'),
(3, 3, 3, 'Patient tested positive for COVID-19');

-- Insert sample data into the VisitDiseases table
INSERT INTO VisitDiseases 
(visit_id, disease_id) 
VALUES
(1, 1),
(2, 2),
(3, 3);
