-- Deploy db_design_intro:indexes/city_country_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX city_country_id_idx ON rental.city(country_id);

COMMIT;
