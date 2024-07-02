-- Revert pgtapme_dev:data/d_date_inherit_populate_partitions from pg

BEGIN;

TRUNCATE TABLE pgtapme.d_date_inherit;

COMMIT;
