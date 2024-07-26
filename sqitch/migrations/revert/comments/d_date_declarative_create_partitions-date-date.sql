-- Revert pgtapme_dev:comments/d_date_declarative_create_partitions-date-date from pg

BEGIN;

COMMENT ON FUNCTION pgtapme.d_date_declarative_create_partitions( date, date ) IS NULL;

COMMIT;
