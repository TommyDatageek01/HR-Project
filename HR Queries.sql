Untreated question the gender retaining work and quitiing
SELECT * FROM HR

UPDATE HR
Set termdate = termdate
WHERE termdate is not null and <> ''

ALTER TABLE HR
ADD Age int

-----Get the age of active workers in the organization
SELECT birthdate, DATEDIFF(YY, birthdate, GETDATE()) as Age
FROM HR
WHERE termdate is Null

----Let add the age column to the table
UPDATE HR
SET Age =  DATEDIFF(YY, birthdate, GETDATE())


----Retreieve the records for the number of years of sacked workers
SELECT termdate, DATEDIFF(YY, termdate, GETDATE())
FROM HR
WHERE termdate is not Null


SELECT birthdate, termdate, count(termdate) FROM
HR
WHERE termdate > '2023-10-01'
Group by birthdate, termdate

----There are reocords of incorrect termination date, so they would be excluded to ensure keep the integrity of our analysis

SELECT birthdate, termdate, count(termdate) FROM
HR
WHERE termdate Is null and termdate < '2023-10-01'
Group by birthdate, termdate

-----This query shows the total number of accuratley documented staffs that has ever worked and still  work for the company
SELECT * FROM
HR
WHERE termdate Is null or termdate < '2023-10-01'

----Let shows the total of staffs that has ever worked for the company
SELECT count(emp_id) FROM
HR
WHERE termdate Is null or termdate < '2023-10-01'

----Let show the total number of active staffs in the organization
SELECT count(*)
FROM HR
WHERE termdate is null


----What is the Gender breakdown of the active staff in this organization
SELECT distinct(Gender), count(Gender) as Number
FROM HR
WHERE termdate is null
GROUP BY Gender
Order by Number DESC

-----What is the total number of staff in the company
SELECT count(*) Total_staff
FROM HR
WHERE termdate is null


----Can you show the breakdown of active employees by race
SELECT race, count(race) as 'count'
FROM HR
WHERE termdate is null
GROUP BY race
Order by 'count' DESC

-----Show the total number of employees that has left the organization by race
SELECT race, count(race) as 'count'
FROM HR
WHERE termdate is not null or termdate < '2023-10-01'
GROUP BY race
Order by 'count' DESC

----Show the age distribution of the total number of employees that left the organization. we use CTE
WITH AgeCTE as ( 

SELECT
CASE WHEN Age >= 21 and Age < 31 THEN '21-30'
     WHEN Age >= 31 and Age < 41 THEN '31-40'
	 WHEN Age >= 41 and Age < 51 THEN '41-50'
	 WHEN Age >= 51 and Age < 61 Then '51-60'
     Else '65+'
END as Age_Group,
termdate,
hire_date,
Gender,
race
FROM HR


)

SELECT age_group, count(*) 'count'
FROM AgeCTE
WHERE termdate is not null
GROUP BY Age_Group
ORDER BY 'count'





----SHow the age destribution of workers in the company
SELECT race,
CASE WHEN Age >= 21 and Age < 31 THEN '21-30'
     WHEN Age >= 31 and Age < 41 THEN '31-40'
	 WHEN Age >= 41 and Age < 51 THEN '41-50'
	 WHEN Age >= 51 and Age < 61 Then '51-60'
     Else '65+'
END as Age_Group
FROM HR
Where termdate is Null



----- Use CTE to show age distribution 
WITH AgeCTE as ( 

SELECT
CASE WHEN Age >= 21 and Age < 31 THEN '21-30'
     WHEN Age >= 31 and Age < 41 THEN '31-40'
	 WHEN Age >= 41 and Age < 51 THEN '41-50'
	 WHEN Age >= 51 and Age < 61 Then '51-60'
     Else '65+'
END as Age_Group,
termdate,
hire_date,
Gender,
race
FROM HR
Where termdate is Null

)

SELECT Age_group, count(Age_Group) as number
FROM AgeCTE
WHERE termdate is null
Group by Age_Group
ORDER BY number DESC


---WHat is the number of employee working by location
SELECT location, count(location)
FROM HR
WHERE termdate is null
GROUP by location

SELECT * FROM HR
----How long did people work in the company before leaving or were fired
SELECT department, emp_id,race, jobtitle, hire_date, termdate, DATEDIFF(YY, termdate, getdate()) as 'Years_of_service'
FROM HR
WHERE termdate < '2023-10-01'
order by department

SELECT department, AVG(DATEDIFF(YY, hire_date, termdate)) as 'Years_of_service'
FROM HR
WHERE termdate is not null or termdate < '2023-10-01'
GROUP BY department
ORDER BY department


--SELECT count(*) firedworkers, AVG(DATEDIFF(YY, hire_date, termdate)) as 'Years_of_service'
--FROM HR
--WHERE termdate is not null or termdate < '2023-10-01'
--GROUP BY department
--ORDER BY 'Years_of_service'

---What is the average learnt Employees used before they were fired.


SELECT AVG(DATEDIFF(yy, hire_date, termdate)) As Avg_lengthofservice
FROM HR
WHERE termdate is not null and termdate < '2023-10-1'

-----Average length of workers leaving the company group by jobtitle
SELECT jobtitle, AVG(DATEDIFF(yy, hire_date, termdate)) As Avg_lengthofservice
FROM HR
WHERE termdate is not null and termdate < '2023-10-1'
GROUP BY jobtitle
ORDER BY Avg_lengthofservice


------Which group of employees are leaving the most by deparment
SELECT department, 
--count(termdate) 'count' 
AVG(DATEDIFF(yy, hire_date, termdate)) avg_years
FROM HR
WHERE termdate is not null and termdate < '2023-10-01'
GROUP by  department
--ORDER BY 'count' DESC

------Which group of employees are leaving the most by jobtitle
SELECT jobtitle, count(termdate) 'count' , AVG(DATEDIFF(yy, hire_date, termdate)) avg_years
FROM HR
WHERE termdate is not null and termdate < '2023-10-01'
GROUP by jobtitle, department
ORDER BY 'count' DESC

-----What is the gender distribution by department
SELECT gender, department, count(gender) as number
FROM HR
WHERE termdate is NULL
GROUP BY department, gender
ORDER by department DESC


----What is the distribution of jobtitle across the company
SELECT jobtitle, count(*) as number
FROM HR
WHERE termdate is NULL
GROUP BY jobtitle
ORDER BY jobtitle DESC


----The deparment wih highest turn over rate. First create a new column
SELECT department,
FROM HR

ALTER TABLE HR
ADD years_of_service int

UPDATE HR
SET years_of_service = DATEDIFF(yy, hire_date, termdate)

SELECT *
FROM HR
WHERE termdate IS NOT NULL AND termdate < '2023-10-01'


----SELECT department,
----total_count,
----terminated_count,
----terminated_count/total_count
----FROM
----(SELECT department,
----count(*) as total_count,
----SUM (case when termdate is null and termdate < '2023-10-01' then 1 else 0 end) terminated_count
----FROM HR
----WHERE termdate < '2023-10-01'
----GROUP by department
--)order by termdate



DROP TABLE IF EXISTS #newtemp_a
CREATE TABLE #newtemp_a( 
department nvarchar(100),
terminated_workers int
)

INSERT into #newtemp_a
SELECT department,count(emp_id) as number
FROM HR
WHERE termdate is not null and termdate < '2023-10-01'
GROUP BY department

SELECT * FROM #newtemp_a


DROP TABLE IF EXISTS #newtemp_b
CREATE TABLE #newtemp_b( 
department nvarchar(100),
active_workers int
)

INSERT into #newtemp_b
SELECT department,count(emp_id) as number
FROM HR
WHERE termdate is null
GROUP BY department

SELECT * FROM #newtemp_b
 ---JOIN the temp_tables
SELECT a.department, terminated_workers, active_workers, 
ROUND(CAST(terminated_workers as float) / CAST(active_workers as float), 2) as termination_rate
FROM #newtemp_a a
JOIN #newtemp_b b
ON a.department = b.department
ORDER BY termination_rate  DESC


---What is te distribution of employees by locations. We will need an update table that contains location
SELECT a.emp_id, a.department, b.location_city, b.location_state, a.termdate, a.hire_date
FROM HR a
left join HRP b
ON a.emp_id = b.emp_id
where a.termdate is null


DROP TABLE IF EXISTS #temp_loc
CREATE TABLE #temp_loc(
emp_id nvarchar(25),
department nvarchar(50),
location_city nvarchar(100),
location_state nvarchar(100),
termdate date,
hire_date date
)

INSERT INTO #temp_loc
SELECT a.emp_id, a.department, b.location_city, b.location_state, a.termdate, a.hire_date
FROM HR a
left join HRP b
ON a.emp_id = b.emp_id
where a.termdate is null


SELECT * FROM #temp_loc


---Now let look at workers by state and city distribution
SELECT department, location_city, count(location_city) as 'count'
FROM #temp_loc
WHERE termdate is null
GROUP BY location_city, department
ORDER BY 'count'


SELECT department, location_city, count(location_city) as 'count'
FROM #temp_loc
WHERE termdate is null
GROUP BY location_city, department
ORDER by 'count' DESC

SELECT location_state, count(location_state) as 'count'
FROM #temp_loc
WHERE termdate is null
GROUP BY location_state
ORDER by 'count' DESC

SELECT year(hire_date), hire_date
FROM HR
WHERE termdate is NULL or termdate < '2023-10-01'

DROP TABLE IF EXISTS #tempchange
CREATE TABLE #tempchange (
emp_id nvarchar(25),
Department Nvarchar(50),
apppinment_year int,
hire_date date,
no_staff_hired int
)

INSERT into #tempchange
SELECT emp_id, Department, year(hire_date), hire_date, count(hire_date)
FROM HR
WHERE termdate is NULL or termdate < '2023-10-01'
GROUP BY emp_id, department, hire_date


SELECT * FROM #tempchange
ORDER BY apppinment_year 

SELECT count(apppinment_year) 'number of staffs hired', apppinment_year
FROM #tempchange
group by apppinment_year
ORDER BY apppinment_year DESC



DROP TABLE IF EXISTS #tempchangea
CREATE TABLE #tempchangea (
emp_id nvarchar(25),
Department Nvarchar(50),
sacked_year int,
termdate date,
no_staff_fired int,
apppinment_year int
)

INSERT into #tempchangea
SELECT emp_id, Department, year(termdate) 'terminattion year', termdate, count(termdate), year(hire_date)
FROM HR
WHERE termdate is NULL or termdate < '2023-10-01'
GROUP BY emp_id, department, termdate, year(hire_date)

SELECT * FROM #tempchangea c
ORDER BY apppinment_year, sacked_year

SELECT apppinment_year, count(sacked_year) 'staffs fired', sacked_year
FROM #tempchangea d
WHERE termdate is not null
GROUP BY sacked_year, apppinment_year
HAVING COUNT(sacked_year) = 0
ORDER by sacked_year DESC



----Joining the temp tables together
SELECT c.apppinment_year as year, count(c.apppinment_year) 'number of staffs hired'
, count(d.sacked_year) 'staffs fired', 
(count(c.apppinment_year) - count(sacked_year)) as active_staff, (count(c.apppinment_year) - count(sacked_year)) * 100 as percentage_termination
FROM #tempchange c
JOIN #tempchangea d
on c.emp_id = d.emp_id
GROUP BY c.apppinment_year
ORDER BY year DESC

DROP TABLE IF EXISTS #termination_count
CREATE TABLE #termination_count
(Year int,
Employed_staff int,
Fired_staff int,
Remaining_active_staff int
)

INSERT INTO #termination_count
SELECT c.apppinment_year, count(c.apppinment_year) 
, count(d.sacked_year), 
(count(c.apppinment_year) - count(sacked_year))
FROM #tempchange c
JOIN #tempchangea d
on c.emp_id = d.emp_id
GROUP BY c.apppinment_year

------Final Answer for termination count
SELECT year, Employed_staff, Fired_staff, Remaining_active_staff, 
ROUND((Cast(Fired_staff as float)) / (Cast(Employed_staff as float)) * 100, 2) termination_count
FROM #termination_count
ORDER BY YEAR


----Find the average years of service in each department
SELECT Department,
AVG(datediff(YY, hire_date,  termdate)) Average_service_years
FROM HR
WHERE termdate < '2023-10-01'
GROUP BY department
ORDER BY Average_service_years DESC


-----Age distribution by gender
WITH AgeCTE as ( 

SELECT
CASE WHEN Age >= 21 and Age < 31 THEN '21-30'
     WHEN Age >= 31 and Age < 41 THEN '31-40'
	 WHEN Age >= 41 and Age < 51 THEN '41-50'
	 WHEN Age >= 51 and Age < 61 Then '51-60'
     Else '65+'
END as Age_Group,
termdate,
hire_date,
Gender,
race
FROM HR
Where termdate is Null

)

SELECT Age_group, Gender, count(Age_Group) as number
FROM AgeCTE
WHERE termdate is null
Group by Age_Group, gender
ORDER BY number DESC
