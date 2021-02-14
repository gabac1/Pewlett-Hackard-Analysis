SELECT e.emp_no, e.first_name, e.last_name,
       t.title, t.from_date, t.to_date
       INTO retirement_titles
       FROM employees AS e
       INNER JOIN titles AS t
       ON (e.emp_no = t.emp_no)
       WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
       ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no,
r.first_name,
r.last_name,
r.title

INTO unique_titles
FROM retirement_titles AS r
ORDER BY r.emp_no, r.to_date DESC;


SELECT COUNT(u.title) AS unique_count, u.title
INTO retiring_titles
FROM unique_titles AS u
GROUP BY u.title
ORDER BY COUNT(u.title) DESC;



SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date

INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS d
ON(e.emp_no = d.emp_no)
WHERE (d.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;


--- Additional Queries

SELECT DISTINCT ON (r.emp_no) r.emp_no,
r.first_name,
r.last_name,
r.title

INTO unique_titles
FROM retirement_titles AS r
WHERE (r.to_date = '9999-01-01')
ORDER BY r.emp_no, r.to_date DESC;




SELECT COUNT(e.emp_no)
FROM employees AS e
INNER JOIN dept_emp as d
ON (e.emp_no = d.emp_no)
WHERE (d.to_date = '9999-01-01')
;



--- Trainee Mentor Ratio
--- Mentors by Department
SELECT COUNT(m.emp_no),

d.dept_name

FROM mentorship_eligibility AS m
INNER JOIN dept_emp AS de
ON(m.emp_no = de.emp_no)
INNER JOIN departments AS d
ON(de.dept_no = d.dept_no)
GROUP BY(d.dept_name)
;

--- Retirement by Department
SELECT COUNT(m.emp_no), dept_name FROM 
(SELECT DISTINCT ON (r.emp_no) r.emp_no,
r.first_name,
r.last_name,
r.title,
d.dept_name

FROM retirement_titles AS r
INNER JOIN dept_emp AS de
ON(r.emp_no = de.emp_no)
INNER JOIN departments AS d
ON(de.dept_no = d.dept_no)
WHERE (r.to_date = '9999-01-01')

ORDER BY r.emp_no, r.to_date DESC) AS m
GROUP BY m.dept_name
ORDER BY COUNT(m.emp_no) DESC
;