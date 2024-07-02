-- Revert db_design_intro:indexes/language_pk from pg

BEGIN;

ALTER TABLE ONLY rental.language
    DROP CONSTRAINT language_pk;

COMMIT;
