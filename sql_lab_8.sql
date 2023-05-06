-- Leonardo Olmos Saucedo / SQL Lab 8
USE sakila;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, RANK() OVER (ORDER BY length) AS `rank`
FROM film
WHERE length <> '' OR length IS NULL;

/* 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
In your output, only select the columns title, length, rating and rank.
*/
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length) AS `rank`
FROM film
WHERE length <> '' OR length IS NULL;

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT fc.category_id, COUNT(f.film_id) AS total_films
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
GROUP BY fc.category_id;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor_name, COUNT(fa.actor_id) AS total_films
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, CONCAT(a.first_name, ' ', a.last_name)
ORDER BY 3 DESC
LIMIT 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(r.customer_id) AS total_rentals
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY 2 DESC
LIMIT 1;

/* Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
  This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
  Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
*/
SELECT i.film_id, f.title, COUNT(r.inventory_id) AS total_rentals
FROM film f
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY i.film_id, f.title
ORDER BY 3 DESC
LIMIT 1;


