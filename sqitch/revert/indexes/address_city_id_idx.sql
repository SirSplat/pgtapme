-- Revert db_design_intro:indexes/address_city_id_idx from pg

BEGIN;

DROP INDEX rental.address_city_id_idx;

COMMIT;
