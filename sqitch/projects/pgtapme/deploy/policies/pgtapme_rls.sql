-- Deploy pgtapme_dev:policies/pgtapme_rls to pg

BEGIN;

ALTER TABLE pgtapme.lkp_dow ENABLE ROW LEVEL SECURITY;

CREATE POLICY lkp_dow_readonly_select
    ON pgtapme.lkp_dow
    AS PERMISSIVE
    FOR SELECT
    TO pgtapme_readonly
    USING (true);

CREATE POLICY lkp_dow_readwrite_all
    ON pgtapme.lkp_dow
    AS PERMISSIVE
    FOR ALL
    TO pgtapme_readwrite
    USING (true)
    WITH CHECK (true);

COMMIT;
