-- Revert db_design_intro:functions/last_updated()-trg-func from pg

BEGIN;

DROP FUNCTION rental.last_updated_trg_func();

COMMIT;
