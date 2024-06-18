-- Revert db_design_intro:indexes/city_country_id_idx from pg

BEGIN;

DROP INDEX rental.city_country_id_idx;

COMMIT;
