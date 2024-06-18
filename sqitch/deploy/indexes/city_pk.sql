-- Deploy db_design_intro:indexes/city_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.city
    ADD CONSTRAINT city_pk PRIMARY KEY (city_id);

COMMIT;
