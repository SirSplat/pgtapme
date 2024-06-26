-- Deploy pgtapme_dev:comments/lkp_mth to pg
-- requires: appschema
-- requires: tables/lkp_mth

BEGIN;

COMMENT ON TABLE pgtapme.lkp_mth IS 'A look-up table of month names and numbers.';

COMMIT;
