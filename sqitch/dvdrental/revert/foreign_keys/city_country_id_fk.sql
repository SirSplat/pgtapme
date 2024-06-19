-- Revert db_design_intro:foreign_keys/city_country_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.city
    DROP CONSTRAINT city_country_id_fk;

COMMIT;
