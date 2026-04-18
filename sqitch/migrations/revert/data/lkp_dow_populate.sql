-- Revert pgtapme_dev:data/lkp_dow_populate from pg

BEGIN;

TRUNCATE TABLE pgtapme.lkp_dow;

COMMIT;
