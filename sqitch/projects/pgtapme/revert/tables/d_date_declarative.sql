-- Revert pgtapme_dev:tables/d_date_declarative from pg

BEGIN;

DROP TABLE pgtapme.d_date_declarative;

COMMIT;
