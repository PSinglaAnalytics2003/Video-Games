
select * from videogames

--removing the column
alter table videogames
drop column column14


--renaming the columns
exec sp_rename 'videogames.na_sales', 'northamerican_sales', 'COLUMN'

exec sp_rename 'videogames.jp_sales', 'japanese_sales', 'COLUMN'

exec sp_rename 'videogames.pal_sales', 'Europe_and_African_sales','COLUMN'



--changing the datatypes
alter table videogames
alter column title nvarchar(200)

alter table videogames
alter column console nvarchar(50)

alter table videogames
alter column genre nvarchar(50)


select ROUND (total_sales, 2)
from videogames


---removing duplicates
select * from videogames

delete from videogames
where title in
	(
		select title
		from
		(
			select title,console, genre, publisher, developer, critic_score, total_sales, northamerican_sales, japanese_sales,
			Europe_and_African_sales, other_sales, release_date, last_update, COUNT(title) as count_titles
			from videogames
			group by title, console, genre, publisher, developer, critic_score, total_sales, northamerican_sales, japanese_sales,
			Europe_and_African_sales, other_sales, release_date, last_update
			having count(title) > 1
				) as Duplicates
	)

---Which titles sold the most worldwide?
select title, max(total_sales) as max_sales
from videogames
where total_sales is not null
group by title
order by max_sales desc


--Which years had the highest and lowest sales?
select year(release_date) as Years, MAX(total_sales) max_sales, MIN(total_sales) as min_sales
from videogames
where total_sales is not null
group by year(release_date)
order by Years desc


--Do any consoles seem to specialize in a particular genre?
select console,genre, COUNT(genre) as total_genres
from videogames
group by console, genre
order by total_genres desc



