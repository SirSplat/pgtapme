-- Deploy db_design_intro:indexes/payment_customer_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX payment_customer_id_idx ON rental.payment(customer_id);

COMMIT;
