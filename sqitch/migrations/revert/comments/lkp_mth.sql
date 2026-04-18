-- Revert pgtapme_dev:comments/lkp_mth from pg

BEGIN;

COMMENT ON TABLE pgtapme.lkp_mth IS NULL;

COMMIT;
