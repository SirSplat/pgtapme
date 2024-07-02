-- Deploy pgtapme_dev:comments/d_date_with_exclusion_constraint to pg
-- requires: appschema
-- requires: tables/d_date_with_exclusion_constraint

BEGIN;

COMMENT ON TABLE pgtapme.d_date_exclusion IS 'A date dimension table going to be used as a data source for the partitioned tables.';

COMMIT;
