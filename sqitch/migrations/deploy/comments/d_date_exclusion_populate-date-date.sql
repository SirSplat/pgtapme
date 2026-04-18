-- Deploy pgtapme_dev:comments/d_date_exclusion_populate-date-date to pg
-- requires: appschema
-- requires: functions/d_date_exclusion_populate-date-date

BEGIN;

COMMENT ON FUNCTION pgtapme.d_date_exclusion_populate(date, date) IS 'Function that populates the pgtapme.d_date_exclusion table using the two passed arguments which do have defaults.';

COMMIT;
