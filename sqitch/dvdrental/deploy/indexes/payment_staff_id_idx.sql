-- Deploy db_design_intro:indexes/payment_staff_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX payment_staff_id_idx ON rental.payment(staff_id);

COMMIT;
