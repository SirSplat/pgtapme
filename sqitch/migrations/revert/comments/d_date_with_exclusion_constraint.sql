-- Revert pgtapme_dev:comments/d_date_with_exclusion_constraint from pg

BEGIN;

COMMENT ON TABLE pgtapme.d_date_exclusion IS NULL;

COMMIT;
