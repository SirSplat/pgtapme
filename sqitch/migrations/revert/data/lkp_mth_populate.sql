-- Revert pgtapme_dev:data/lkp_mth_populate from pg

BEGIN;

TRUNCATE TABLE pgtapme.lkp_mth;

COMMIT;
