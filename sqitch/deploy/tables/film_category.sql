-- Deploy db_design_intro:tables/film_category to pg
-- requires: appschema
-- requires: tables/film
-- requires: tables/category

BEGIN;

CREATE TABLE rental.film_category (
    film_id smallint NOT NULL,
    category_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
