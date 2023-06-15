-- use AdventureWorks2019;

select rank() over(order by hiredate) as 'WorkingPeriodRank', *
		from HumanResources.Employee;

declare @currentdate date = '2015-10-30'
select 
	t1.BusinessEntityID,
	t2.firstName,
	t2.lastName,
	t1.jobtitle,
	t1.hiredate,
	rank() over(order by hiredate) as 'Rank',
	DATEDIFF(year, HireDate, @currentdate ) as 'YearEmployed',
	DATEDIFF(month, HireDate, @currentdate) as 'MonthsEmployed',
	DATEDIFF(day, HireDate, @currentdate) as 'DaysEmployed'
	into #tempTable1
	from HumanResources.Employee t1 
	join Person.Person t2 
	on t1.BusinessEntityID = t2.BusinessEntityID


select 
	case when YearEmployed between 0 and 2 then 'LessThanTwoYears'
		when YearEmployed between 2 and 4 then 'LessThanFourYeras'
		when YearEmployed between 4 and 6 then 'LessThanSixYears'
		when YearEmployed between 6 and 8 then 'OverSixYears'
		else 'OverEightYeras' 
		end as 'yearsEmployedGroup',
		count(*) as employeCount
from #tempTable1
		group by case when YearEmployed between 0 and 2 then 'LessThanTwoYears'
		when YearEmployed between 2 and 4 then 'LessThanFourYeras'
		when YearEmployed between 4 and 6 then 'LessThanSixYears'
		when YearEmployed between 6 and 8 then 'OverSixYears'
		else 'OverEightYeras'
		end
