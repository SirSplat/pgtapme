-- Deploy db_design_intro:indexes/film_category_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.film_category
    ADD CONSTRAINT film_category_pk PRIMARY KEY (film_id, category_id);

COMMIT;
