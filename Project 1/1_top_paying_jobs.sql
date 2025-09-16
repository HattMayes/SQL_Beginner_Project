-- What are the top paying data jobs?
/* 
- Idetifying the top 10 highest paying roles that are available remotely.
- Focus on job postings with specified salaries (remove null valus).
- What insights shows why these are the top paying roles?
*/

-- 1. Setting out what columns are relevant for this Q
-- 2. Using WHERE to specify role and location
-- 3. Removing NULL values
-- 4. Cleaning to top 10 values with LIMIT and ordering descending
-- 5. LEFT JOIN & name to show each role's company name

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

