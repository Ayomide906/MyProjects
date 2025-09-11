CREATE DATABASE Hospital_record;
create table Patients_Table(
PatientID INT PRIMARY KEY,
`Name` VARCHAR(255),
Age INT,
Gender VARCHAR(100),
State VARCHAR(255)
);
INSERT INTO Patients_Table
VALUES 
(10001,"Jonathan Aminu",34,'Male','Jigawa'),
(10110,"Abubakar Sani",45,'Male','Kano'),
(10111,'Kangyang Bot',27,'Female','Plateau'),
(11111,'John Adamu',35,'Male','FCT Abuja'),
(12003,"Kemi Adebayo",57,'Female','Ogun'),
(11320,'Esther Ugo',28,'Female','Anambra'),
(34352,'Agatha Umar',37,'Female','Bayelsa'),
(45789,'Mike Udo',45,'Male','AkwaIbom');
CREATE TABLE Doctors_Table(
DoctorID INT PRIMARY KEY,
`Name` VARCHAR(255),
Speciaity varchar(100),
State varchar(100)
);
INSERT INTO Doctors_Table
VALUES
(32011,'Dr.John Olu','Cardiology','Nasarawa'),
(32013,'Dr.Baker John','Neurology','Cross River'),
(32014,'Dr.Aminu Abdul','Orthopedics','Sokoto'),
(32015,'Dr.Anita Chinedu','Dermatology','Abia'),
(32016,'Dr.Esther Job','Ophtalmology','Ekiti');
Select * from patients_table
where State ='FCT Abuja' or State='Plateau'