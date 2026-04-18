-- Deploy pgtapme_dev:comments/d_date_declarative to pg
-- requires: appschema
-- requires: tables/d_date_declarative

BEGIN;

COMMENT ON TABLE pgtapme.d_date_declarative IS 'Declarative partitioned version of pgtapme.d_date_exclusion.';

COMMIT;
