-- use AdventureWorks2019;

-- names of the regions
select Name
	from Sales.SalesTerritory;

-- total dues by regions 
select st.name,
		format(sum(soh.TotalDue), 'C0') as totalDue
	from Sales.SalesTerritory st
	join Sales.SalesOrderHeader soh on
	st.TerritoryID = soh.TerritoryID
	group by st.name
	order by st.name;


-- totaldue for each customer in region
select st.name as Region,
		CONCAT(FirstName, ' ', lastname) as Customer,
		format(sum(totaldue), 'C0') as Totaldue
	from Sales.SalesTerritory st 
	join sales.SalesOrderHeader soh on 
	st.TerritoryID = soh.TerritoryID 
	join Sales.Customer c on 
	soh.CustomerID = c.CustomerID 
	join Person.Person p on 
	c.PersonID = p.BusinessEntityID
	group by st.name, CONCAT(FirstName, ' ', lastname)
	order by st.name;

-- customers with higher total dues
select st.name as Region,
		CONCAT(FirstName, ' ', lastname) as Customer,
		format(sum(totaldue), 'C0') as Totaldue,
		ROW_NUMBER() over(partition by st.name order by sum(totaldue) desc) as custRank
	from Sales.SalesTerritory st 
	join sales.SalesOrderHeader soh on 
	st.TerritoryID = soh.TerritoryID 
	join Sales.Customer c on 
	soh.CustomerID = c.CustomerID 
	join Person.Person p on 
	c.PersonID = p.BusinessEntityID
	group by st.name, CONCAT(FirstName, ' ', lastname)
	order by st.name;


-- Top customer by total dues in each region
select st.name as Region,
		CONCAT(FirstName, ' ', lastname) as Customer,
		format(sum(totaldue), 'C0') as Totaldue,
		ROW_NUMBER() over(partition by st.name order by sum(totaldue) desc) as custRank
	from Sales.SalesTerritory st 
	join sales.SalesOrderHeader soh on 
	st.TerritoryID = soh.TerritoryID 
	join Sales.Customer c on 
	soh.CustomerID = c.CustomerID 
	join Person.Person p on 
	c.PersonID = p.BusinessEntityID
	group by st.name, CONCAT(FirstName, ' ', lastname)
	order by custRank

-- top 40 customers by total dues 
select Region, customer, totaldue
from (
select st.name as Region,
		CONCAT(FirstName, ' ', lastname) as Customer,
		format(sum(totaldue), 'C0') as Totaldue,
		ROW_NUMBER() over(partition by st.name order by sum(totaldue) desc) as custRank
	from Sales.SalesTerritory st 
	join sales.SalesOrderHeader soh on 
	st.TerritoryID = soh.TerritoryID 
	join Sales.Customer c on 
	soh.CustomerID = c.CustomerID 
	join Person.Person p on 
	c.PersonID = p.BusinessEntityID
	group by st.name, CONCAT(FirstName, ' ', lastname)
	) as totalduesbyCust_region
	where custRank <=30
	and Region = 'canada'

-- sum of total dues of top 30 customers in each region 
select Region, 
		format(sum(totaldue), 'C0') as TotalDue
from (
select st.name as Region,
		CONCAT(FirstName, ' ', lastname) as Customer,
		sum(totaldue) as Totaldue,
		ROW_NUMBER() over(partition by st.name order by sum(totaldue) desc) as custRank
	from Sales.SalesTerritory st 
	join sales.SalesOrderHeader soh on 
	st.TerritoryID = soh.TerritoryID 
	join Sales.Customer c on 
	soh.CustomerID = c.CustomerID 
	join Person.Person p on 
	c.PersonID = p.BusinessEntityID
	group by st.name, CONCAT(FirstName, ' ', lastname)
	) as totalduesbyCust_region
	where custRank <=30
	group by Region
	order by Region



-- sum of total dues of rest of the customers in each region 
select Region, 
		format(sum(totaldue), 'C0') as TotalDue
from (
select st.name as Region,
		CONCAT(FirstName, ' ', lastname) as Customer,
		sum(totaldue) as Totaldue,
		ROW_NUMBER() over(partition by st.name order by sum(totaldue) desc) as custRank
	from Sales.SalesTerritory st 
	join sales.SalesOrderHeader soh on 
	st.TerritoryID = soh.TerritoryID 
	join Sales.Customer c on 
	soh.CustomerID = c.CustomerID 
	join Person.Person p on 
	c.PersonID = p.BusinessEntityID
	group by st.name, CONCAT(FirstName, ' ', lastname)
	) as totalduesbyCust_region
	where custRank > 30
	group by Region
	order by Region