-- List the employee number, last name, first name, sex, and salary of each employee.

select a.emp_no, last_name, first_name, sex, salary
from employees a join salaries b on a.emp_no = b.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.

select first_name, last_name, hire_date
from employees
where extract(YEAR from hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.

select b.dept_no, b.dept_name, b.emp_no, a.last_name, a.first_name
from employees a join 
	(select d.dept_no, d.dept_name, m.emp_no
	from dept_manager m join departments d on m.dept_no = d.dept_no) b on a.emp_no = b.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select d.dept_no, d.emp_no, last_name, first_name, d.dept_name
from employees e join 
	(select e.dept_no, d.dept_name, e.emp_no
	from dept_emp e join departments d ON d.dept_no = e.dept_no) d on e.emp_no=d.emp_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.

select emp_no, last_name, first_name
from employees
where emp_no in
	(select emp_no
	from dept_emp
	where dept_no in
		(select dept_no
		from departments
		where dept_name = 'Sales'));

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

select e.emp_no, last_name, first_name, dept_name
from employees e join 
(select emp_no, dept_name
from dept_emp de join 
	(select dept_no, dept_name
	from departments
	where dept_name = 'Sales' or dept_name = 'Development') d on de.dept_no = d.dept_no) b 
	on e.emp_no = b.emp_no;

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select last_name, count(*) as "Frequency"
from employees
group by last_name
order by "Frequency" desc;

