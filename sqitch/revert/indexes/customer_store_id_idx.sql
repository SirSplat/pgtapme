-- Revert db_design_intro:indexes/customer_store_id_idx from pg

BEGIN;

DROP INDEX rental.customer_store_id_idx;
COMMIT;
