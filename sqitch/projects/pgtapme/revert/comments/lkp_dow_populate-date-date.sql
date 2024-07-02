-- Revert pgtapme_dev:comments/lkp_dow_populate-date-date from pg

BEGIN;

COMMENT ON FUNCTION pgtapme.lkp_dow_populate(date, date) IS NULL;

COMMIT;
