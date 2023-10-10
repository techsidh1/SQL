-- use wordsdictionary;

select *
	from sys.tables;

select *
	from dbo.words;

-- checking for the null values
select *
	from dbo.words
	
	where Word is null;
-- deleting the null values
-- delete from dbo.words where word is null;

select word, Definition
	from dbo.words;

select count(word) as Total_Values
	from dbo.words;

select *				-- what data do you want to fetch
	from dbo.words		-- from where do you want to get data
	where Lettercount = 5	-- is there any condition apllicable

select *
	from dbo.words
	where Lettercount = 25

select *
	from dbo.words
	where Lettercount >= 3 and Lettercount <= 7;

select *
	from dbo.words
	where Lettercount in (7,8,9)

select *
	from dbo.words
	where Lettercount between 4 and 8;

select *
	from dbo.words
	where Lettercount is not null;

select *
	from dbo.words
	where word ='Abaca'

select *
	from dbo.words
	where word Like '%A%'

select *
	from dbo.words
	where word Like '%x%'



select *
	from dbo.words
	where word Like 'A%'

select *
	from dbo.words
	where word Like '%A_a%'

select *
	from dbo.words 
	where word like '%ann_'

select *
	from dbo.words 
	where word like '%fair%'

select Lettercount, count(*) as total_count
	from dbo.words
	group by Lettercount
	order by 2 desc;

select *
	from dbo.words 
	where Lettercount = 83;

-- starting and ending with Vowels

select *
	from dbo.words 
	-- where word like '%[aeiouAEIOU]' and word like '[aeiouAEIOU]%'
	where word like '[aeiou]%[aeiou]'


select 
	count(case when word like 'A%' then 1 end) as total_A,
	count(case when word like 'B%' then 1 end) as total_B,
	count(case when word like 'X%' then 1 end) as total_X,
	count(case when word like 'Z%' then 1 end) as total_Z

	from dbo.words


-- palindrome 
select *,
		case when word = REVERSE(word) then 'Is a Palindrome'
		else 'Is not a Palinfrome'
		end as Palindrome
	from dbo.words 
	where DATALENGTH(word) > 3 and word = 'civic'
