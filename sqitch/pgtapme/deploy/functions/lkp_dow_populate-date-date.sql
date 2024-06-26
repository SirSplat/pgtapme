-- Deploy pgtapme_dev:functions/lkp_dow_populate to pg
-- requires: appschema
-- requires: tables/lkp_dow

BEGIN;

CREATE OR REPLACE FUNCTION pgtapme.lkp_dow_populate( start_date date DEFAULT '1 jan 1968', end_date date DEFAULT '7 jan 1968' )
RETURNS pg_catalog.void AS
$$
DECLARE
    _rec RECORD;
BEGIN

    IF ( AGE( end_date, start_date ) != '6 days' )
    THEN
        RAISE EXCEPTION 'Start date (%) can not be >= end date (%).', start_date, end_date;
    END IF;

    FOR _rec IN
        SELECT
            BTRIM(TO_CHAR(s.v, 'DAY')) AS long_name_uc,
            BTRIM(TO_CHAR(s.v, 'Day')) AS long_name_ic,
            BTRIM(TO_CHAR(s.v, 'day')) AS long_name_lc,
            BTRIM(TO_CHAR(s.v, 'DY')) AS short_name_uc,
            BTRIM(TO_CHAR(s.v, 'Dy')) AS short_name_ic,
            BTRIM(TO_CHAR(s.v, 'dy')) AS short_name_lc,
            BTRIM(LPAD(TO_CHAR(s.v, 'ID'), 2, '0')) AS text_iso_day_of_week_number,
            TO_CHAR(s.v, 'ID')::INTEGER AS int_iso_day_of_week_number,
            BTRIM(LPAD(TO_CHAR(s.v, 'D'), 2, '0')) AS text_int_day_of_week_number,
            TO_CHAR(s.v, 'D')::INTEGER AS int_day_of_week_number,
            CASE TO_CHAR(s.v, 'ID')::INTEGER
                WHEN 1 THEN FALSE
                WHEN 2 THEN FALSE
                WHEN 3 THEN FALSE
                WHEN 4 THEN FALSE
                WHEN 5 THEN FALSE
                WHEN 6 THEN TRUE
                WHEN 7 THEN TRUE
            END AS is_weekend
        FROM
            pg_catalog.generate_series( start_date, end_date, '1 day'::INTERVAL ) AS s( v )
    LOOP
        INSERT INTO pgtapme.lkp_dow (
            int_iso_day_of_week_number, int_day_of_week_number, is_weekend,
            long_name_uc, long_name_ic, long_name_lc,
            short_name_uc, short_name_ic, short_name_lc,
            text_iso_day_of_week_number, text_int_day_of_week_number
        ) VALUES (
            _rec.int_iso_day_of_week_number, _rec.int_day_of_week_number, _rec.is_weekend,
            _rec.long_name_uc, _rec.long_name_ic, _rec.long_name_lc,
            _rec.short_name_uc, _rec.short_name_ic, _rec.short_name_lc,
            _rec.text_iso_day_of_week_number, _rec.text_int_day_of_week_number
        );
    END LOOP;

END;
$$
LANGUAGE plpgsql
SECURITY INVOKER;

COMMIT;
