-- Deploy pgtapme_dev:data/lkp_dow_populate to pg
-- requires: appschema
-- requires: tables/lkp_dow
-- requires: functions/lkp_dow_populate-date-date

BEGIN;

SELECT pgtapme.lkp_dow_populate();

COMMIT;
