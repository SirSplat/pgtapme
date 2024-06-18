-- Revert db_design_intro:indexes/customer_address_id_idx from pg

BEGIN;

DROP INDEX rental.customer_address_id_idx;

COMMIT;
