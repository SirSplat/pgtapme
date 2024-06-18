-- Deploy db_design_intro:foreign_keys/address_city_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.address
    ADD CONSTRAINT address_city_id_fk FOREIGN KEY (city_id) REFERENCES rental.city(city_id);

COMMIT;
