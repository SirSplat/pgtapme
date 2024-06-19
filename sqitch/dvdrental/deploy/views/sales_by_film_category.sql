-- Deploy db_design_intro:views/sales_by_film_category to pg
-- requires: appschema
-- requires: tables/payment
-- requires: tables/rental
-- requires: tables/inventory
-- requires: tables/film
-- requires: tables/film_category
-- requires: tables/category

BEGIN;

CREATE OR REPLACE VIEW rental.sales_by_film_category AS
 SELECT c.name AS category,
    sum(p.amount) AS total_sales
   FROM (((((rental.payment p
     JOIN rental.rental r ON ((p.rental_id = r.rental_id)))
     JOIN rental.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN rental.film f ON ((i.film_id = f.film_id)))
     JOIN rental.film_category fc ON ((f.film_id = fc.film_id)))
     JOIN rental.category c ON ((fc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY (sum(p.amount)) DESC;

COMMIT;
