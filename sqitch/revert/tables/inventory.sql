-- Revert db_design_intro:tables/inventory from pg

BEGIN;

DROP TABLE rental.inventory;

COMMIT;
