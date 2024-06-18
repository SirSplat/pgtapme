-- Deploy db_design_intro:indexes/payment_rental_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX payment_rental_id_idx ON rental.payment(rental_id);

COMMIT;
