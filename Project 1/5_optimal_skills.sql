-- What are the most optimal skills to learn based on pay and demand?
/*
- Identifying skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrates on positions with specified salaries.
- Targeting these jobs as they can offer job security and financial benefits due to their high demand and salaries.
*/

-- 1. Placing code from queries 3 & 4 into a CTEs - 'skills_demand' + 'avg_salary'
-- 2. Need to ready CTEs for combining by adding skill_id to each SELECT, when combining it is best practice to combine on PRIMARY/FOREIGN keys
-- When creating more than 1 CTE, use a ',' to separate them rather than two WITH statements
-- 3. Remove LIMIT to combine all data, Remove ORDER BY for speed boost
-- 4. GROUP BY skill_id, add 'AND salary_year_avg IS NOT NULL' to 'skills_demand' CTE
-- Include table names i.e. 'skills_dim.skill_id' so query is not too ambiguous when running
-- 5. Combine CTEs with SELECT statement, FROM skills_demand table, INNER JOIN as I only want data included in both tables
-- 6. ORDER BY demand_count & (secondary) average_salary, LIMIT to 25 items
-- To minimise mess, use ChatGPT to condense the code (see final code below)

WITH skills_demand AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
), 

avg_salary AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
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
    skills_dim.skill_id
)

-- Can ORDER BY with multiple items if values equal on one item, like layered ordering

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN
    avg_salary ON skills_demand.skill_id = avg_salary.skill_id
ORDER BY
    demand_count DESC, 
    average_salary DESC
LIMIT 25

-- Can also use:
/*
WHERE 
    demand_count>10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25
*/
-- This will order by average salary, but make sure the demand count for the skills column is higher tha 10 making them more relevant in the job search.

-- Using ChatGPT to condense the code:

SELECT 
    s.skill_id,
    s.skills,
    COUNT(sj.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg), 2) AS average_salary
FROM 
    job_postings_fact j
JOIN 
    skills_job_dim sj ON j.job_id = sj.job_id
JOIN 
    skills_dim s ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    s.skill_id, s.skills
ORDER BY
    demand_count DESC, 
    average_salary DESC
LIMIT 25;

-- Results - 
/*
The results show the top 5 most in-demand skills being (from most to least), SQL, Excel, Python, Tableau and R, 
each with their respective demand counts of 3083, 2143, 1840, 1659, and 1073. 
The salary range is just over $15,000, with:
Excel average salary = $86418.90
Python average salary = $101511.85
SQL with the highest demand also had a respectable average salary of $96435.33
*/

-- Different results can be seen if prioritising average salary over demand count.