### Understanding the database
first Video


-- use the database
-- use AdventureWorks2019;


-- total objects in databse
select type_desc,
		count(type_desc) as total_count
	from sys.objects
	group by type_desc;

-- number of tables and columns in database
select	
		count(distinct s.name) as schemas,
		count(distinct t.name) as tables,
		count(c.name) as columns
	from sys.tables t 
	join sys.columns c on
	t.object_id = c.object_id
	join sys.schemas s on
	s.schema_id = t.schema_id


-- finding table details and coulm definitions
select	
		t2.name as TableName,
		t3.name as ColumnName,
		t1.value as ColumnDefinition
	from sys.extended_properties t1 
	join sys.tables t2 on 
	t1.major_id = t2.object_id
	join sys.columns t3  on
	t3.object_id = t1.major_id and
	t3.column_id = t1.minor_id
	where 
		class = 1 and 
		t2.name = 'Employee'

