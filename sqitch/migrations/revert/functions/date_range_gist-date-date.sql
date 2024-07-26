-- Revert pgtapme_dev:functions/date_range_gist-date-date from pg

BEGIN;

DROP FUNCTION pgtapme.date_range(date, date);

COMMIT;
