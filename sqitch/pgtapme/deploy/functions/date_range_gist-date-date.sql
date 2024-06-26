-- Deploy pgtapme_dev:functions/date_range_gist-date-date to pg
-- requires: appschema
-- requires: gist_ext

BEGIN;

CREATE OR REPLACE FUNCTION pgtapme.date_range(start_date date, end_date date)
RETURNS daterange AS
$$
    SELECT daterange(start_date, end_date, '[)')
$$
LANGUAGE sql IMMUTABLE;

COMMIT;
