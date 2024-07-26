-- Deploy pgtapme_dev:comments/lkp_dow to pg
-- requires: appschema
-- requires: tables/lkp_dow

BEGIN;

COMMENT ON TABLE pgtapme.lkp_dow IS 'The day of week look-up table.';

COMMIT;
