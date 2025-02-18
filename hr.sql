alter table hr rename column ï»¿id to employee_id;

 -- Change birthdate format --
 update hr set birthdate = case
 when birthdate like "%/%" then date_format( str_to_date(birthdate, "%m/%d/%Y"), "%Y-%m-%d")
 when birthdate like "%-%" then date_format( str_to_date(birthdate, "%m-%d-%y"), "%Y-%m-%d")
 else null 
 end;
 
 alter table hr modify column birthdate date;
 
  -- Change hiredate format --
 update hr set hire_date = case
 when hire_date like "%/%" then date_format( str_to_date(hire_date, "%m/%d/%Y"), "%Y-%m-%d")
 when hire_date like "%-%" then date_format( str_to_date(hire_date, "%m-%d-%y"), "%Y-%m-%d")
 else null 
 end;
 
 alter table hr modify column hire_date date;
 
   -- Change termdate format --
update hr set termdate = date(str_to_date(termdate,"%Y-%m-%d %H:%i:%s UTC"))
where termdate is not null and TRIM(termdate) != '';

UPDATE hr SET termdate = NULL WHERE termdate = '';

 alter table hr modify column termdate date;
 
 -- create age column and add values --
 alter table hr modify  column age int after birthdate;
 
 update hr set age= timestampdiff(year, birthdate, curdate());
delete from hr where age<18;

-- employee gender count --
select gender, count(*) as Total from hr where termdate is null group by gender order by Total desc;

-- employee race count --
select race, count(*) as Total from hr where termdate is null group by race order by Total desc;

-- Age group distribution --
select case
when age between 18 and 24 then "18-24"
when age between 25 and 34 then "25-34"
when age between 35 and 44 then "35-44"
when age between 45 and 54 then "45-54"
when age between 55 and 64 then "55-64"
else "65+"
end as age_group, gender, count(*) Total from hr 
where termdate is null  group by age_group, gender order by age_group desc;

-- employees at HQ vs remote --
select location, count(*) from hr where termdate is null group by location;

-- Avg time of employement for terminated employees --
select avg(timestampdiff(year, hire_date, termdate)) as Avg_employement_time from hr where termdate is not null;

-- gender distribution across different dpt and gender--
select department, gender,  count(*) as Total from hr where termdate is not null
 group by department, gender order by department asc ;

-- job title distribution --
select jobtitle, count(*) as Total from hr where termdate is not null
 group by jobtitle order by Total desc ;
 
 -- turn over rate in each department --
 select department, terminations, hires, round((terminations/hires)*100,1) as turnover_rate from
(select department, count(*) as hires,
sum(case when termdate is not null then 1 else 0 end) as terminations from hr group by department) as temp
group by department order by turnover_rate desc;

-- employee distribution across different states --
select location_state, count(*) as Total from hr where termdate is not null
 group by  location_state order by Total desc ;
 
-- employee count change over time based on hire and termination --
select years, hires, terms, (hires-terms) as curr from
(select year(hire_date) as years, count(*) as hires,
sum(case when termdate is not null then 1 else 0 end) as terms from hr group by years) as temps
group by years;
 
-- avg tenure per department --
select department, round(avg(timestampdiff(year, hire_date, termdate)), 1)  as Avg_tenure from hr
 where termdate is not null group by department;






































