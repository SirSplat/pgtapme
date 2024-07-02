-- Revert pgtapme_dev:data/d_date_rule_populate_partitions from pg

BEGIN;

TRUNCATE TABLE pgtapme.d_date_rule;

COMMIT;
