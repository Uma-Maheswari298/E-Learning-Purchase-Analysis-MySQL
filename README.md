## Project Title
E-Learning Purchase Analysis using MySQL

## Description
MySQL-based data analysis project for an e-learning purchases using joins, subqueries, CTEs, views, and aggregate functions.

## Project Overview
- The online learning platform offers multiplecourses to learners from different countries. 
- Each learner can purchase multiple courses. 
- This project uses relational database concepts and SQL queries to analyze purchase patterns and generate meaningful business insights.

## Problem Statement
- Analyze the purchase data of an e-learning platform to identify:
- Sales trends
- Learner behavior
- Popular course categories
- Revenue generation
- Purchase frequency

## Objectives
- Design a relational database.
- Create and manage tables using SQL.
- Insert sample data.
- Perform data analysis using SQL queries.
- Generate reports for business decision-making.

## Database Schema
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
| Purchase_Id | INT | Primary Key,Auto Increment |
| Learner_Id | INT | Foreign Key |
| Course_Id | INT | Foreign Key |
| Purchase_Date | DATE | NOT NULL |
| Quantity | INT | NOT NULL |

## ER-Diagram
<img width="944" height="587" alt="Screenshot 2026-06-17 153929" src="https://github.com/user-attachments/assets/bfea460a-80c9-4c13-b6f3-ab2523485ddb" />

## SQL Concepts Used
- DDL Commands 
- DML Commands 
- SELECT Queries
- Aggregate Functions (SUM, AVG, COUNT)
- Null Handling
- GROUP BY and HAVING
- JOINS
- Subqueries
- Common Table Expressions
- Case
- View

## Key Insights
- Most purchased course category.
- Top spending learners.
- Country-wise purchases.
- Total revenue generated.
- Popular courses.

## Conclusion
This project transformed raw purchase data into meaningful business insights using MySQL. It highlighted learner spending patterns, popular courses, and revenue trends, demonstrating the practical application of SQL for data analysis and decision-making in an e-learning platform.

## Author
- Uma Maheshwari
- Aspiring Data Analyst |MySQL | Python | Power BI | Excel|

