-- Deploy pgtapme_dev:comments/lkp_dow_populate-date-date to pg
-- requires: appschema
-- requires: functions/lkp_dow_populate-date-date

BEGIN;

COMMENT ON FUNCTION pgtapme.lkp_dow_populate(date, date) IS 'Function that populates the pgtapme.lkp_dow table using the two passed arguments which do have defaults.';

COMMIT;