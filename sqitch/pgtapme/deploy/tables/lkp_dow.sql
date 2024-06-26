-- Deploy pgtapme_dev:tables/lkp_dow to pg
-- requires: appschema

BEGIN;

CREATE TABLE pgtapme.lkp_dow (
    fk serial2 NOT NULL,
    int_iso_day_of_week_number int2 NOT NULL,
    int_day_of_week_number int2 NOT NULL,
    is_weekend boolean NOT NULL,
    long_name_uc text NOT NULL,
    long_name_ic text NOT NULL,
    long_name_lc text NOT NULL,
    short_name_uc text NOT NULL,
    short_name_ic text NOT NULL,
    short_name_lc text NOT NULL,
    text_iso_day_of_week_number text NOT NULL,
    text_int_day_of_week_number text NOT NULL,
    CONSTRAINT lkp_dow_fk UNIQUE (fk),
    CONSTRAINT lkp_dow_pk PRIMARY KEY (long_name_lc)
);

COMMIT;
