-- Створення бази даних
CREATE DATABASE Hospital;
GO

-- Використання створеної бази даних
USE Hospital;
GO

-- Створення таблиці Departments
CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Financing MONEY NOT NULL CHECK (Financing >= 0) DEFAULT 0,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

-- Створення таблиці Diseases
CREATE TABLE Diseases (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Severity INT NOT NULL CHECK (Severity >= 1) DEFAULT 1
);

-- Створення таблиці Doctors
CREATE TABLE Doctors (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
    Phone CHAR(10) NULL,
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Bonus MONEY NOT NULL DEFAULT 0
);

-- Створення таблиці Examinations
CREATE TABLE Examinations (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    DayOfWeek INT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    StartTime TIME NOT NULL CHECK (StartTime BETWEEN '08:00' AND '18:00'),
    EndTime TIME NOT NULL,
    CHECK (EndTime > StartTime)
);

-- Створення таблиці Wards
CREATE TABLE Wards (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Floor INT NOT NULL CHECK (Floor >= 1),
    Name NVARCHAR(20) NOT NULL UNIQUE
);

-- Вставка даних у таблицю Departments
INSERT INTO Departments (Building, Financing, Name) VALUES
(1, 20000, 'Cardiology'),
(3, 14000, 'Neurology'),
(5, 30000, 'Pediatrics');

-- Вставка даних у таблицю Diseases
INSERT INTO Diseases (Name, Severity) VALUES
('Flu', 2),
('Cancer', 5),
('Diabetes', 3);

-- Вставка даних у таблицю Doctors
INSERT INTO Doctors (Name, Surname, Phone, Salary, Bonus) VALUES
('John', 'Doe', '1234567890', 2000, 500),
('Jane', 'Smith', NULL, 1500, 300),
('Nick', 'Norris', '0987654321', 1800, 400);

-- Вставка даних у таблицю Examinations
INSERT INTO Examinations (Name, DayOfWeek, StartTime, EndTime) VALUES
('Blood Test', 1, '09:00', '10:00'),
('MRI Scan', 2, '10:30', '12:30'),
('X-Ray', 3, '14:00', '15:00');

-- Вставка даних у таблицю Wards
INSERT INTO Wards (Building, Floor, Name) VALUES
(4, 1, 'Ward A'),
(5, 1, 'Ward B'),
(3, 2, 'Ward C');

-- 1. Вивести вміст таблиці палат
SELECT * FROM Wards;

-- 2. Вивести прізвища та телефони всіх лікарів
SELECT Surname, Phone FROM Doctors;

-- 3. Вивести всі поверхи без повторень, де розміщуються палати
SELECT DISTINCT Floor FROM Wards;

-- 4. Вивести назви захворювань під назвою «Name of Disease» та ступінь їх тяжкості під назвою «Severity of Disease»
SELECT Name AS [Name of Disease], Severity AS [Severity of Disease] FROM Diseases;

-- 5. Застосувати вираз FROM для будь-яких трьох таблиць бази даних, використовуючи псевдоніми
SELECT d.Name AS DoctorName, ex.Name AS ExaminationName, w.Name AS WardName
FROM Doctors d
JOIN Examinations ex ON d.Id = ex.Id
JOIN Wards w ON ex.Id = w.Id;

-- 6. Вивести назви відділень, які знаходяться у корпусі 5 з фондом фінансування меншим, ніж 30000
SELECT Name FROM Departments WHERE Building = 5 AND Financing < 30000;

-- 7. Вивести назви відділень, які знаходяться у корпусі 3 з фондом фінансування у діапазоні від 12000 до 15000
SELECT Name FROM Departments WHERE Building = 3 AND Financing BETWEEN 12000 AND 15000;

-- 8. Вивести назви палат, які знаходяться у корпусах 4 та 5 на 1-му поверсі
SELECT Name FROM Wards WHERE Building IN (4, 5) AND Floor = 1;

-- 9. Вивести назви, корпуси та фонди фінансування відділень, які знаходяться у корпусах 3 або 6 
-- та мають фонд фінансування менший, ніж 11000 або більший за 25000
SELECT Name, Building, Financing
FROM Departments
WHERE Building IN (3, 6) AND (Financing < 11000 OR Financing > 25000);

-- 10. Вивести прізвища лікарів, зарплата яких перевищує 1500
SELECT Surname
FROM Doctors
WHERE Salary > 1500;

-- 11. Вивести прізвища лікарів, у яких половина зарплати перевищує триразову надбавку
SELECT Surname
FROM Doctors
WHERE (Salary / 2) > (3 * Bonus);

-- 12. Вивести назви обстежень без повторень, які проводяться у перші три дні тижня з 12:00 до 15:00
SELECT DISTINCT Name
FROM Examinations
WHERE DayOfWeek BETWEEN 1 AND 3
AND StartTime >= '12:00'
AND EndTime <= '15:00';

-- 13. Вивести назви та номери корпусів відділень, які знаходяться у корпусах 1, 3, 8 або 10
SELECT Name, Building
FROM Departments
WHERE Building IN (1, 3, 8, 10);

-- 14. Вивести назви захворювань усіх ступенів тяжкості, крім 1-го та 2-го
SELECT Name
FROM Diseases
WHERE Severity NOT IN (1, 2);

-- 15. Вивести назви відділень, які не знаходяться у 1-му або 3-му корпусі
SELECT Name
FROM Departments
WHERE Building NOT IN (1, 3);

-- 16. Вивести назви відділень, які знаходяться у 1-му або 3-му корпусі
SELECT Name
FROM Departments
WHERE Building IN (1, 3);

-- 17. Вивести прізвища лікарів, що починаються з літери «N»
SELECT Surname
FROM Doctors
WHERE Surname LIKE 'N%';