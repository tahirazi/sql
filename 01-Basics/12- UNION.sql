-- Union

--UNION
--It combine two or more select statements record in one without duplicates
--It performes distinct sort to remove duplicates. It's little slow as compare to UNION ALL
SELECT parentDepartment.Name, ISNULL(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
INNER JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id
UNION
SELECT parentDepartment.Name, COALESCE(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
LEFT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

--UNION ALL
--It combine two or more select statements record in one with duplicate records
--No sorting performed. Relatively faster than UNION
SELECT parentDepartment.Name, ISNULL(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
INNER JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id
UNION ALL
SELECT parentDepartment.Name, COALESCE(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
LEFT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

--ORDER BY with UNION (ALL)
--Will be after last SELECT statement
SELECT parentDepartment.Name, ISNULL(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
INNER JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id
UNION ALL
SELECT parentDepartment.Name, COALESCE(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
LEFT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id
ORDER BY Name