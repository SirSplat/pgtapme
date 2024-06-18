-- Revert db_design_intro:tables/category from pg

BEGIN;

DROP TABLE rental.category;

COMMIT;
