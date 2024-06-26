-- Revert pgtapme_dev:tables/lkp_dow from pg

BEGIN;

DROP TABLE pgtapme.lkp_dow;

COMMIT;
