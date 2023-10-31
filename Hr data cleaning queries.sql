USE [HR Project]

SELECT * FROM HR

ALTER TABLE HR
ADD Birtdateconverted date

UPDATE HR
SET Birtdateconverted = convert(date, birthdate)

ALTER TABLE HR
ADD hire_date2 date

UPDATE HR
SET hire_date2 = CONVERT(date, hire_date)

ALTER TABLE HR
ADD termdate2 date

UPDATE HR
SET termdate2 = CONVERT(datetime, termdate) 

SELECT Termdate,
CASE WHEN Termdate is NULL then 'Active'
     ELSE Termdate
END
FROM HR

UPDATE HR
SET termdate2 = CASE WHEN Termdate is NULL then 'Active'
     ELSE Termdate
END

SELECT * FROM HR

ALTER TABLE HR
DROP Column Termdate2

SELECT termdat
FROM HR

UPDATE HR
set termdate = Case when termdate is null then '.' else termdate end


ALTER Table HR
ADD term_date date


UPDATE HR
SET term_date = termdate where termdate is null

SELECT * FROM HR
ALTER TABLE Hr
ADD Age int

SELECT
DATEDIFF(dd, Birtdateconverted, getdate()) 
FROM HR

UPDATE HR
SET Age =DATEDIFF(YY, Birtdateconverted, getdate()) 

SELECT Birtdateconverted, Age FROM HR


SELECT min(age), max(age)
FROM HR

SELECT COUNT(*) 
FROM HR
Where Age < 18

----Showing the total number of active staff by genders in the company
SELECT distinct(gender), count(gender)
FROM HR
Where term_date is null
group by gender


---Showing the sum of total workers in the company
SELECT count(emp_id)
FROM HR
Where term_date is null


----Showing the total number of staffs by race
SELECT distinct(race), count(race) as  'Number of employees by race'
FROM HR
Where term_date is null
group by race
ORDER by count(race) DESC



SELECT distinct(race), count(race) as  'Number of employees by race'
FROM HR
Where term_date is null
group by race
having count(race) > 1000


----Age distribution in the company
SELECT min(age) 'Youngest', max(age) 'Oldest'
FROM HR
WHERE term_date is null

SELECT COUNT(*) as agecount,
CASE WHEN Age >=21 AND age <=24 THEN '18-24'
     WHEN Age >=25 AND age <=34 THEN '25-34'
	 WHEN Age >=25 AND age <=44 THEN '25-44'
	 WHEN Age >=45 AND age <=54 THEN '45-54'
	 WHEN Age >= 55 AND age <=64 THEN '55-64'
	 ELSE '65+'
END AS Age_Group
FROM HR
WHERE term_date is NULL

----Use CTE  To Create distribution

WITH agecte as (
                SELECT 
CASE WHEN Age >=21 AND age <=24 THEN '18-24'
     WHEN Age >=25 AND age <=34 THEN '25-34'
	 WHEN Age >=25 AND age <=44 THEN '25-44'
	 WHEN Age >=45 AND age <=54 THEN '45-54'
	 WHEN Age >= 55 AND age <=64 THEN '55-64'
	 ELSE '65+'
END AS Age_Group
FROM HR
WHERE term_date is NULL
)

SELECT Age_Group, count(Age_Group), term_date
FROM agecte
GROUP by Age_Group
Order by Age_Group DESC

----Gender Distribution among age group
WITH agecte as (
                SELECT Gender, 
CASE WHEN Age >=21 AND age <=24 THEN '18-24'
     WHEN Age >=25 AND age <=34 THEN '25-34'
	 WHEN Age >=25 AND age <=44 THEN '25-44'
	 WHEN Age >=45 AND age <=54 THEN '45-54'
	 WHEN Age >= 55 AND age <=64 THEN '55-64'
	 ELSE '65+'
END AS Age_Group, term_date
FROM HR
WHERE term_date is NULL
)

SELECT Age_Group, count(Age_Group) as 'count of age_group',  Gender
FROM agecte
WHERE term_date is null
GROUP by Age_Group, Gender
Order by Age_Group DESC

SELECT * FROM HR
---How many Employees work at headquarter vs location
SELECT location, count(location) 
FROM HR
WHERE term_date is Null
GROUP BY location
ORDER BY count(location)

SELECT * FROM HR

