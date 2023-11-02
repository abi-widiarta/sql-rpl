-- -----------------------------------------------------
-- Database mytelkomedikalaravel
-- -----------------------------------------------------
CREATE DATABASE `mytelkomedikalaravel`;
USE `mytelkomedikalaravel` ;

-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`admins` (
  `ID_Admin` 		INT(11) NOT NULL AUTO_INCREMENT,
  `Username` 		VARCHAR(15) NOT NULL,
  `Name` 			VARCHAR(50) NOT NULL,
  `Email` 			VARCHAR(50) NOT NULL,
  `Password` 		VARCHAR(15) NOT NULL,
  `NoHp` 			VARCHAR(13) NOT NULL,
  `Alamat` 			VARCHAR(50) NOT NULL,
  
  PRIMARY KEY (`ID_Admin`)
);

-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`doctors` (
  `ID_Doctor` 		INT(11) NOT NULL AUTO_INCREMENT,
  `Username` 		VARCHAR(30) NOT NULL,
  `Name` 			VARCHAR(50) NOT NULL,
  `Email`			VARCHAR(50) NOT NULL,
  `Password` 		VARCHAR(15) NOT NULL,
  `NoHp` 			VARCHAR(13) NOT NULL,
  `Alamat` 			VARCHAR(100) NOT NULL,
  `Rating` 			FLOAT NOT NULL,
  
  PRIMARY KEY (`ID_Doctor`)
);


-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`doctor_schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`doctor_schedules` (
  `ID_DoctorSchedule` 	INT(11) NOT NULL AUTO_INCREMENT,
  `Hari` 			  	VARCHAR(6) NOT NULL,
  `JamMulai` 			TIME NOT NULL,
  `JamSelesai` 			TIME NOT NULL,
  `doctors_ID_Doctor` 	INT(11) NOT NULL,
  
  PRIMARY KEY (`ID_DoctorSchedule`),
  CONSTRAINT `fk_doctor_schedules_doctors1`
    FOREIGN KEY (`doctors_ID_Doctor`)
    REFERENCES `mytelkomedikalaravel`.`doctors` (`ID_Doctor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`patients` (
  `ID_Patient` 			INT(11) NOT NULL AUTO_INCREMENT,
  `Username` 			VARCHAR(15) NOT NULL,
  `Name` 				VARCHAR(50) NOT NULL,
  `Email` 				VARCHAR(50) NOT NULL,
  `Password` 			VARCHAR(15) NOT NULL,
  `Nim` 				VARCHAR(10) NOT NULL,
  `NoHp` 				VARCHAR(13) NOT NULL,
  `Alamat` 				VARCHAR(50) NOT NULL,
  `JenisKelamin`		CHAR(1) NOT NULL,
  `TanggalLahir` 		DATE NOT NULL,
  
  PRIMARY KEY (`ID_Patient`));


-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`reports` (
  `ID_Report` 			INT(11) NOT NULL AUTO_INCREMENT,
  `TinggiBadan` 		INT(3) NULL DEFAULT NULL,
  `BeratBadan` 			INT(3) NULL DEFAULT NULL,
  `Diagnosa` 			VARCHAR(100) NOT NULL,
  `Obat` 				VARCHAR(100) NOT NULL,
  `admins_ID_Admin` 	INT(11) NOT NULL,
  
  PRIMARY KEY (`ID_Report`),
  CONSTRAINT `fk_reports_admins1`
    FOREIGN KEY (`admins_ID_Admin`)
    REFERENCES `mytelkomedikalaravel`.`admins` (`ID_Admin`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`reservations` (
  `ID_Reservation` 			INT(11) NOT NULL AUTO_INCREMENT,
  `Tanggal` 				DATE NOT NULL,
  `StatusSelesai` 			TINYINT(1) NOT NULL,
  `NomorAntrian` 			INT(2) NOT NULL,
  `reports_ID_Report` 		INT(11) NOT NULL,
  `patients_ID_Patient` 	INT(11) NOT NULL,
  `doctors_ID_Doctor` 		INT(11) NOT NULL,
  
  PRIMARY KEY (`ID_Reservation`),
  CONSTRAINT `fk_reservations_reports1`
    FOREIGN KEY (`reports_ID_Report`)
    REFERENCES `mytelkomedikalaravel`.`reports` (`ID_Report`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reservations_patients1`
    FOREIGN KEY (`patients_ID_Patient`)
    REFERENCES `mytelkomedikalaravel`.`patients` (`ID_Patient`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reservations_doctors1`
    FOREIGN KEY (`doctors_ID_Doctor`)
    REFERENCES `mytelkomedikalaravel`.`doctors` (`ID_Doctor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`payments` (
  `ID_Payment` 					INT(11) NOT NULL AUTO_INCREMENT,
  `Nominal` 					INT(10) NOT NULL,
  `StatusSelesai`				TINYINT(1) NOT NULL,
  `reservations_ID_Reservation` INT(11) NOT NULL,
  
  PRIMARY KEY (`ID_Payment`),
  CONSTRAINT `fk_payments_reservations1`
    FOREIGN KEY (`reservations_ID_Reservation`)
    REFERENCES `mytelkomedikalaravel`.`reservations` (`ID_Reservation`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `mytelkomedikalaravel`.`recommendations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytelkomedikalaravel`.`recommendations` (
  `ID_Recommendation` 		INT(11) NOT NULL AUTO_INCREMENT,
  `patients_ID_Patient` 	INT(11) NOT NULL,
  `doctors_ID_Doctor` 		INT(11) NOT NULL,
  
  PRIMARY KEY (`ID_Recommendation`),
  CONSTRAINT `fk_recommendations_patients1`
    FOREIGN KEY (`patients_ID_Patient`)
    REFERENCES `mytelkomedikalaravel`.`patients` (`ID_Patient`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_recommendations_doctors1`
    FOREIGN KEY (`doctors_ID_Doctor`)
    REFERENCES `mytelkomedikalaravel`.`doctors` (`ID_Doctor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


INSERT INTO admins (Username, Name, Email, Password, NoHp, Alamat)
VALUES
  ('adminbudi', 'Budi Susanto', 'budisusanto@example.com', 'rahasia', '0822379910111', 'Jl. Diponegoro No. 10, Jakarta'),
  ('adminmerry', 'Merry Surya', 'merrysurya@example.com', 'rahasia2', '0822379910222', 'Jl. Kusuma No. 5, Bandung'),
  ('adminrini', 'Rini Pratama', 'rinipratama@example.com', 'rahasia3', '0822379910333', 'Jl. Pahlawan No. 15, Surabaya'),
  ('adminahmad', 'Ahmad Subagja', 'ahmadsubagja@example.com', 'rahasia4', '0822379910444', 'Jl. Jendral Sudirman No. 20, Medan'),
  ('admindewi', 'Dewi Wijaya', 'dewiwijaya@example.com', 'rahasia5', '0822379910555', 'Jl. Merdeka No. 25, Bandung');

INSERT INTO doctors (Username, Name, Email, Password, NoHp, Alamat, Rating)
VALUES
  ('drbambang', 'Dr. Bambang Siregar', 'drbambang@example.com', 'rahasia1', '082345123123', 'Jl. Sisingamangaraja No. 30, Jakarta', 4.5),
  ('drsri', 'Dr. Sri Hartati', 'drsri@example.com', 'rahasia2', '082345123098', 'Jl. Sudirman No. 40, Surabaya', 4.2),
  ('drratna', 'Dr. Ratna Wijaya', 'drratna@example.com', 'rahasia3', '082345123675', 'Jl. Gajah Mada No. 50, Yogyakarta', 4.7),
  ('dragus', 'Dr. Agus Prabowo', 'dragus@example.com', 'rahasia4', '082345123067', 'Jl. Veteran No. 60, Bandung', 4.9),
  ('drayu', 'Dr. Ayu Wulandari', 'drayu@example.com', 'rahasia5', '082345123876', 'Jl. Diponegoro No. 70, Semarang', 4.4);

INSERT INTO doctor_schedules (Hari, JamMulai, JamSelesai, doctors_ID_Doctor)
VALUES
  ('Senin', '08:00:00', '16:00:00', 1), 
  ('Selasa', '09:00:00', '17:00:00', 2), 
  ('Rabu', '10:00:00', '18:00:00', 3), 
  ('Kamis', '07:00:00', '15:00:00', 4),
  ('Jumat', '08:30:00', '16:30:00', 5); 
  
INSERT INTO patients (Username, Name, Email, Password, Nim, NoHp, Alamat, JenisKelamin, TanggalLahir)
VALUES
  ('anisari', 'Ani Sari', 'anisari@example.com', 'rahasia1', '1301218888', '081234567890', 'Jl. Cendrawasih No. 12, Bandung', 'P', '2000-01-01'),
  ('rudiperdana', 'Rudi Perdana', 'rudiperdana@example.com', 'rahasia2', '1301218855', '087654321098', 'Jl. Pahlawan No. 5, Surabaya', 'L', '1999-02-15'),
  ('sitirahayu', 'Siti Rahayu', 'siti@example.com', 'rahasia3', '1301218812', '081234567895', 'Jl. Sisingamangaraja No. 18, Jakarta', 'P', '2001-07-20'),
  ('yusufpratama', 'Yusuf Pratama', 'yusufpratama@example.com', 'rahasia4', '1301218831', '085566778899', 'Jl. Sudirman No. 27, Medan', 'L', '2002-05-10'),
  ('linasuryani', 'Lina Suryani', 'linasuryani@example.com', 'rahasia5', '1301218814', '082112233445', 'Jl. Merdeka No. 33, Bandung', 'P', '2003-12-30');

INSERT INTO reports (TinggiBadan, BeratBadan, Diagnosa, Obat, admins_ID_Admin)
VALUES
  (170, 65, 'Flu', 'Paracetamol', 1),
  (165, 55, 'Panas Dingin', 'Obat ABC', 2),
  (180, 75, 'Demam', 'Obat XYZ', 3),
  (160, 60, 'Sakit Perut', 'Obat DEF', 4),
  (175, 70, 'Pusing', 'Obat GHI', 5);

INSERT INTO reservations (Tanggal, StatusSelesai, NomorAntrian, reports_ID_Report, patients_ID_Patient, doctors_ID_Doctor)
VALUES
  ('2023-11-01', 1, 1, 1, 1, 1), 
  ('2023-11-02', 0, 2, 2, 2, 2),
  ('2023-11-03', 1, 3, 3, 3, 3),
  ('2023-11-04', 0, 4, 4, 4, 4),
  ('2023-11-05', 1, 5, 5, 5, 5);

INSERT INTO payments (Nominal, StatusSelesai, reservations_ID_Reservation)
VALUES
  (100000, 1, 1),
  (75000, 0, 2),
  (125000, 1, 3),
  (80000, 0, 4),
  (95000, 1, 5);

INSERT INTO recommendations (patients_ID_Patient, doctors_ID_Doctor)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (3, 1),
  (3, 4),
  (4, 5),
  (5,1);





