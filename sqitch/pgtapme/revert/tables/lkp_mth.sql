-- Revert pgtapme_dev:tables/lkp_mth from pg

BEGIN;

DROP TABLE pgtapme.lkp_mth;

COMMIT;
