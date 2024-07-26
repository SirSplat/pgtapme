-- Revert pgtapme_dev:comments/lkp_dow from pg

BEGIN;

COMMENT ON TABLE pgtapme.lkp_dow IS NULL;

COMMIT;
