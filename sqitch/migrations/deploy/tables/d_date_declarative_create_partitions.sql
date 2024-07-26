-- Deploy pgtapme_dev:tables/d_date_declarative_create_partitions to pg
-- requires: appschema
-- requires: tables/d_date_declarative
-- requires: functions/d_date_declarative_create_partitions-date-date

BEGIN;

SELECT pgtapme.d_date_declarative_create_partitions();

COMMIT;
