-- Revert pgtapme_dev:data/d_date_exclusion_populate from pg

BEGIN;

TRUNCATE TABLE pgtapme.d_date_exclusion;

COMMIT;
