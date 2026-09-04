# RaceDay Event Management System

## Student Project - POE 1

RaceDay is an event management system designed to manage running, walking and cycling events. The system allows participants to register for events and allows organisers to manage events and record participant results.

This project was developed as part of POE 1 at Rosebank International University.

## Project Overview

The main purpose of RaceDay is to provide a simple database system for managing sporting events.

The system stores information about:

- Users
- Events
- Event categories
- Event locations
- Event enrolments
- Race results

The database was designed using an Entity Relationship Diagram (ERD) before the SQL database was created.


## User Roles

### Participant

Participants can:

- View available events
- Register for events
- Manage their profile
- View their race results
- Cancel an enrolment

### Organiser

Organisers can:

- Create events
- Update events
- Manage event information
- View participant enrolments
- Record race results

### Administrator

The administrator can:

- Manage users
- Manage event categories
- Manage system information
- Remove incorrect records when necessary

## Database Structure

The RaceDay database contains the following main tables:

| Table | Purpose |
|---|---|
| Users | Stores participant, organiser and administrator information |
| Location | Stores event location information |
| Category | Stores different event categories |
| Event | Stores RaceDay event information |
| EventEnrollment | Connects participants with events |
| Result | Stores participant race results |

The database uses primary keys and foreign keys to connect the tables and maintain relationships between the different records.

## Section A - ERD

The Entity Relationship Diagram was created to show the structure of the RaceDay database.

The ERD contains six main entities:

- Users
- Location
- Category
- Event
- EventEnrollment
- Result

The relationships shown in the ERD were used when creating the SQL database.

The ERD is available in the `/SQLLOCALDB` folder.


## Section B - API Endpoint Plan

An API endpoint plan was created for the RaceDay system.

The planned API includes endpoints for:

- Authentication
- Users
- Events
- Categories
- Event enrolments
- Results

The API uses standard RESTful HTTP methods including:

- GET
- POST
- PUT
- DELETE

The endpoint plan is available in the `/SQLLOCALDB` folder.


## Section C - SQL Database

The SQL database was created using Microsoft SQL Server.

The database is called:

`RaceDayDB`

The SQL script creates all required tables, constraints, relationships and sample data.

Sample data includes:

- 2 Organisers
- 2 Participants
- 1 Administrator
- 3 Event categories
- 3 Event locations
- 3 Events
- 4 Event enrolments
- 2 Race results

The complete SQL script is stored in:

`/SQLLOCALDB/SQLQuery1.sql`

## Database Constraints

The database uses different constraints to help maintain data integrity.

These include:

- Primary Keys
- Foreign Keys
- NOT NULL constraints
- UNIQUE constraints
- CHECK constraints
- DEFAULT values

For example, a participant cannot register for the same event more than once because the UserID and EventID combination is unique in the EventEnrollment table.

## How to Run the SQL Database

1. Open Microsoft SQL Server Management Studio.
2. Open the `SQLQuery1.sql` file.
3. Connect to the SQL Server instance.
4. Execute the database creation section if the database does not already exist.
5. Select the `RaceDayDB` database.
6. Execute the table creation sections.
7. Execute the sample data INSERT statements.
8. Run the SELECT statements to check the data.
9. Run the relationship JOIN query to confirm that the tables are connected correctly.



## Testing

The database was tested by:

- Creating the database tables
- Inserting sample records
- Retrieving records using SELECT statements
- Checking primary keys
- Checking foreign key relationships
- Testing the relationships between users, events, categories, locations, enrolments and results

The SQL JOIN query was also used to confirm that related information could be retrieved from multiple tables.


## Project Folder Structure

```text
RaceDay/
│
├── docs/
│   ├── ERD.png
│   ├── PROG.md
│   └── SQLQuery1.sql
│
├── README.md
│
└── .github/
    └── workflows/
