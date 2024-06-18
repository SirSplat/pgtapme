-- Deploy db_design_intro:indexes/address_city_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX address_city_id_idx ON rental.address(city_id);

COMMIT;
