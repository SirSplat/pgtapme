-- Revert db_design_intro:indexes/customer_last_name_idx from pg

BEGIN;

DROP INDEX rental.customer_last_name_idx;

COMMIT;
