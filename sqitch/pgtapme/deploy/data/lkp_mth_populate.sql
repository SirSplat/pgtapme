-- Deploy pgtapme_dev:data/lkp_mth_populate to pg
-- requires: appschema
-- requires: tables/lkp_mth
-- requires: functions/lkp_mth_populate-date-date

BEGIN;

SELECT pgtapme.lkp_mth_populate();

COMMIT;
