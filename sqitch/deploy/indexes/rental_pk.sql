-- Deploy db_design_intro:indexes/rental_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.rental
    ADD CONSTRAINT rental_pk PRIMARY KEY (rental_id);

COMMIT;
