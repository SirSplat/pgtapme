-- Revert db_design_intro:sequences/payment_payment_id_seq from pg

BEGIN;

DROP SEQUENCE rental.payment_payment_id_seq;

COMMIT;
