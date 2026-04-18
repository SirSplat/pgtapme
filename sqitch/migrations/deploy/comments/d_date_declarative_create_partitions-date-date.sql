-- Deploy pgtapme_dev:comments/d_date_declarative_create_partitions-date-date to pg
-- requires: appschema
-- requires: functions/d_date_declarative_create_partitions-date-date

BEGIN;

COMMENT ON FUNCTION pgtapme.d_date_declarative_create_partitions( date, date ) IS 'Creates partitions for pgtapme.d_date_declarative, defaults to 1 Jan 0001 through 31 Dec 0001.';

COMMIT;
