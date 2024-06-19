-- Revert db_design_intro:indexes/inventory_pk from pg

BEGIN;

ALTER TABLE ONLY rental.inventory
    DROP CONSTRAINT inventory_pk;

COMMIT;
