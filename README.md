# Employee Distribution Report
### Project overview.
The report seeks to present how employees are distributed within the organization based on age-group, gender, race, their state of origin, etc
![Screenshot (55)](https://github.com/user-attachments/assets/e2e9934a-46d4-4066-b61d-ccbc166f813e)


## Table of contents
1. [Data Source](#data-source)
2. [Data Scope](#data-scope)
3. [Tools](#tools)
4. [Data Cleaning](#data-cleaning)
5. [Questions](#questions)
7. [Findings](#findings)


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
- Finally I exported the tables from MySql as csv files.


### Questions
1. What is the gender breakdown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. Which department has the highest turnover rate?
6. What is the distribution of employees across locations by state?
7. How has the company's employee count changed over time based on hire and termination dates?


### Findings
1. There is fairly equal gender distribution of employees in the organization, male at 50.97% and female at 46.28%.
   `select gender, count(*) as Total from hr where termdate is null group by gender order by Total desc;`
   
2. There are mostly whites in the organization with native hawaiians making up the least number of employees by race.
   `select race, count(*) as Total from hr where termdate is null group by race order by Total desc;`

4. Most employees are between 25 and 54 years.
5. 74.97% of the employees work at the headquarters while 25.03% work remotely.
6. Auditing department has the highest turnover rate of 19.10%
7. Most employees come from Ohio.
8. Hires have reduced over time and the terminations as well.
   
```
select years, hires, terms, (hires-terms) as curr from
(select year(hire_date) as years, count(*) as hires,
sum(case when termdate is not null then 1 else 0 end) as terms from hr group by years) as temps
group by years;

```
### Recommendations
1. Investigate the Auditing department for turnover issues.
2. Enhance engagement for remote employees.
3. Introduce retention strategies tailored to the 25-54 age group.
4. Strengthen recruitment strategies in Ohio and replicate its success elsewhere.
5. Modernize the hiring process to attract new talent.
6. Introduce a structured internship program that offers mentorship, real-world projects, and a clear path to full-time roles for ages 18 to 24.

