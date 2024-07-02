-- Deploy db_design_intro:indexes/customer_address_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX customer_address_id_idx ON rental.customer(address_id);

COMMIT;
