# Employee Distribution Report
### Project overview.
The report seeks to present how employees are distributed within the organization based on age-group, gender, race, their state of origin, etc

## Table of contents
1. [Data Source](#data-source)
2. [Tools](#tools)
3. [Data Cleaning](#data-cleaning)
4. [Questions](#questions)
7. [Findings](#findings)
8. [Recommendations](#recommendations)

### Data Source
The data is sourced from CSV file obtained from a youtube channel: Human Resources.csv.

### Tools
- MySql
- Power Bi - Visualization.

### Data Cleaning
- Correcting the column headers of the table where necessary.
  
`alter table hr rename column ï»¿id to employee_id;`

- Corrected the date formats of the hire date, termination date and birthdate and also gave them the date datatype. Below is an example

```
 update hr set birthdate = case
 when birthdate like "%/%" then date_format( str_to_date(birthdate, "%m/%d/%Y"), "%Y-%m-%d")
 when birthdate like "%-%" then date_format( str_to_date(birthdate, "%m-%d-%y"), "%Y-%m-%d")
 else null 
 end;
alter table hr modify column hire_date date;

```

- Created an age column and a query to find the employees ages.

```
 alter table hr add column age int after birthdate;
 update hr set age= timestampdiff(year, birthdate, curdate());

```

- Deleting rows with employees who are less than 18 years since its invalid.


### Questions
1. What is the gender breakdown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. What is the average length of employment for employees who have been terminated?
6. How does the gender distribution vary across departments and job titles?
7. What is the distribution of job titles across the company?
8. Which department has the highest turnover rate?
9. What is the distribution of employees across locations by city and state?
10. How has the company's employee count changed over time based on hire and term dates?
11. What is the tenure distribution for each department?

### Findings
### Recommendations
