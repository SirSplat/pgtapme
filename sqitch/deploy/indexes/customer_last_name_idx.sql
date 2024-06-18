-- Deploy db_design_intro:indexes/customer_last_name_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX customer_last_name_idx ON rental.customer(last_name);

COMMIT;
