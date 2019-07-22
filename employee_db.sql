create table departments (
	dept_no varchar(4) primary key,
	dept_name varchar(50)
);

create table employees (
	emp_no int primary key,
	birth_date date,
	first_name varchar(30),
	last_name varchar(30),
	gender varchar(2),
	hire_date date
);

create table dept_emp (
	emp_no int,
	dept_no varchar(4),
	from_date date,
	to_date date,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

create table titles (
	emp_no int,
	title varchar(30),
	from_date date,
	to_date date,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

create table dept_manager (
	dept_no varchar(4),
	emp_no int,
	from_date date,
	to_date date,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

create table salaries (
	emp_no int,
	salary int,
	from_date date,
	to_date date,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no, e.first_name, e.last_name, e.gender, s.salary
from employees as e
join salaries as s
on (e.emp_no = s.emp_no);


-- 2. List employees who were hired in 1986.
select emp_no, first_name, last_name, hire_date from employees
where hire_date > '1985-12-31' AND hire_date < '1987-01-01';


-- 3. List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name, and start and end employment dates.
select e.emp_no, e.first_name, e.last_name, dm.from_date, dm.to_date, dm.dept_no, d.dept_name
from employees as e
join dept_manager as dm
on (e.emp_no = dm.emp_no)
	join departments as d
	on (d.dept_no = dm.dept_no);

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name, de.dept_no, d.dept_name
from employees as e
join dept_emp as de
on (e.emp_no = de.emp_no)
	join departments as d
	on (d.dept_no = de.dept_no);


-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, emp_no from employees
where first_name = 'Hercules' AND last_name LIKE 'B%';



-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees as e
join dept_emp as de
on (e.emp_no = de.emp_no)
	join departments as d
	on (d.dept_no = de.dept_no)
	where d.dept_name = 'Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees as e
join dept_emp as de
on (e.emp_no = de.emp_no)
	join departments as d
	on (d.dept_no = de.dept_no)
	where d.dept_name = 'Sales' OR d.dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) from employees
group by last_name;


