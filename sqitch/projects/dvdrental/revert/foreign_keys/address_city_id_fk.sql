-- Revert db_design_intro:foreign_keys/address_city_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.address
    DROP CONSTRAINT address_city_id_fk;

COMMIT;
