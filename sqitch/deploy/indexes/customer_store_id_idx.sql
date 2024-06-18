-- Deploy db_design_intro:indexes/customer_store_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX customer_store_id_idx ON rental.customer(store_id);

COMMIT;
