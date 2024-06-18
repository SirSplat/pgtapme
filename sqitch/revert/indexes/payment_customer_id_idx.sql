-- Revert db_design_intro:indexes/payment_customer_id_idx from pg

BEGIN;

DROP INDEX rental.payment_customer_id_idx;

COMMIT;
