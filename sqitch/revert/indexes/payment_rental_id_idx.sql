-- Revert db_design_intro:indexes/payment_rental_id_idx from pg

BEGIN;

DROP INDEX rental.payment_rental_id_idx;

COMMIT;
