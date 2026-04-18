-- Revert pgtapme_dev:comments/lkp_mth_populate-date-date from pg

BEGIN;

COMMENT ON FUNCTION pgtapme.lkp_mth_populate(date, date) IS NULL;

COMMIT;
