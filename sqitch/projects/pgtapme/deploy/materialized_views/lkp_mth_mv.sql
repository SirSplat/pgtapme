-- Deploy pgtapme_dev:materialized_views/lkp_mth_mv to pg
-- requires: appschema
-- requires: tables/lkp_mth
-- requires: data/lkp_mth_populate

BEGIN;

CREATE MATERIALIZED VIEW pgtapme.lkp_mth_mv AS
    SELECT
        int_month_number,
        long_name_uc, long_name_ic, long_name_lc,
        short_name_uc, short_name_ic, short_name_lc, text_month_number
    FROM
        pgtapme.lkp_mth
    WHERE
        LENGTH(long_name_lc) > 6;

COMMIT;
