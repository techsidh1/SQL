USE creditcards;
SHOW Tables;
Show columns in cards;
select * from cards;

-- select -- get the data , aggregate function 
-- from --- source of the data 
-- where -- condition -- all the data or some data 
-- group by -- group by
-- having -- conditions on the grouped data
-- order by -- order data 
-- limit --- to limit the data 

select * 
	from cards;
    
select city, date 
	from cards;
    
select distinct gender
	from cards;
    
select *
	from cards
    where city is null;
    
select count(*) as TotalCount
	from cards;
    
select distinct cardtype
	from cards;
    
 select distinct ExpType
	from cards;   


select max(date) as recent_entry, min(date) as first_entry
	from cards
    order by date desc;

-- city colum 
select city, count(*) as total
	from cards
    group by city
    order by 2 desc;

select sum(amount) from cards;

select gender, count(*) as total, sum(Amount) as amount
	from cards
    group by gender;


select gender, CardType, count(1) as count
	from cards
    group by gender, CardType
    order by CardType desc;
-- females users are higher than male users

select gender, ExpType, sum(amount)as totalUsage
	from cards
    group by gender, ExpType
    order by ExpType desc;
    
select  cardtype, sum(amount) as total
	from cards
    group by CardType;
    
select  city, sum(amount) as total
	from cards
    group by city
    order by 2 desc
    limit 10;
select date,	year(date), month(date), day(date), dayname(date)
	from cards;
    
select 	
		year(date) as year, 
        month(date) as month, 
        sum(amount) as amount
	from cards
    group by year(date), month(date)
    order by year;
    
select dayname(date) as day, sum(amount) as amount
		from cards
        where dayname(date) in ('Friday', 'Saturday','sunday')
        group by 1;
        
    
select dayname(date) as day, sum(amount) as amount
		from cards
        where dayname(date) not in ('Friday', 'Saturday','sunday')
        group by 1;
-- city wise percatnge contribution        
with cte1 as(        
select city, sum(amount) as city_amount
	from cards
    group by city
),
cte2 as (
select sum(amount) as total_amount
	from cards
)
select c1.city, c1.city_amount, c2.total_amount,
		100 * c1.city_amount / c2.total_amount as percentage_of_total
	from  cte1 as c1 
    join cte2 as c2 
    order by 4 desc
    limit 4;
    
select city, ExpType, sum(amount)
		from cards
        group by 1
        order by 2;



