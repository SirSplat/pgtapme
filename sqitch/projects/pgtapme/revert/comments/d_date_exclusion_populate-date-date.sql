-- Revert pgtapme_dev:comments/d_date_exclusion_populate-date-date from pg

BEGIN;

COMMENT ON FUNCTION pgtapme.d_date_exclusion_populate(date, date) IS NULL;

COMMIT;
