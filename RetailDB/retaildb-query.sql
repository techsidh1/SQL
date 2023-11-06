-- use retaildb;
-- show tables;
-- describe products;

select *
	from products;
    
select productCode, productname
	from products;

select officeCode, city, phone, country
		from offices
        where country in ('USA', 'France');
        
select productcode, productName, productLine, buyPrice   -- select values or columns 
	from products 											-- from - table name 
    where buyprice between 90 and 105;						-- condition 
    
select employeeNumber, firstName, lastName
			from employees
            where firstName Like 'd%';
					
select employeeNumber, firstName, lastName
			from employees
            where lastname Like '%rr%';        
      
select customerName, country, salesRepEmployeeNumber
	from customers
    where salesRepEmployeeNumber is null;
    
select customerName, country, salesRepEmployeeNumber
	from customers
    where salesRepEmployeeNumber is not null;

select distinct productLine as product_name
	from products;
    
select count(productname) as Total
		from products;
select *
			from products
            where productname rlike 'ship|boat';
            
select productLine, count(*) as Total_products
	from products
    group by productLine
    order by Total_products desc;
    
-- list all the payments
select max(amount) as max_amount, 
		min(amount) as min_amount, 
        avg(amount) as avg_amount
		from payments;
        
select *
	from payments
    where amount = ( select max(amount) from payments );
    
select *
	from payments
    where amount = ( select min(amount) from payments );

-- list all the data where amount is more than avg amount
select *
	from payments
    where amount > ( select avg(amount) from payments );  
    
    
-- list top 5 amount after max amount 
select *
	from payments
    where amount <> ( select max(amount) from payments )
    order by amount desc
    limit 5;
 
 -- list down all the customers who have not placed any order
 select customerName, phone
	from customers 
    where customerNumber not in (select distinct customerNumber from orders );
 
 -- finding the max, min avg number of products in sales orders
select max(products), min(products), avg(products)
	from ( select orderNumber, count(productcode) as products from orderdetails 
    group by orderNumber ) as items;
    
-- select * from orderdetails where orderNumber = 10100;
    




select customerName, country, salesRepEmployeeNumber
	from customers
    where salesRepEmployeeNumber is not null;

select 
		count(case when salesRepEmployeeNumber is null then 1 end) as No_SalesRep,
        count(case when salesRepEmployeeNumber is not null then 1 end) as Yes_salesRep
				from customers;
-- number of orders by status
select status, count(*) as total
	from orders
    group by status;

select * from orderdetails where ordernumber=10100;

-- get the number of items sold per order with total sales
select orderNumber,
		sum(quantityOrdered) as itemsCount,
        sum(priceEach*quantityOrdered) as Total
	from orderdetails
    group by orderNumber;

select orderNumber,
		sum(quantityOrdered) as itemsCount,
        sum(priceEach*quantityOrdered) as Total
	from orderdetails
    group by orderNumber
    having total > 50000 and  itemscount > 500;
    

select o.orderNumber, sum(priceEach * quantityOrdered) as Total
	from orderdetails od 
        join 
        orders o 
        on od.orderNumber = o.orderNumber
        group by o.orderNumber
        having sum(priceEach * quantityOrdered)  > 45000;
        
-- orders that are shipped and total amount > 20000
select od.orderNumber, o.status, sum(priceEach * quantityOrdered) as total 
		from orderdetails od join orders o 
        on od.orderNumber = o.orderNumber 
	group by od.orderNumber, o.status
    having status = 'Shipped' and total > 20000;
-- total order amount by status    
 select status, sum(priceEach * quantityOrdered) as Total
		from orders o join orderdetails od 
        on o.orderNumber = od.orderNumber
        group by status;
        
 -- total order amount by year    
 select 	year(orderdate) as year, 
			sum(priceEach * quantityOrdered) as Total
			from orders o join orderdetails od 
			on o.orderNumber = od.orderNumber
		where status = 'shipped'
        group by year(orderdate)
        -- having year = 2005;
        order by 2 desc;

-- total payment for a customer or all customers 
select c.customerName, sum(p.amount) as Total_Amount
from payments p join customers c      
on p.customerNumber = c.customerNumber
-- where c.customerName =  'Mini Wheels Co.' 
group by c.customerName;

-- number of orders by Mini Wheels Co.    
select c.customerName, sum(od.quantityOrdered) as Total
		from orderdetails od join orders o 
        on od.orderNumber = o.orderNumber 
        join customers c
        on o.customerNumber = c.customerNumber
        -- where c.customerName ='Mini Wheels Co.'
        group by c.customerName
        order by 2 desc;

    
  -- for each customer number of orders on hold..
  select c.customerName, count(*) as Order_on_hold
	from customers c 
    join orders o 
    on c.customerNumber = o.customerNumber
    where o.status = 'On Hold'
    group by c.customerName;
    
    
-- find the products ordered on a given day 
select productname, orderdate, dayname(o.orderdate) as Week_Day
		from products p join orderdetails od
        on p.productCode = od.productCode 
        join orders o 
        on od.orderNumber = o.orderNumber
        where dayname(o.orderdate) = 'Sunday';
    
-- top 10 customers by sales amount
select p.customerNumber, c.customerName,sum(p.amount) as TotalSales
	from payments p join customers c 
    on p.customerNumber = c.customerNumber 
    group by p.customerNumber, c.customerName
    order by TotalSales desc
    limit 10;
        
        
    
    
    
    
    
    