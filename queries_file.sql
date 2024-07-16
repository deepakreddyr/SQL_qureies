select * 
FROM employee_demographics;

select first_name,last_name,birth_date,age,(age+10)*10
FROM employee_demographics;

select distinct first_name, gender
FROM employee_demographics;
select gender,avg(age)
FROM employee_demographics
group by gender;

select occupation,salary
FROM employee_salary
group by occupation,salary
;


select *
from employee_demographics
order by gender,age;

select * 
from employee_demographics
order by age desc
limit 2,1
;


select gender,avg(age) as avg_age
from employee_demographics
group by gender
having avg(age)>10
;

select * 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id=sal.employee_id;

select * 
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id=sal.employee_id;

select * 
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id+1=emp2.employee_id;


select * 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id=sal.employee_id
inner join parks_departments pd
	on sal.dept_id=pd.department_id
;

select first_name,last_name,salary,
case
	when salary<50000 then salary+(salary*0.05)
end as new_salary
from employee_salary;

select first_name ,salary,
(SELECT AVG(salary)
from employee_salary) as avg_sal
from employee_salary;

select dem.first_name , dem.last_name,gender,salary,
sum(salary) over(partition by gender order by dem.employee_id)as rolling_total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
    
select dem.first_name , dem.last_name,gender,salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
    
with cte_exp (Gender,AVg_sal,Max_sal,Min_sal,COUNR_sal)as 
(
select gender , avg(salary) avg_sal , max(salary) maxsal, min(salary) minsalary ,count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
group by gender
)
select *
from cte_exp
;
    

create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100));
    


insert into temp_table
values('deepak','blag','the one peace is real');
    
select * from temp_table;  
    
    
create procedure large_salaries()
select * 
from employee_salary
where salary>=50000;

call large_salaries();
    
    
DELIMITER $$
create procedure large_salary()
begin
	select * from employee_salary where salary>=50000;
    select * from employee_salary where salary>=50000;
end $$
DELIMITER ;
    
    
call large_salary();


    
DELIMITER $$
create trigger employess_insert
		after insert on employee_salary
        for each row 
begin 
	insert into employee_demographics(employee_id,first_name,last_name)
    values(new.employee_id, new.first_name,new.last_name);
end $$
DELIMITER ;

insert into employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
values (13,'Monkey D','Luffy','Pirate','0',null);
    
select * from employee_salary;

select * from employee_demographics;
    
DELIMITER $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete
	from employee_demographics
    where age>=60;
end $$
DELIMITER ;
    
show variables like 'event%';
    
    
    
    
    
    
    