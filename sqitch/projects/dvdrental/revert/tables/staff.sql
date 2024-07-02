-- Revert db_design_intro:tables/staff from pg

BEGIN;

DROP TABLE rental.staff;

COMMIT;
