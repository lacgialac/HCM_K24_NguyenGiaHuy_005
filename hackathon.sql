drop database if exists hackathon;
create database hackathon;
use hackathon;

create table Department(
	dept_id varchar(5) primary key not null,
    dept_name varchar(100) not null unique,
    location VARCHAR(100) not null,
    manager_name VARCHAR(50) not null
);

create table Employee(
	emp_id varchar(5) primary key  not null,
    emp_name varchar(50) not null,
    dob date not null,
    email varchar(100) not null unique,
    phone varchar(15) not null unique,
    dept_id varchar(5) not null  ,
    
    constraint fk_dept
		foreign key(dept_id)
        references Department(dept_id)
    
);

create table Project(
	project_id varchar(5) primary key not null,
    project_name varchar(20) not null unique,
    start_date date not null,
    end_date date not null,
    budget decimal(10,2) not null
    
);

create table Assignment(
	assignment_id int primary key not null,
    emp_id varchar(5) not null,
    project_id varchar(5) not null,
    role varchar(20) not null,
    hours_worked int not null,
    
    constraint fk_empid
		foreign key(emp_id)
        references Employee(emp_id),
        
	constraint fk_projectid
		foreign key(project_id)
        references Project(project_id)
        

);

-- thêm dữ liệu vào bảng
insert into Department(dept_id, dept_name, location ,manager_name ) 
values
("D01", "IT", "Floor 5", "Nguyen Van An"),
("D02", "HR", "Floor 2", "Tran Thi Binh"),
("D03", "Sales", "Floor 1", "Le Van Cuong"),
("D04", "Maketing", "Floor 3", "Pham Thi Duong"),
("D05", "Finance", "Floor 4", "Hoang Van Tu");


insert into Employee(emp_id , emp_name ,dob ,email,phone,dept_id)
values
("E001","Nguyen Van Tuan","1990-01-01","tuan@mail.com","0901234567","D01"),
("E002","Tran Thi Lan","1990-05-05","lan@mail.com","0902345678","D02"),
("E003","Le Minh Khoi","1990-10-10","khoi@mail.com","0903456789","D01"),
("E004","Pham Hoang Namn","1990-12-12","nam@mail.com","0904567890","D03"),
("E005","Vu Minh Ha","1990-07-07","ha@mail.com","0905678901","D01");

insert into Project(project_id ,project_name ,start_date ,end_date, budget )values
("P001","Website Redesign","2025-01-01","2025-06-01","50000.00"),
("P002","WMobile App Dev","2025-02-01","2025-08-01","80000.00"),
("P003","HR System","2025-03-01","2025-09-01","30000.00"),
("P004","Marketing Campaign","2025-04-01","2025-03-01","10000.00"),
("P005","AI Research","2025-05-01","2025-12-01","100000.00");

insert into Assignment(assignment_id,emp_id ,project_id ,role,hours_worked )values
(1,"E001", "P001", "Developer",150),
(2,"E003", "P001", "Tester",100),
(3,"E001", "P002", "Tech Lead",200),
(4,"E005", "P005", "Data Scientist",180),
(5,"E004", "P004", "Content Creator",50);




-- p1 : truy van co ban
-- 3.
update Department
set location="Floor 10"
where dept_id='D01';
select *from Department;

-- 5.
set sql_safe_updates=0;
delete from Assignment 
where
	hours_worked =0
	or role ="Intern";
set sql_safe_updates=1;
select *from Assignment;

-- 6.
select emp_id,emp_name,email  from Employee
where dept_id="D01";

-- 7.
select project_name,start_date,budget from Project
where project_name like "%System%";

-- 8.
select project_id,project_name,budget from Project
order by budget desc;

-- 9.
select *from Employee
order by dob asc
limit 3;

-- 10.
select project_id,project_name  from Project
limit 3 offset 0;


-- P2: truy van nang cao 
-- 11.
select assignment_id,emp_name ,p.project_name,role  
from Assignment a
join Project p on a.project_id = p.project_id
join Employee e on a.emp_id = e.emp_id
where hours_worked >100;

-- 12.
select d.dept_id,d.dept_name ,e.emp_name  
from Department d
left join Employee e on e.dept_id=d.dept_id;

-- 13.
select
	p.project_name ,  
sum(hours_worked)	as Total_Hours
from Project p
join Assignment a on a.project_id = p.project_id
group by p.project_name;

-- 14.
select d.dept_name ,count(d.dept_id) as  Employee_Count from Employee e
join Department d on d.dept_id=e.dept_id
group by d.dept_name
having Employee_Count>2;

-- 15.
select e.emp_name,e.email from Project p
join Assignment a on a.project_id = p.project_id
join Employee e on e.emp_id=a.emp_id
where budget >50000
group by e.emp_name,a.Project_id,a.emp_id;

-- 17.
select e.emp_id,e.emp_name,d.dept_name,p.project_name ,a.hours_worked from Employee e
join Assignment a on a.project_id = p.project_id
join Employee e on e.emp_id=a.emp_id
join Department d on e.dept_id=d.dept_id;














    










