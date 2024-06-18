-- Deploy db_design_intro:foreign_keys/city_country_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.city
    ADD CONSTRAINT city_country_id_fk FOREIGN KEY (country_id) REFERENCES rental.country(country_id);

COMMIT;
