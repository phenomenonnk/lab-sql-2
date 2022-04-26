-- 1. 
-- Use sakila database
use sakila;

-- 2.
-- Get all the data from tables actor, film and customer.
select * from actor;
 
select * from film;

select * from customer;

-- or we can get every data in one query
select * from actor, film, customer;

-- 3. 
-- Get film titles.
select title from sakila.film;

-- 4
 /* Get unique list of film languages under the alias language. Note that we are not asking you to obtain the language per each film, 
-- but this is a good time to think about how you might get that information in the future.*/
select distinct name as language from sakila.language;

-- or in one row
select group_concat(distinct name) as language from language;

-- 5
-- 5.1 Find out how many stores does the company have?
select count(distinct store_id) as "quantity of stores" from sakila.store; 
-- or
select count(store_id) as "quantity of stores" from sakila.store; 

-- 5.2 
-- Find out how many employees staff does the company have?
select count(staff_id) as "quantity of employees" from sakila.staff;

-- 5.3 
-- Return a list of employee first names only?
select first_name from staff where staff_id in (select distinct staff_id from staff);
-- or
select first_name from sakila.staff



-- Lab | SQL Queries 2

-- 1.
-- Select all the actors with the first name ‘Scarlett’.
select *
from sakila.actor
where first_name = 'Scarlett';

-- 2.
-- Select all the actors with the last name ‘Johansson’.
select *
from sakila.actor
where last_name = 'Johansson'; 

-- 3. 
-- How many films (movies) are available for rent?
-- just checking the number of rows in the table 
select count(return_date) as available 
from sakila.rental;

-- 4. 
-- How many films have been rented?
select sum(case when return_date is null then 1 else 0 end) as 'rented'
from sakila.rental;

-- or for both last questions 3 and 4
select sum(case when return_date is null then 1 else 0 end) as 'rented',
count(return_date) as 'returned-available'
from sakila.rental;

-- 5.
-- What is the shortest and longest rental period?
SELECT rental_date, return_date FROM sakila.rental, 
DATEDIFF (return_date, rental_date) AS date_difference 
where date_difference > 10 order by date_difference asc;


select date_format(convert(rental_date,date), '%Y-%M-%D') as rental_date,
date_format(convert(return_date,date), '%Y-%M-%D') as return_date,
date_format(rental_date, '%Y') as year_of_rental_date,
date_format(return_date, '%Y') as year_of_return_date,
-- (year_of_return_date)-(year_of_rental_date) as year_difference,
rental_date-return_date as rental_period
order by rental_period desc,
from sakila.rental;

-- 6.
-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select max(length) as max_duration,
min(length) as min_duration
from sakila.film;

-- 7. 
-- What's the average movie duration?
select avg(length)
from sakila.film;

-- 8.
-- What's the average movie duration expressed in format (hours, minutes)?
select floor(avg(length)/60) as hours,
avg(length)%60 as minutes
from sakila.film;
-- or
select date_format(sec_to_time(avg(length)*60), '%H:%i') as average_movie_duration
from sakila.film;

-- 9.
-- How many movies longer than 3 hours?
select count(length) from sakila.film 
where length > 180;

-- 10.
-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select concat(lower(first_name),'.',lower(last_name), '@sakilacustomer.org') as 'concat' 
from sakila.customer;
-- or
select *, lower(email)
from sakila.customer;

-- 11.
-- What's the length of the longest film title?
select * from sakila.film
order by length desc
limit 1;
select 'the length of the longest film title is 185 minutes';
-- or
select concat('the length of the longest film title is:', max(length), ' minutes') as the_length_of_the_longest_film_title
from sakila.film;