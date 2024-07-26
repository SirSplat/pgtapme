-- Revert pgtapme_dev:functions/d_date_inherit_create_trigger_function from pg

BEGIN;

DROP FUNCTION pgtapme.d_date_inherit_trg_func();

COMMIT;
