# SQL_Beginner_Project

## Introduction:  
Beginner project using my knowledge on basic and more advanced functions/operations in SQL. 

-- Project Goals -
1. Analyse top-paying roles and skills from Luke Barousse's job data
2. Be able to search the data to extract what skills I should target for which roles
3. Showcase understanding of basic and more advanced SQL functions/operations

-- Questions this project will answer -
- What are the top-paying jobs for my chosen role?
- What skills are required for these top-paying roles?
- What are the top skills based on salary for my chosen role?
- What are the most optimal skills to learn? i.e. for a high-demand and high-paying job

Project queries can be found [here.](https://github.com/HattMayes/SQL_Beginner_Project/tree/main/Project%201) 

This project was completed using Visual Studio Code Editor and using a tutorial and data provided by Luke Barousse.  
[Tutorial link](https://www.youtube.com/watch?v=7mz73uXD9DA)

## Tools I Used:  
Several key tools were used in this project, these are lised below:  

- **SQL:** The main tool for my analysis that allowed me to query the database on over 100,000 job listings provided by Luke Barousse.
- **PostgreSQL:** This was my chosen database management system, which was used to handle all the data contained on the job listings.
- **Visual Studio Code:** The Code editor was used for SQL file management, database management and executing all SQL queries contained in this project.
- **Git / GitHub:** Essential for version control and sharing my SQL scripts and data analysis. Useful for publicising my learning and tracking my progress into becoming a data analyst.

## The Analysis:   
Each query for this project is aimed at investigating specific aspects of the data analyst job market, including skills, salaries and the most optimal skills in order to acheive a high-paying salary.  

Here's how I approached each question:  

### 1. Top Paying Data Analyst Jobs  
To identify the highest-paying roles, I filtered the data analyst positions by average yearly salary and location, focusing on roles that had a salary included & were located anywhere in the world. The company name and posted-date of the job were also included. This query was used to highlight the high-paying oppourtunities working as a data analyst. The results were limited to 10 values, ordered by the average yearly salary from highest to lowest.  

Code Below:  
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN 
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
Here's a breakdown of the top data analyst roles in 2023:  

- **Wide Salary Range:** From $184,000 to $650,000 per year, but most analyst jobs cluster between $184k–$255k within the top 10 results from the data collected.
- **Job Title Variety:** Within being a data analyst, the specific job title and seniority level varies greatly. From more junior roles like data analyst, to more senior positions at principal and director level.
- **Diverse Employers:** The data shows that many industries recruit data analyst, from technology-based companies like META and AT&T, to companies within the healthcare industry like UCLA healthcare.  

Here's a visualisation of the data for the top 10 data analyst roles:
<img width="1979" height="1180" alt="Image" src="https://github.com/user-attachments/assets/a6da56f8-387b-4d34-9f0e-290aa925f874" />  
*Bar graph visualising my results for the top 10 data analyst roles in 2023; generated through ChatGPT from my SQL query results.*  

### 2. Skills for Top Paying Jobs  

### 3. Most In-Demand Skills for Data Analysts 

### 4. Skills Based on Salary  

### 5. Most Optimal Skills to Learn for a Data Analyst  

## What I Learned From This Project:   
This project allowed me to learn the basics of using SQL as a language as well as the use of a database management system in PostgreSQL and a query/code editor like Visual Code Studio.  

- **Creating Complex Queries:**
- **Data Aggregation:**
- **Analytical Approach:**
