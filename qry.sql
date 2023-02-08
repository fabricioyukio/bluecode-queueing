
SELECT d.name, count(e.id) as number_of_employees
FROM department d LEFT JOIN employee e ON d.id=e.dept_id
GROUP BY  d.name
ORDER BY d.name, e.name



