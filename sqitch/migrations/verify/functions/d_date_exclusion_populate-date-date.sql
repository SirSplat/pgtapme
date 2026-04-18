-- Verify pgtapme_dev:functions/d_date_exclusion_populate-date-date on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( CURRENT_USER, 'pgtapme.d_date_exclusion_populate(date, date)', 'EXECUTE' );

ROLLBACK;
