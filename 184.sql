select d.name as department, e.name as employee, e.salary as salary
from employee e
join department d
on e.departmentid = d.id
where (e.departmentid, e.salary) in (
    select departmentid, max(salary)
    from employee
    group by departmentid
);

using window function:
SELECT
    Department,
    Employee,
    Salary
FROM (
    SELECT
        d.Name AS Department,
        e.Name AS Employee,
        e.Salary,
        DENSE_RANK() OVER (
            PARTITION BY e.DepartmentId
            ORDER BY e.Salary DESC
        ) AS rnk
    FROM Employee e
    JOIN Department d
        ON e.DepartmentId = d.Id
) t
WHERE rnk = 1;
