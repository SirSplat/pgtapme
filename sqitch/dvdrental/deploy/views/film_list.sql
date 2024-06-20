-- Deploy db_design_intro:views/film_list to pg
-- requires: appschema
-- requires: tables/category
-- requires: tables/film_category
-- requires: tables/film
-- requires: tables/film_actor
-- requires: tables/actor

BEGIN;

CREATE OR REPLACE VIEW rental.film_list AS
 SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    rental.group_concat((((actor.first_name)::text || ' '::text) || (actor.last_name)::text)) AS actors
   FROM ((((rental.category
     LEFT JOIN rental.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN rental.film ON ((film_category.film_id = film.film_id)))
     JOIN rental.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN rental.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;

COMMIT;