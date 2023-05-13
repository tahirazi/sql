-- Replacing Nulls

--Using ISNULL()
SELECT parentDepartment.Name, ISNULL(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
LEFT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

--Using COALESCE()
SELECT parentDepartment.Name, COALESCE(childDepartment.Name, 'No Child') AS ChildName
FROM Departments parentDepartment
LEFT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id

--Using CASE statement
SELECT parentDepartment.Name, 
CASE 
	WHEN childDepartment.Name IS NULL  THEN 'No Child' ELSE childDepartment.Name 
END AS ChildName
FROM Departments parentDepartment
LEFT JOIN Departments childDepartment 
ON childDepartment.ParentId = parentDepartment.Id