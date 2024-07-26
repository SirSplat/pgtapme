-- Revert pgtapme_dev:materialized_views/lkp_mth_mv from pg

BEGIN;

DROP MATERIALIZED VIEW pgtapme.lkp_mth_mv;

COMMIT;
