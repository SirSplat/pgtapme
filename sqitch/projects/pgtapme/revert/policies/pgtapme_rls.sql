-- Revert pgtapme_dev:policies/pgtapme_rls from pg

BEGIN;

DROP POLICY IF EXISTS lkp_dow_readonly_select ON pgtapme.lkp_dow;
DROP POLICY IF EXISTS lkp_dow_readwrite_all ON pgtapme.lkp_dow;
ALTER TABLE pgtapme.lkp_dow DISABLE ROW LEVEL SECURITY;

COMMIT;
