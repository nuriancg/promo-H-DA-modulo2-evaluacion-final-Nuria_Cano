-- Para este ejerccio utilizaremos la BBDD Sakila. Nos aseguramos que seleccionamos la BBDD correcta.
USE sakila;

-- EJERCICIOS:
------------------------------------
-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
--
SELECT DISTINCT title
FROM film;


------------------------------------
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
--
SELECT DISTINCT title
FROM film
WHERE rating = 'PG-13';

-- Extra: Los ordenamos por nombre de forma ascendente y mostramos las clasificaciones.
SELECT DISTINCT title, rating AS 'clasificación'
FROM film
WHERE rating = 'PG-13'
ORDER BY title ASC;


------------------------------------
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
--
SELECT title, description
FROM film
WHERE description LIKE '%amazing%';


------------------------------------
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
--
SELECT title
FROM film
WHERE length > 120;

-- Extra: Mostramos la duracion
SELECT title, length AS 'duración'
FROM film
WHERE length > 120;


------------------------------------
-- 5. Recupera los nombres de todos los actores.
--
SELECT first_name AS 'nombres'
FROM actor;

-- Extra: Los ordenamos por nombre de forma ascendente
SELECT first_name AS 'nombres'
FROM actor
ORDER BY nombres;


------------------------------------
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
--
SELECT first_name AS 'nombre', last_name AS 'apellido'
FROM actor
WHERE last_name = 'Gibson';

-- Extra: option 2, nos aseguramos que también encontramos apellidos compuestos que contengan 'Gibson'.
SELECT first_name AS 'nombre', last_name AS 'apellido'
FROM actor
WHERE last_name LIKE '%Gibson%';


------------------------------------
-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
--
SELECT CONCAT(first_name,' ',last_name) AS 'nombres'
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- Extra: Mostramos el 'actor_id' i los ordenamos por 'actor_id' de forma ascendente.
SELECT actor_id, CONCAT(first_name,' ',last_name) AS 'nombres'
FROM actor
WHERE actor_id BETWEEN 10 AND 20
ORDER BY actor_id ASC;


------------------------------------
-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
--
SELECT title
FROM film
WHERE rating NOT IN ('R', 'PG-13');

-- Extra: Mostramos la clasificación.
SELECT title, rating AS 'clasificación'
FROM film
WHERE rating NOT IN ('R', 'PG-13');


------------------------------------
-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
--
SELECT rating AS 'clasificación', COUNT(film_id) AS 'cantidad_total'
FROM film
GROUP BY rating;


------------------------------------
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
--
SELECT customer.customer_id AS 'ID_cliente', CONCAT(customer.first_name,' ',customer.last_name) AS 'nombre_y_apellido', COUNT(rental.rental_id) AS 'total_pelis_alquiladas'
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

-- Extra: Usamos un LEFT JOIN por si hay clientes que no han alquilado ninúna película. Estos apareceran con NULL en la columna de 'total_pelis_alquiladas'
SELECT customer.customer_id AS 'ID_cliente', CONCAT(customer.first_name,' ',customer.last_name) AS 'nombre_y_apellido', COUNT(rental.rental_id) AS 'total_pelis_alquiladas'
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

------------------------------------
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
--
SELECT category.name AS 'categoría', COUNT(rental.rental_id) AS 'cantidad_total_pelis'
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON inventory.film_id = film_category.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY categoría;


------------------------------------
-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
--
SELECT rating AS 'clasificación', AVG (length) AS 'promedio_duracion'
FROM film
GROUP BY rating;

-- Extra: Lo ordenamos por 'clasificacion' de forma ascendente
SELECT rating AS 'clasificación', AVG (length) AS 'promedio_duracion'
FROM film
GROUP BY rating
ORDER BY rating ASC;


------------------------------------
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
--
SELECT CONCAT(actor.first_name,' ' ,actor.last_name) AS 'nombre_y_apellido'
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love';

-- Extra: Lo ordenamos por 'nombre' de forma ascendente
SELECT CONCAT(actor.first_name,' ' ,actor.last_name) AS 'nombre_y_apellido'
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love'
ORDER BY nombre_y_apellido ASC;


------------------------------------
-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
--
SELECT title
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- Extra: Mostramos la descripcion y añadimos una columa donde mostramos si aparece la palabra "dog" o "cat"
SELECT title, description,
	CASE WHEN description LIKE '%dog%' THEN 'dog'
    ELSE 'cat'
    END AS 'palabra_buscada'
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';


------------------------------------
-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
--
SELECT first_name, actor_id
FROM actor
WHERE actor_id NOT IN (
	SELECT DISTINCT actor_id
    FROM film_actor);
    
    
-- Extra: Comprobamos que tenemos el mísmo número de actores en la tabla 'actor' y en la tabla 'film_actor'
SELECT COUNT(DISTINCT actor_id) AS 'total_actores'
FROM actor
UNION ALL
SELECT COUNT(DISTINCT actor_id) 
FROM film_actor


------------------------------------
-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
--
SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- Extra: Mostramos el año del estreno 
SELECT title, release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;


------------------------------------
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
-- 
SELECT film.title
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE name = 'Family';

-- Extra: Mostramos el nombre de la categoria
SELECT film.title, category.name
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE name = 'Family';


------------------------------------
-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
--
SELECT CONCAT(actor.first_name,' ',actor.last_name) AS 'nombre_y_apellido'
FROM actor
WHERE EXISTS (
	SELECT actor_id, COUNT(film_id)
    FROM film_actor
    GROUP BY actor_id
    HAVING actor.actor_id = film_actor.actor_id AND COUNT(film_id) > 10);
    
-- Extra: Mostramos el total de películas en las que aparece cada actor y lo ordenador por nombre de actor de forma ascendete
WITH Actores_con_10_pelis (actor_id, num_pelis)AS (
												SELECT actor_id, COUNT(film_id)
												FROM film_actor
												GROUP BY actor_id
												HAVING  COUNT(film_id) > 10)
SELECT CONCAT(actor.first_name,' ',actor.last_name) AS 'nombre_y_apellido', num_pelis
FROM actor
INNER JOIN Actores_con_10_pelis ON Actores_con_10_pelis.actor_id = actor.actor_id
ORDER BY nombre_y_apellido ASC;


------------------------------------
-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
--
SELECT title
FROM film
WHERE rating = 'R' AND length > 120;

-- Extra: Mostramos las columnas de el 'rating' y la duracion
SELECT title, rating AS 'clasificacion', length AS 'duracion'
FROM film
WHERE rating = 'R' AND length > 120;


------------------------------------
-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT category.name, AVG(film.length) AS 'promedio_duracion'
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING AVG(film.length) > 120;


------------------------------------
-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
--
WITH actor_en_peli (actor_id, num_pelis)AS(
					SELECT actor_id, COUNT(film_id)
					FROM film_actor
					GROUP BY actor_id
					HAVING COUNT(film_id) >= 5)
SELECT CONCAT(t1.first_name,' ',t1.last_name) AS 'nombre_y_apellido', w.num_pelis AS 'total_pelis'
FROM actor AS t1
INNER JOIN actor_en_peli AS w ON t1.actor_id = w.actor_id;

-- Extra: Ordenamos los resultadis por nombre de forma ascendente
WITH actor_en_peli (actor_id, num_pelis)AS(
					SELECT actor_id, COUNT(film_id)
					FROM film_actor
					GROUP BY actor_id
					HAVING COUNT(film_id) >= 5)
SELECT CONCAT(t1.first_name,' ',t1.last_name) AS 'nombre_y_apellido', w.num_pelis AS 'total_pelis'
FROM actor AS t1
INNER JOIN actor_en_peli AS w ON t1.actor_id = w.actor_id
ORDER BY nombre_y_apellido ASC;


------------------------------------
-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
-- Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
-- 
SELECT film.title 
FROM film
WHERE film_id IN (
				SELECT film_id 
				FROM inventory
				WHERE inventory_id IN (
									SELECT inventory_id
									FROM rental
									WHERE DATEDIFF(return_date, rental_date) > 5));
                                    

------------------------------------
-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
--
SELECT CONCAT(actor.first_name,' ',actor.last_name) AS 'nombre_y_apellido'
FROM actor
WHERE actor_id NOT IN (
					SELECT actor_id
                    FROM film_actor
                    WHERE film_id IN (
									SELECT film_id
                                    FROM film_category
									WHERE category_id IN (
														SELECT category_id
														FROM category
														WHERE name = 'Horror')))
ORDER BY nombre_y_apellido ASC;


------------------------------------
-- BONUS
-- 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
--
SELECT title
FROM film
WHERE length > 180 AND film_id IN (
								SELECT film_id
								FROM film_category
								WHERE category_id IN (
													SELECT category_id
													FROM category
													WHERE name = 'Comedy'));


------------------------------------
-- 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. 
-- La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
--
WITH acores_juntos (id_actor_1, id_actor_2, peli) AS (
													SELECT t1.actor_id , t2.actor_id , t1.film_id
													FROM film_actor t1, film_actor t2
													WHERE t1.actor_id <> t2.actor_id AND t1.film_id = t2.film_id 
													)
SELECT CONCAT(i1.first_name,' ',i1.last_name) AS 'actor_1' , CONCAT(i2.first_name,' ',i2.last_name) AS 'actor_2', COUNT(peli)
FROM acores_juntos
INNER JOIN actor AS i1 ON i1.actor_id = acores_juntos.id_actor_1
INNER JOIN actor AS i2 ON i2.actor_id = acores_juntos.id_actor_2
GROUP BY actor_1, actor_2
ORDER BY actor_1;




