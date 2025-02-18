# Employee Distribution Report
### Project overview.
The report seeks to present how employees are distributed within the organization based on age-group, gender, race, their state of origin, etc
![Screenshot (34)](https://github.com/user-attachments/assets/395bb1cc-2b2d-4fd3-b832-e09417419b33)

## Table of contents
1. [Data Source](#data-source)
2. [Data Scope](#data-scope)
3. [Tools](#tools)
4. [Data Cleaning](#data-cleaning)
5. [Questions](#questions)
7. [Findings](#findings)
8. [Limitations](#limitations)

### Data Source
The data is sourced from CSV file obtained from a youtube channel: Human Resources.csv.

### Data Scope
- HR Data with over 22000 rows from the year 2000 to 2020

### Tools
- MySql Workbench
- Power Bi for Visualization.

### Data Cleaning
- Correcting the column headers of the table where necessary.
  
`alter table hr rename column ï»¿id to employee_id;`

- Corrected the date formats of the hire date, termination date and birthdate and also gave them the date datatype. Below is an example

```
 update hr set hire_date = case
 when hire_date like "%/%" then date_format( str_to_date(hire_date, "%m/%d/%Y"), "%Y-%m-%d")
 when hire_date like "%-%" then date_format( str_to_date(hire_date, "%m-%d-%y"), "%Y-%m-%d")
 else null 
 end;

```
- The termination date was stored as a timestamp and a text type, so I converted it to a date and extracted the date.

```
    -- Change termdate format --
update hr set termdate = date(str_to_date(termdate,"%Y-%m-%d %H:%i:%s UTC"))
where termdate is not null and TRIM(termdate) != '';

```

- Created an age column and a query to find the employees ages.

```
 alter table hr add column age int after birthdate;
 update hr set age= timestampdiff(year, birthdate, curdate());

```
- Deleting employees whose termination date is way into the future as it would be an anomaly. The termination date column is based on dates less or equal to current date.
- Deleting rows with employees who are less than 18 years since its invalid.


### Questions
1. What is the gender breakdown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. Which department has the highest turnover rate?
6. What is the distribution of employees across locations by state?
7. How has the company's employee count changed over time based on hire and termination dates?


### Findings
### Limitations
- Some records had negative ages and these were excluded during querying(967 records). Ages used were 18 years and above.
- Some termination dates were far into the future and were not included in the analysis. The only term dates used were those less than or equal to the current date
