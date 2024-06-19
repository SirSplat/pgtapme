-- Deploy db_design_intro:views/actor_info to pg
-- requires: appschema
-- requires: tables/film
-- requires: tables/film_category
-- requires: tables/film_actor
-- requires: tables/actor
-- requires: tables/category

BEGIN;

CREATE OR REPLACE VIEW rental.actor_info AS
 SELECT a.actor_id,
    a.first_name,
    a.last_name,
    rental.group_concat(DISTINCT (((c.name)::text || ': '::text) || ( SELECT rental.group_concat((f.title)::text) AS group_concat
           FROM ((rental.film f
             JOIN rental.film_category fc_1 ON ((f.film_id = fc_1.film_id)))
             JOIN rental.film_actor fa_1 ON ((f.film_id = fa_1.film_id)))
          WHERE ((fc_1.category_id = c.category_id) AND (fa_1.actor_id = a.actor_id))
          GROUP BY fa_1.actor_id))) AS film_info
   FROM (((rental.actor a
     LEFT JOIN rental.film_actor fa ON ((a.actor_id = fa.actor_id)))
     LEFT JOIN rental.film_category fc ON ((fa.film_id = fc.film_id)))
     LEFT JOIN rental.category c ON ((fc.category_id = c.category_id)))
  GROUP BY a.actor_id, a.first_name, a.last_name;

COMMIT;
