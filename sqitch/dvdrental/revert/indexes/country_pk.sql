-- Revert db_design_intro:indexes/country_pk from pg

BEGIN;

ALTER TABLE ONLY rental.country
    DROP CONSTRAINT country_pk;

COMMIT;
