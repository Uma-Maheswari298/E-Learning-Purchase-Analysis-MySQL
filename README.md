## Project Title
E-Learning Purchase Analysis using MySQL

## Description
MySQL-based data analysis project for an e-learning purchases using joins, subqueries, CTEs, views, and aggregate functions.

## Project Overview
A MySQL-based data analytics project that examines e-learning platform purchases to analyze learner behavior, course popularity, revenue trends, and category performance using advanced SQL queries and database concepts.

## Database Tables
| Table Name | Description |
|------------|-------------|
| learner | Stores learner details such as ID, name, and country. |
| course | Stores course information including course name, category, and price. |
| purchase | Stores purchase details made by learners. |

## Tables Structure

### learner

| Column Name | Data Type | Constraints |
|------------|-----------|-------------|
| Learner_Id | INT | Primary Key |
| Full_Name | VARCHAR(50) | NOT NULL, UNIQUE |
| Country | VARCHAR(25) | - |

### course

| Column Name | Data Type | Constraints |
|------------|-----------|-------------|
| Course_Id | INT | Primary Key |
| Course_Name | VARCHAR(30) | NOT NULL, UNIQUE |
| Category | VARCHAR(30) | - |
| Unit_Price | DECIMAL(10,2) | - |

### purchase

| Column Name | Data Type | Constraints |
|------------|-----------|-------------|
| Purchase_Id | INT | Primary Key |
| Learner_Id | INT | Foreign Key |
| Course_Id | INT | Foreign Key |
| Purchase_Date | DATE | NOT NULL |
| Quantity | INT | NOT NULL |


## SQL Concepts Used
- DDL Commands (CREATE, ALTER, DROP)
- DML Commands (INSERT, UPDATE, DELETE)
- SELECT Queries
- Aggregate Functions (SUM, AVG, COUNT, MAX, MIN)
- GROUP BY and HAVING
- JOINS
- String Functions
- Date Functions
- Subqueries

## Author
Uma Maheshwari

