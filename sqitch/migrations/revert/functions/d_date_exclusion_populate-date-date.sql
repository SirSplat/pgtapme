-- Revert pgtapme_dev:functions/d_date_exclusion_populate-date-date from pg

BEGIN;

DROP FUNCTION pgtapme.d_date_exclusion_populate( DATE, DATE );

COMMIT;
