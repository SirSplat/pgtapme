-- Revert db_design_intro:sequences/country_country_id_seq from pg

BEGIN;

DROP SEQUENCE rental.country_country_id_seq;

COMMIT;
