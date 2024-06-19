-- Revert db_design_intro:indexes/rental_pk from pg

BEGIN;

ALTER TABLE ONLY rental.rental
    DROP CONSTRAINT rental_pk;

COMMIT;
