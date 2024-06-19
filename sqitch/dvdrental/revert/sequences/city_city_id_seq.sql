-- Revert db_design_intro:sequences/city_city_id_seq from pg

BEGIN;

DROP SEQUENCE rental.city_city_id_seq;

COMMIT;
