-- Revert db_design_intro:indexes/payment_staff_id_idx from pg

BEGIN;

DROP INDEX rental.payment_staff_id_idx;

COMMIT;
