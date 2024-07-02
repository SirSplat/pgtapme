-- Deploy pgtapme_dev:tables/d_date_with_exclusion_constraint to pg
-- requires: appschema
-- requires: tables/lkp_dow
-- requires: tables/lkp_mth
-- requires: extschema
-- requires: gist_ext

BEGIN;

CREATE TABLE pgtapme.d_date_exclusion_alignment (
  fk bigint CONSTRAINT d_date_exclusion_alignment_fk_uidx UNIQUE NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  "SQL Date" date NOT NULL CONSTRAINT d_date_exclusion_alignment_pk PRIMARY KEY,
  "Day Number in Month" int2 NOT NULL,
  "Day Number in Year" int2 NOT NULL,
  "Week Number in Year" int2 NOT NULL,
  "Week Number in Month" int2 NOT NULL,
  "Month Number in Year" int2 NOT NULL,
  "Day of Week" text NOT NULL CONSTRAINT d_date_exclusion_alignment_lkp_dow_long_name_ic_fk REFERENCES pgtapme.lkp_dow (long_name_ic) DEFERRABLE INITIALLY IMMEDIATE,
  "Short Day of Week" text NOT NULL CONSTRAINT d_date_exclusion_alignment_lkp_dow_short_name_ic_fk REFERENCES pgtapme.lkp_dow (short_name_ic) DEFERRABLE INITIALLY IMMEDIATE,
  "Month Name" text NOT NULL CONSTRAINT d_date_exclusion_alignment_lkp_mth_long_name_ic_fk REFERENCES pgtapme.lkp_mth (long_name_ic) DEFERRABLE INITIALLY IMMEDIATE,
  "Short Month Name" text NOT NULL CONSTRAINT d_date_exclusion_alignment_lkp_mth_short_name_ic_fk REFERENCES pgtapme.lkp_mth (short_name_ic) DEFERRABLE INITIALLY IMMEDIATE,
  "Year" text NOT NULL,
  "Date" text NOT NULL CONSTRAINT d_date_exclusion_alignment_date_uix UNIQUE,
  "Full Date Description" text NOT NULL,
  "Last Day in Week Indicator" text NOT NULL,
  "Last Day in Month Indicator" text NOT NULL,
  "Week Ending Date" text NOT NULL,
  "Year-Month" text NOT NULL,
  "Year Quarter" text NOT NULL,
  "Year-Quarter" text NOT NULL,
  "Year Half" text NOT NULL,
  "Weekday Indicator" text NOT NULL,
  "Year-Half" text NOT NULL,
  CONSTRAINT d_date_exclusion_alignment_exclusion_chk EXCLUDE USING gist ("SQL Date" WITH =, pgtapme.date_range('1 jan 0001'::DATE, '31 dec 30001'::DATE) WITH &&)
);

COMMIT;
