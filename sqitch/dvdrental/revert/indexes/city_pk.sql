-- Revert db_design_intro:indexes/city_pk from pg

BEGIN;

ALTER TABLE ONLY rental.city
    DROP CONSTRAINT city_pk;

COMMIT;
