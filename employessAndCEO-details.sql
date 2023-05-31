
select *
	from HumanResources.Employee;

-- total employees
select count(*) as TotalEmployees,
		count(BusinessEntityID) as TotalEmployees1
	from HumanResources.Employee




-- current flag
select CurrentFlag,
		count(*) as totalActiveEmployees
	from HumanResources.Employee
	group by CurrentFlag;


-- CEO details
select 
		CONCAT(t2.firstname, ' ', t2.LastName) as FullName,
		t1.HireDate as Started_on
		from HumanResources.Employee t1 
		join Person.Person t2 on
		t1.BusinessEntityID = t2.BusinessEntityID
		where t1.JobTitle = 'Chief Executive Officer'


-- who all are directly reporting to CEO
select 
	CONCAT(p.firstname, ' ', p.LastName) as FullName,
	e.JobTitle as Title
	from Person.Person p
	join HumanResources.Employee e on
	p.BusinessEntityID = e.BusinessEntityID
	where e.OrganizationLevel = '1'

