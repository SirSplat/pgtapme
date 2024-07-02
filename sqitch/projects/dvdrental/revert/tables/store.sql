-- Revert db_design_intro:tables/store from pg

BEGIN;

DROP TABLE rental.store;

COMMIT;
