-- Revert db_design_intro:indexes/category_pk from pg

BEGIN;

ALTER TABLE ONLY rental.category
    DROP CONSTRAINT category_pk;

COMMIT;
