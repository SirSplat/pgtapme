-- Revert db_design_intro:tables/language from pg

BEGIN;

DROP TABLE rental.language;

COMMIT;
