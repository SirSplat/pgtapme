-- Deploy db_design_intro:indexes/film_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.film
    ADD CONSTRAINT film_pk PRIMARY KEY (film_id);

COMMIT;
