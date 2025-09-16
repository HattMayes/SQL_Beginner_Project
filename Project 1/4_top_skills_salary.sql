-- What are the top skills based on salary?
/*
- Looking at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, any location.
- This will reveal how different skills impact salary levels, which in turn allows me to aim to learn the higher paying skills.
*/

-- 1. Need skills from skills_dim table, but also salary from job_postings_fact (main table)
-- Can use most of the code from query 3
-- 2. Remove COUNT, ORDER BY and change LIMIT
-- 3. Add AVG(salary_year_avg), remove NULL values, order by 'average_salary'
-- 4. Use ROUND function to remove decimal places in salary, rounded mine to 2 d.p.
-- 5. Optional to filter to jobs that are remote only in WHERE section

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS average_salary
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    -- AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25

-- Results -
/* 
Top salaries are commanded by analysts skilled in:
Big data technologies (PySpark, Couchbase),
Machine Learning tools (DataRobot, Jupyter),
and Python Libraries (Pandas, NumPy).
This shows the industry's high valuation to tools within data processing and predictive modelling capabilities.
*/
