-- Revert pgtapme_dev:tables/d_date_rule from pg

BEGIN;

DROP TABLE pgtapme.d_date_rule;

COMMIT;
