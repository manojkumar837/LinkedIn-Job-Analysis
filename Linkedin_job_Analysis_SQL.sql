CREATE DATABASE linkedin_job_analysis;
use linkedin_job_analysis;
CREATE TABLE linkedin_job_posting (
    job_id BIGINT,
    title VARCHAR(500),
    description TEXT,
    pay_period VARCHAR(50),
    work_type VARCHAR(100),
    job_location VARCHAR(200),
    applies INT,
    remote_allowed INT,
    views INT,
    level VARCHAR(100),
    sponsored INT,
    compensation DECIMAL(15,2),
    job_domain VARCHAR(100),
    company_id BIGINT,
    ben_pack_id DECIMAL(15,2)
);
ALTER TABLE linkedin_job_posting
MODIFY COLUMN job_id VARCHAR(50);

-- Beginner-Friendly MySQL Queries
describe linkedin_job_posting;

SELECT COUNT(*) AS total_jobs
FROM linkedin_job_posting;

SELECT *
FROM linkedin_job_posting
LIMIT 10;

DESCRIBE linkedin_job_posting; 

ALTER TABLE linkedin_job_posting
MODIFY COLUMN job_id VARCHAR(100);

USE linkedin_job_analysis;

ALTER TABLE linkedin_job_posting
MODIFY COLUMN job_id VARCHAR(100);

DESCRIBE linkedin_job_posting;

SELECT COUNT(*) AS total_jobs
FROM linkedin_job_posting;

USE linkedin_job_analysis;

SELECT *
FROM linkedin_job_posting
LIMIT 10;

-- BASIC DATA ANALYSIS
-- Number of jobs by work type
SELECT 
    work_type,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY work_type
ORDER BY total_jobs DESC;

-- Number of jobs by pay period
SELECT 
    pay_period,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY pay_period
ORDER BY total_jobs DESC;

-- Number of jobs by experience level
SELECT 
    level,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY level
ORDER BY total_jobs DESC;

-- Number of jobs by job domain
SELECT 
    job_domain,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY job_domain
ORDER BY total_jobs DESC;

-- Number of jobs by job location
SELECT 
    job_location,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY job_location
ORDER BY total_jobs 
LIMIT 20;

-- REMOTE JOB ANALYSIS
-- Remote vs non-remote jobs
SELECT remote_allowed, 
COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY remote_allowed;

-- Percentage of remote jobs
SELECT
    ROUND(
        SUM(CASE WHEN remote_allowed = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS remote_job_percentage
FROM linkedin_job_posting;

-- APPLICATION ANALYSIS
-- Total applications
SELECT
    SUM(applies) AS total_applications
FROM linkedin_job_posting;

-- Top 10 jobs by applications

SELECT
    title,
    job_location,
    work_type,
    applies
FROM linkedin_job_posting
ORDER BY applies DESC
LIMIT 10;

-- JOB VIEWS ANALYSIS
-- Total job views

SELECT 
	SUM(views) AS total_viwes
FROM linkedin_job_posting;

-- Average views per job
SELECT
    ROUND(AVG(views), 2) AS average_views
FROM linkedin_job_posting;

-- Top 10 most viewed jobs
SELECT
	title,
    job_location,
    views
FROM linkedin_job_posting
ORDER BY views DESC
LIMIT 10;

-- JOB ENGAGEMENT ANALYSIS
--  Application-to-view ratio
SELECT
    title,
    views,
    applies,
    ROUND(
        applies * 100.0 / NULLIF(views, 0), 2
    ) AS application_rate
FROM linkedin_job_posting
WHERE views > 0
ORDER BY application_rate DESC
LIMIT 20;

-- SALARY / COMPENSATION ANALYSIS
-- Average compensation
SELECT
    ROUND(AVG(compensation), 2) AS average_compensation
FROM linkedin_job_posting;

-- Maximum compensation
SELECT
    MAX(compensation) AS maximum_compensation
FROM linkedin_job_posting;

-- Minimum compensation
SELECT
    MIN(compensation) AS minimum_compensation
FROM linkedin_job_posting;

-- Average compensation by work type
SELECT
    work_type,
    ROUND(AVG(compensation), 2) AS average_compensation
FROM linkedin_job_posting
WHERE compensation IS NOT NULL
GROUP BY work_type
ORDER BY average_compensation DESC;

-- Average compensation by experience level
SELECT
    level,
    ROUND(AVG(compensation), 2) AS average_compensation
FROM linkedin_job_posting
WHERE compensation IS NOT NULL
GROUP BY level
ORDER BY average_compensation DESC;

-- Top 10 highest-paying jobs
SELECT
    title,
    level,
    work_type,
    job_location,
    compensation
FROM linkedin_job_posting
WHERE compensation IS NOT NULL
ORDER BY compensation DESC
LIMIT 10;

-- SPONSORED JOB ANALYSIS

-- Sponsored vs non-sponsored jobs
SELECT
    sponsored,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY sponsored;

-- Average applications: sponsored vs non-sponsored
SELECT
    sponsored,
    ROUND(AVG(applies), 2) AS average_applications,
    ROUND(AVG(views), 2) AS average_views
FROM linkedin_job_posting
GROUP BY sponsored;

-- EXPERIENCE LEVEL ANALYSIS
-- 26. Jobs with applications by experience level
SELECT
    level,
    COUNT(*) AS total_jobs,
    SUM(applies) AS total_applications,
    ROUND(AVG(applies), 2) AS average_applications
FROM linkedin_job_posting
GROUP BY level
ORDER BY total_jobs DESC;

-- Most viewed experience levels
SELECT
    level,
    SUM(views) AS total_views
FROM linkedin_job_posting
GROUP BY level
ORDER BY total_views DESC;

-- WORK TYPE + REMOTE ANALYSIS

-- Work type and remote jobs
SELECT
    work_type,
    remote_allowed,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
GROUP BY work_type, remote_allowed
ORDER BY total_jobs DESC;

-- Average applications by work type
SELECT
    work_type,
    ROUND(AVG(applies), 2) AS average_applications
FROM linkedin_job_posting
GROUP BY work_type
ORDER BY average_applications DESC;

-- JOB DOMAIN ANALYSIS

-- Top job domains
SELECT
    job_domain,
    COUNT(*) AS total_jobs
FROM linkedin_job_posting
WHERE job_domain IS NOT NULL
GROUP BY job_domain
ORDER BY total_jobs DESC
LIMIT 15;

-- Job domain with highest applications
SELECT
    job_domain,
    SUM(applies) AS total_applications
FROM linkedin_job_posting
WHERE job_domain IS NOT NULL
GROUP BY job_domain
ORDER BY total_applications DESC
LIMIT 10;

-- Job domain with highest average compensation
SELECT
    job_domain,
    ROUND(AVG(compensation), 2) AS average_compensation
FROM linkedin_job_posting
WHERE job_domain IS NOT NULL
  AND compensation IS NOT NULL
GROUP BY job_domain
ORDER BY average_compensation DESC
LIMIT 10;

-- DATA QUALITY CHECKS
-- Check NULL values in important columns
SELECT
    SUM(job_id IS NULL) AS missing_job_id,
    SUM(title IS NULL) AS missing_title,
    SUM(description IS NULL) AS missing_description,
    SUM(level IS NULL) AS missing_level,
    SUM(job_domain IS NULL) AS missing_job_domain,
    SUM(compensation IS NULL) AS missing_compensation,
    SUM(company_id IS NULL) AS missing_company_id,
    SUM(ben_pack_id IS NULL) AS missing_ben_pack_id
FROM linkedin_job_posting;

-- Check duplicate job IDs
SELECT
    job_id,
    COUNT(*) AS duplicate_count
FROM linkedin_job_posting
GROUP BY job_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Check jobs with zero applications
SELECT COUNT(*) AS zero_application_jobs
FROM linkedin_job_posting
WHERE applies = 0;

-- Check jobs with zero views
SELECT COUNT(*) AS zero_view_jobs
FROM linkedin_job_posting
WHERE views = 0;

-- BUSINESS INSIGHTS
-- Jobs having high applications
SELECT
    title,
    level,
    work_type,
    job_location,
    applies
FROM linkedin_job_posting
WHERE applies >= 100
ORDER BY applies DESC;

-- Jobs having high views but low applications
SELECT
    title,
    views,
    applies,
    ROUND(applies * 100.0 / NULLIF(views, 0), 2) AS application_rate
FROM linkedin_job_posting
WHERE views >= 100
ORDER BY application_rate ASC
LIMIT 20;

-- Remote jobs with high applications
SELECT
    title,
    level,
    job_location,
    applies,
    views
FROM linkedin_job_posting
WHERE remote_allowed = 1
ORDER BY applies DESC
LIMIT 20;

-- High-paying remote jobs
SELECT
    title,
    level,
    work_type,
    compensation,
    job_location
FROM linkedin_job_posting
WHERE remote_allowed = 1
  AND compensation IS NOT NULL
ORDER BY compensation DESC
LIMIT 20;

-- FINAL PROJECT KPI QUERY
-- Use this for your Power BI / dashboard KPIs

SELECT
    COUNT(*) AS total_jobs,
    SUM(applies) AS total_applications,
    SUM(views) AS total_views,
    ROUND(AVG(applies), 2) AS avg_applications,
    ROUND(AVG(views), 2) AS avg_views,
    ROUND(AVG(compensation), 2) AS avg_compensation,
    MAX(compensation) AS max_compensation
FROM linkedin_job_posting;

-- FINAL TOP JOBS QUERY
SELECT
    title,
    level,
    work_type,
    job_location,
    job_domain,
    applies,
    views,
    remote_allowed,
    sponsored,
    compensation
FROM linkedin_job_posting
ORDER BY applies DESC
LIMIT 20;