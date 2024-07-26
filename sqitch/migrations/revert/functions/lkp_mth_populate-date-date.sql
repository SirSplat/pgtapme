-- Revert pgtapme_dev:functions/lkp_mth_populate from pg

BEGIN;

DROP FUNCTION pgtapme.lkp_mth_populate(date, date);

COMMIT;
