-- Deploy pgtapme_dev:tables/lkp_mth to pg
-- requires: appschema

BEGIN;

CREATE TABLE pgtapme.lkp_mth (
    fk serial2 NOT NULL,
    int_month_number INTEGER NOT NULL,
    long_name_uc text NOT NULL,
    long_name_ic text NOT NULL,
    long_name_lc text NOT NULL,
    short_name_uc text NOT NULL,
    short_name_ic text NOT NULL,
    short_name_lc text NOT NULL,
    text_month_number text NOT NULL,
    CONSTRAINT lkp_mth_pk PRIMARY KEY (long_name_lc),
    CONSTRAINT lkp_mth_fky UNIQUE (fk)
);

COMMIT;
