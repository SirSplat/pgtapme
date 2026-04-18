-- Revert pgtapme_dev:functions/lkp_dow_populate from pg

BEGIN;

DROP FUNCTION pgtapme.lkp_dow_populate(date, date);

COMMIT;
