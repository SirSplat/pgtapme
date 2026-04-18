-- Verify pgtapme_dev:functions/date_range_gist-date-date on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( CURRENT_USER, 'pgtapme.date_range(date, date)', 'EXECUTE' );

ROLLBACK;
