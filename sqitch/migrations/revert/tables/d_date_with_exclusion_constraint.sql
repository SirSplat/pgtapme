-- Revert pgtapme_dev:tables/d_date_with_exclusion_constraint from pg

BEGIN;

DROP TABLE pgtapme.d_date_exclusion;

COMMIT;
