-- Revert db_design_intro:sequences/customer_customer_id_seq from pg

BEGIN;

DROP SEQUENCE rental.customer_customer_id_seq;

COMMIT;
