CREATE DATABASE UniversityDB;
USE UniversityDB;


CREATE TABLE Academic_Department (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Info TEXT,
    No_of_Programs INT,
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20)
);


CREATE TABLE Program (
    No_of_Courses INT,
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Department_Id INT,
    FOREIGN KEY (Department_Id) REFERENCES Academic_Department(Id)
);


CREATE TABLE Degree (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Program_Id INT,
    Department_Id INT,
    DurationYears INT,
    TotalCredits INT,
    Info TEXT,
    FOREIGN KEY (Program_Id) REFERENCES Program(Id),
    FOREIGN KEY (Department_Id) REFERENCES Academic_Department(Id)
);


CREATE TABLE Student (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Phone_No VARCHAR(20),
    Gender VARCHAR(10),
    Email VARCHAR(100),
    Address TEXT,
    DateOfBirth DATE,
    Intake INT NOT NULL,
    Degree_Name VARCHAR(100),
    FOREIGN KEY (Degree_Name) REFERENCES Degree(Name)
);


CREATE TABLE Course_Modules (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Department_Id INT,
    Credits INT,
    Info TEXT,
    FOREIGN KEY (Department_Id) REFERENCES Academic_Department(Id)
);


CREATE TABLE Lecturer (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Email VARCHAR(100),
    Department_Id INT,
    Degrees TEXT,
    FOREIGN KEY (Department_Id) REFERENCES Academic_Department(Id)
);


CREATE TABLE Lecturer_Assistant (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Lecturer_Id INT,
    Department_Id INT,
    FOREIGN KEY (Lecturer_Id) REFERENCES Lecturer(Id),
    FOREIGN KEY (Department_Id) REFERENCES Academic_Department(Id)
);


CREATE TABLE Section (
    No_of_Students INT,
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Course_Id INT,
    Semester VARCHAR(20),
    AcademicYear VARCHAR(9),
    Capacity INT,
    FOREIGN KEY (Course_Id) REFERENCES Course_Modules(Id)
);


CREATE TABLE Management (
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Job_Role VARCHAR(50),
    Employee_Id INT PRIMARY KEY AUTO_INCREMENT
);


CREATE TABLE Student_Degree (
    Student_Id INT,
    Degree_Id INT,
    GPA DECIMAL(3,2),
    Grade VARCHAR(5),
    Degree_Name VARCHAR(100),
    PRIMARY KEY (Student_Id, Degree_Id, Degree_Name),
    FOREIGN KEY (Student_Id) REFERENCES Student(Id),
    FOREIGN KEY (Degree_Id) REFERENCES Degree(Id),
    FOREIGN KEY (Degree_Name) REFERENCES Degree(Name)
);


CREATE TABLE Lecturer_Section (
    Lecturer_Id INT,
    Section_Id INT,
    PRIMARY KEY (Lecturer_Id, Section_Id),
    FOREIGN KEY (Lecturer_Id) REFERENCES Lecturer(Id),
    FOREIGN KEY (Section_Id) REFERENCES Section(Id)
);


CREATE TABLE Course_Degree (
    Course_Id INT,
    Degree_Id INT,
    Degree_Name VARCHAR(100),
    Semester_No INT,
    PRIMARY KEY (Course_Id, Degree_Id, Degree_Name),
    FOREIGN KEY (Course_Id) REFERENCES Course_Modules(Id),
    FOREIGN KEY (Degree_Id) REFERENCES Degree(Id),
    FOREIGN KEY (Degree_Name) REFERENCES Degree(Name)
);


CREATE TABLE Lecturer_Department (
    Lecturer_Id INT,
    Department_Id INT,
    Start_Date DATE,
    PRIMARY KEY (Lecturer_Id, Department_Id),
    FOREIGN KEY (Lecturer_Id) REFERENCES Lecturer(Id),
    FOREIGN KEY (Department_Id) REFERENCES Academic_Department(Id)
);


CREATE TABLE Section_Degree (
    Section_Id INT,
    Degree_Name VARCHAR(100),
    PRIMARY KEY (Section_Id, Degree_Name),
    FOREIGN KEY (Section_Id) REFERENCES Section(Id),
    FOREIGN KEY (Degree_Name) REFERENCES Degree(Name)
);


CREATE TABLE Management_Department (
    Department_Id INT,
    Employee_Id INT,
    Start_Date DATE,
    PRIMARY KEY (Department_Id, Employee_Id),
    FOREIGN KEY (Department_Id) REFERENCES Academic_Department(Id),
    FOREIGN KEY (Employee_Id) REFERENCES Management(Employee_Id)
);


ALTER TABLE Student ADD Password VARCHAR(100) NOT NULL DEFAULT 'defaultpass';
ALTER TABLE Lecturer ADD Password VARCHAR(100) NOT NULL DEFAULT 'defaultpass';
ALTER TABLE Lecturer_Assistant ADD Password VARCHAR(100) NOT NULL DEFAULT 'defaultpass';
ALTER TABLE Management ADD Password VARCHAR(100) NOT NULL DEFAULT 'defaultpass';


CREATE TABLE Admin (
    Id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL
);

ALTER TABLE Course_Modules
ADD UNIQUE (Name);

CREATE TABLE Student_Modules (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Student_Id INT,
    Module_Name VARCHAR(50),
    FOREIGN KEY (Student_Id) REFERENCES student(Id),
    FOREIGN KEY (Module_Name) REFERENCES Course_Modules(Name)
);


ALTER TABLE Student
ADD Department_Id INT;
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (Department_Id) REFERENCES academic_department(Id);

ALTER TABLE course_modules
ADD CONSTRAINT fk_course_department
FOREIGN KEY (Department_Id) REFERENCES academic_department(Id)
ON DELETE CASCADE
ON UPDATE CASCADE;


CREATE TABLE Student_Section (
    Student_Id INT,
    Section_Id INT,
    PRIMARY KEY (Student_Id, Section_Id),
    FOREIGN KEY (Student_Id) REFERENCES Student(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Section_Id) REFERENCES Section(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);




-- Example data to login to the system:
-- Student, Lecturer, Management, and Admin all have ID = 1 and Password = 'admin'

INSERT INTO Academic_Department (Name, Info, No_of_Programs, ContactEmail, ContactPhone)
VALUES ('Computer Science', 'CS Department', 2, 'cs@kdu.ac.lk', '1234567890');

INSERT INTO Program (No_of_Courses, Name, Department_Id)
VALUES (10, 'BSc in CS', 1);

INSERT INTO Degree (Name, Program_Id, Department_Id, DurationYears, TotalCredits, Info)
VALUES ('BSc in Computer Science', 1, 1, 4, 120, 'CS undergraduate degree');

INSERT INTO Student (Name, Phone_No, Gender, Email, Address, DateOfBirth, Intake, Degree_Name, Password, Department_Id)
VALUES ('Dulshan', '0700000000', 'male', 'dulshan@kdu.ac.lk', '123 Main St', '2003-05-15', 42, 'BSc in Computer Science', 'admin', 1);

INSERT INTO Course_Modules (Name, Department_Id, Credits, Info)
VALUES ('Data Structures', 1, 3, 'Core CS module');

INSERT INTO Lecturer (Name, Gender, Email, Department_Id, Degrees, Password)
VALUES ('Dr. Kalansuriya', 'Male', 'kl@kdu.ac.lk', 1, 'PhD in CS', 'admin');

INSERT INTO Lecturer_Assistant (Name, Email, Lecturer_Id, Department_Id, Password)
VALUES ('kavindya', 'kavindya@kdu.ac.lk', 1, 1, 'admin');

INSERT INTO Section (No_of_Students, Name, Course_Id, Semester, AcademicYear, Capacity)
VALUES (30, 'DS Section A', 1, 'Semester 1', '2024/2025', 40);

INSERT INTO Management (Name, Email, Job_Role, Password)
VALUES ('saman rathnayaka', 'saman@kdu.ac.lk', 'Registrar', 'admin');

INSERT INTO Student_Degree (Student_Id, Degree_Id, GPA, Grade, Degree_Name)
VALUES (1, 1, 3.75, 'A', 'BSc in Computer Science');

INSERT INTO Lecturer_Section (Lecturer_Id, Section_Id)
VALUES (1, 1);

INSERT INTO Course_Degree (Course_Id, Degree_Id, Degree_Name, Semester_No)
VALUES (1, 1, 'BSc in Computer Science', 1);

INSERT INTO Lecturer_Department (Lecturer_Id, Department_Id, Start_Date)
VALUES (1, 1, '2022-01-01');

INSERT INTO Section_Degree (Section_Id, Degree_Name)
VALUES (1, 'BSc in Computer Science');

INSERT INTO Management_Department (Department_Id, Employee_Id, Start_Date)
VALUES (1, 1, '2021-06-01');

INSERT INTO Admin (Id, Name, Password)
VALUES (1, 'Super Admin', 'admin');

INSERT INTO Student_Modules (Student_Id, Module_Name)
VALUES (1, 'Data Structures');

INSERT INTO Student_Section (Student_Id, Section_Id)
VALUES (1, 1);
