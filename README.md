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
To identify the highest-paying roles, I filtered the data analyst positions by average yearly salary and location, focusing on roles that had a salary included & were located anywhere in the world. The company name and posted date of the job were also included. This query was used to highlight the high-paying opportunities working as a data analyst. The results were limited to 10 values, ordered by the average yearly salary from highest to lowest.  

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
- **Diverse Employers:** The data shows that many industries recruit data analysts, from technology-based companies like META and AT&T, to companies within the healthcare industry like UCLA Healthcare.  

Here's a visualisation of the data for the top 10 data analyst roles:
<img width="1979" height="1180" alt="Image" src="https://github.com/user-attachments/assets/a6da56f8-387b-4d34-9f0e-290aa925f874" />  
*Bar graph visualising my results for the top 10 data analyst roles in 2023; generated through ChatGPT from my SQL query results.*  

### 2. Skills for Top Paying Jobs  
Built on the code from the first query of the top 10 highest-paying data analyst jobs and added the skills associated with these roles to this table using JOINS. Ordered to show the most relevant skills for data analysts in 2023 (based on the data collection of these job postings). This data can be used to allow job seekers to understand which skills to develop to reach the high-end salaries within their respective fields.

Code Below:
```sql
ITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
Here's a breakdown of the top skills for data analyst roles in 2023:  

- **Common Skills:** SQL was the most common skill recorded, appearing in nearly every job listing for data analysts; this included junior and senior roles. Python was also heavily demanded as well as Tableau.
- **Top-Paying Skills:** Skills like SQL, Python, and Tableau were consistently seen in the top 10 job postings that ranged from $185k - $250k+. Cloud and Big Data skills like Azure, AWS, Databricks and Snowflake were also key for pushing data analyst jobs into the $200K+ range.
- **Skill Type:** Programming languages (SQL, R, Python), Excel, PowerPoint and data visualisation tool (Power BI, Tableau) skills were all seen within the highest salaries, marking their consistent importance even when moving into senior roles.

Here's a visualisation of the top skills for data analyst roles in 2023:  
<img width="1979" height="1180" alt="Image" src="https://github.com/user-attachments/assets/cc38e97c-50b4-4a0b-91d3-e38f98d091e5" />
*Bar graph visualising my results for the top skills for data analyst roles in 2023 based on average yearly salary earned; generated through ChatGPT from my SQL query results.* 

### 3. Most In-Demand Skills for Data Analysts  
Moving to a more specific query built on the last looking at the top paying skills, I wanted to see the top 5 in-demand skills for a data analyst. Focusing on all job postings this time, rather than excluding remote roles. The findings are very similar to the previous query. The code is also nearly identical, but I also used a COUNT() to aggregate the total count of each skill and a LIMIT of 5 results only to get the top 5.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Here's a breakdown of the top 5 skills for data analyst roles in 2023: 

- **SQL Dominates:** SQL had the highest demand (as found in the previous query), being found in over 92,000 job listings, which is a 32% share of all job listings included in the data queried.
- **Visualisation Matters:** Visualisation tools like Tableau and Power BI had a joined relative share of around 30% for all job postings, which shows visualisation tools are still a core skill valued by employers for data analyst roles.
- **Skills Overview:** Employers often expect SQL + Excel as baseline, with Python + Tableau/Power BI as value-add skills.

Here's a visualisation of the top 5 skills for data analyst roles in 2023: 
<img width="1580" height="1180" alt="Image" src="https://github.com/user-attachments/assets/b31ab6fa-28b0-4de7-931c-74062a77350d" />
*Bar graph visualising my results for the top 5 data analyst roles in 2023; generated through ChatGPT from my SQL query results.*  

### 4. Skills Based on Salary  

### 5. Most Optimal Skills to Learn for a Data Analyst  

## What I Learned From This Project:   
This project allowed me to learn the basics of using SQL as a language as well as the use of a database management system in PostgreSQL and a query/code editor like Visual Code Studio.  

- **Creating Complex Queries:** Mastered the basics and advanced SQL from merging tables with JOIN clauses to using WITH statements to create temporary tables when necessary.
- **Data Aggregation:** Became familiar with aggregate functions like GROUP BY, COUNT(), and AVG() to help summarise my data to exactly how I saw fit. Also used clauses like WHERE, ORDER BY, and GROUP BY for a more filtered and streamlined result search. 
- **Analytical Approach:** Improved my problem-solving and analytical skills, by transforming questions into SQL queries, which gave me actionable, defined results for a specific job title like Data Analyst.
