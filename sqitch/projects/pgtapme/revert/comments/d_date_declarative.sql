-- Revert pgtapme_dev:comments/d_date_declarative from pg

BEGIN;

COMMENT ON TABLE pgtapme.d_date_declarative IS NULL;

COMMIT;
