-- Deploy pgtapme_dev:data/d_date_exclusion_populate to pg
-- requires: appschema
-- requires: tables/d_date_with_exclusion_constraint
-- requires: functions/d_date_exclusion_populate-date-date

BEGIN;

SELECT pgtapme.d_date_exclusion_populate();

COMMIT;
