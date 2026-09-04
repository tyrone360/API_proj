/* =========================================================
   RaceDay Event Management System
   ========================================================= */


/* 1. CREATE DATABASE */

CREATE DATABASE RaceDayDB;

USE RaceDayDB;


CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL,

    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Participant', 'Organiser', 'Admin'))
);


CREATE TABLE Location
(
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    LocationName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Province NVARCHAR(50) NOT NULL,
    PostalCode NVARCHAR(10) NOT NULL
);


CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(255) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    AgeLimit INT NOT NULL DEFAULT 16,

    CONSTRAINT CK_Category_Distance
        CHECK (DistanceKm > 0),

    CONSTRAINT CK_Category_EntryFee
        CHECK (EntryFee >= 0),

    CONSTRAINT CK_Category_AgeLimit
        CHECK (AgeLimit >= 0)
);


CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName NVARCHAR(150) NOT NULL,
    EventDate DATE NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    CategoryID INT NOT NULL,
    LocationID INT NOT NULL,
    MaxParticipants INT NOT NULL DEFAULT 100,

    CONSTRAINT FK_Event_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID),

    CONSTRAINT FK_Event_Location
        FOREIGN KEY (LocationID)
        REFERENCES Location(LocationID),

    CONSTRAINT CK_Event_MaxParticipants
        CHECK (MaxParticipants > 0)
);


CREATE TABLE EventEnrollment
(
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    EventID INT NOT NULL,
    RegistrationDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    EmergencyContact NVARCHAR(100) NOT NULL,
    EnrollmentStatus NVARCHAR(20) NOT NULL DEFAULT 'Registered',

    CONSTRAINT FK_Enrollment_User
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Enrollment_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT CK_Enrollment_Status
        CHECK (EnrollmentStatus IN
        ('Registered', 'Cancelled', 'Completed')),

    CONSTRAINT UQ_User_Event
        UNIQUE (UserID, EventID)
);


CREATE TABLE Result
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrollmentID INT NOT NULL UNIQUE,
    FinishTime TIME NOT NULL,
    Position INT NOT NULL,
    Pace DECIMAL(6,2) NOT NULL,
    ResultStatus NVARCHAR(20) NOT NULL DEFAULT 'Official',

    CONSTRAINT FK_Result_Enrollment
        FOREIGN KEY (EnrollmentID)
        REFERENCES EventEnrollment(EnrollmentID),

    CONSTRAINT CK_Result_Position
        CHECK (Position > 0),

    CONSTRAINT CK_Result_Pace
        CHECK (Pace > 0),

    CONSTRAINT CK_Result_Status
        CHECK (ResultStatus IN
        ('Official', 'Pending', 'Disqualified'))
);


INSERT INTO Users
    (FirstName, LastName, Email, PasswordHash, Role)
VALUES
    ('Lerato', 'Mokoena',
     'lerato.mokoena@raceday.co.za',
     'HASH_ORGANISER_001',
     'Organiser'),

    ('Thabo', 'Nkosi',
     'thabo.nkosi@raceday.co.za',
     'HASH_ORGANISER_002',
     'Organiser'),

    ('Naledi', 'Dlamini',
     'naledi.dlamini@email.com',
     'HASH_PARTICIPANT_001',
     'Participant'),

    ('Kabelo', 'Molefe',
     'kabelo.molefe@email.com',
     'HASH_PARTICIPANT_002',
     'Participant'),

    ('Admin', 'RaceDay',
     'admin@raceday.co.za',
     'HASH_ADMIN_001',
     'Admin');


INSERT INTO Location
    (LocationName, Address, City, Province, PostalCode)
VALUES
    ('Cape Town Stadium',
     'Fritz Sonnenberg Road',
     'Cape Town',
     'Western Cape',
     '8051'),

    ('Zoo Lake',
     'Lower Park Drive',
     'Johannesburg',
     'Gauteng',
     '2193'),

    ('Kings Park Stadium',
     'Jacko Jackson Drive',
     'Durban',
     'KwaZulu-Natal',
     '4001');


INSERT INTO Category
    (CategoryName, Description, DistanceKm, EntryFee, AgeLimit)
VALUES
    ('Road Running',
     'A road running event for participants who enjoy competitive running.',
     10.00,
     150.00,
     16),

    ('Community Walk',
     'A community focused walking event.',
     5.00,
     80.00,
     12),

    ('Cycling',
     'A cycling event for recreational and competitive cyclists.',
     20.00,
     200.00,
     16);


INSERT INTO Event
    (EventName, EventDate, Description,
     CategoryID, LocationID, MaxParticipants)
VALUES
    ('Cape Town Summer Run',
     '2026-11-15',
     'A 10 kilometre road running event around Cape Town.',
     1,
     1,
     500),

    ('Johannesburg Community Walk',
     '2026-12-05',
     'A community focused five kilometre walking event.',
     2,
     2,
     300),

    ('Durban Coastal Cycle',
     '2027-01-17',
     'A twenty kilometre cycling event along the Durban coastline.',
     3,
     3,
     400);


INSERT INTO EventEnrollment
    (UserID, EventID, RegistrationDate,
     EmergencyContact, EnrollmentStatus)
VALUES
    (3, 1, '2026-09-01 09:30:00',
     'Mpho Dlamini - 0825551234',
     'Registered'),

    (4, 1, '2026-09-01 10:15:00',
     'Neo Molefe - 0835555678',
     'Registered'),

    (3, 2, '2026-09-02 11:00:00',
     'Mpho Dlamini - 0825551234',
     'Registered'),

    (4, 3, '2026-09-02 13:30:00',
     'Neo Molefe - 0835555678',
     'Registered');


INSERT INTO Result
    (EnrollmentID, FinishTime, Position,
     Pace, ResultStatus)
VALUES
    (1, '00:52:30', 1, 5.25, 'Official'),

    (2, '00:58:45', 2, 5.88, 'Official');


SELECT * FROM Users;
SELECT * FROM Location;
SELECT * FROM Category;
SELECT * FROM Event;
SELECT * FROM EventEnrollment;
SELECT * FROM Result;

SELECT
    u.FirstName,
    u.LastName,
    e.EventName,
    c.CategoryName,
    l.LocationName,
    ee.EnrollmentStatus,
    r.FinishTime,
    r.Position,
    r.Pace
FROM Users u
INNER JOIN EventEnrollment ee
    ON u.UserID = ee.UserID
INNER JOIN Event e
    ON ee.EventID = e.EventID
INNER JOIN Category c
    ON e.CategoryID = c.CategoryID
INNER JOIN Location l
    ON e.LocationID = l.LocationID
LEFT JOIN Result r
    ON ee.EnrollmentID = r.EnrollmentID;
