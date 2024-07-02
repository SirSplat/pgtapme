-- Revert db_design_intro_data:data/language from pg

BEGIN;

TRUNCATE TABLE rental.language;

COMMIT;
