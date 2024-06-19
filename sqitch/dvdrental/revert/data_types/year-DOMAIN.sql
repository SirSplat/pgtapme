-- Revert db_design_intro:data_types/year-DOMAIN from pg

BEGIN;

DROP DOMAIN rental.year;

COMMIT;
