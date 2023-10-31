## HR-Project

## Table of Content
- [Project Overview](#Project-Overview)
- [Objectives](#Objectives)
- [Data Source](#Data-Source)
- [Tools](#Tools)
- [Data Anatomy](#Data-Anatomy)
- [Data Cleaning](#Data-Cleaning)
- [Data Transformation](#Data-Transformation)
- [Insights](#Insights)
  
## Project Overview
The role of data analytics in human resource management cannot be overemphasized. The use of data analytics in the human resource industry has increased drastically. Data analytics can help to identify trends and reveal key info about the health of an organization such as the productivity and efficiency of workers, detect flaws within the comppany's workforce, make prediction about the future and of course help with taking informed decision that could make things better for the organization.

![HR 1](https://github.com/TommyDatageek01/HR-Project/assets/141424792/07b0c066-220e-4409-95aa-4abed4fa4c51)  

![HR 2](https://github.com/TommyDatageek01/HR-Project/assets/141424792/96766a0b-8aa1-439d-819e-a2962a1db521)




## Objectives
To use power-bi to show the visualization of a company's;
- Employee demographics
- To show how workers have left the company
- To show the termination count of the company
- To show the retention rate of the company

## Data Source

## Tools
- Microsoft Excel- Data Cleaning
- SQL Server Management Studio for Data Cleaning and transformation
- Power-Bi – Visualization

## Data Anatomy

The data was downloaded and on careful observation, it was discovered that the data consisted of 13 columns and 22000 rows. The data columns included a unique 
emp_id
- first_name
- last_name
- birthdate
- gender
- race
- department
- job title
- And  many more.

## Data Cleaning
The initial inspection of the data revealed that the data was not clean and as such, it had to be cleaned. Some of the issues with the data included
Incorrect date format for the hire_date end term date which had to be formatted to short date format using Excel

## Data Transformation
To give a better representation of data, the data had to be transformed using SQL
The transformation included
- Extracting age from the birth date
- Finding the age distribution of the
- Length of service for terminated workers

## Insights
- From the data gathered, the average years of service of the workforce was 7 years.
- One particular KPI which I was keen to see was the termination count expressed as a percentage.
  
![Termination rate](https://github.com/TommyDatageek01/HR-Project/assets/141424792/0b1b5d1b-da53-4d34-9c67-884c4804983e)

  
- From the data, the company appears to be doing well with the termination count of its staff as it has an average of less than 10% for all departments. This is relatively okay compared to industry standards of 10%
- The retention rate of the company has been increasing from 2000 to 2022.
- 
- ![retent](https://github.com/TommyDatageek01/HR-Project/assets/141424792/339c3047-ca8c-49df-8fb1-bdf3dee83556)

- The company has seen its retention increase from 85% starting in 2000 to more than 95% by 2020. This could mean that many of the staff are happy to work for the organization
- This could also mean that the company has enjoyed relative stability over the years

 


