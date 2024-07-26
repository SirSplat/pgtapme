-- Deploy pgtapme_dev:functions/lkp_mth_populate to pg
-- requires: appschema
-- requires: tables/lkp_mth

BEGIN;

CREATE OR REPLACE FUNCTION pgtapme.lkp_mth_populate( start_date date DEFAULT '1 jan 1968', end_date date DEFAULT '31 dec 1968' )
RETURNS pg_catalog.void AS
$$
DECLARE
    _rec RECORD;
BEGIN

    IF ( start_date - end_date NOT IN ( '-365', '-366' ) )
    THEN
        RAISE EXCEPTION 'Start date (%) - end date (%) can not be less than 12 months.', start_date, end_date;
    END IF;

    FOR _rec IN
        SELECT
            BTRIM(TO_CHAR(s.v, 'MONTH')) AS long_name_uc,
            BTRIM(TO_CHAR(s.v, 'Month')) AS long_name_ic,
            BTRIM(TO_CHAR(s.v, 'month')) AS long_name_lc,
            BTRIM(TO_CHAR(s.v, 'MON')) AS short_name_uc,
            BTRIM(TO_CHAR(s.v, 'Mon')) AS short_name_ic,
            BTRIM(TO_CHAR(s.v, 'mon')) AS short_name_lc,
            BTRIM(TO_CHAR(s.v, 'MM')) AS text_month_number,
            TO_CHAR(s.v, 'MM')::INTEGER AS int_month_number
        FROM
            pg_catalog.generate_series( '1 jan 1968'::DATE, '31 dec 1968'::DATE, '1 month'::INTERVAL ) AS s( v )
    LOOP
        INSERT INTO pgtapme.lkp_mth (
            int_month_number,
            long_name_uc, long_name_ic, long_name_lc,
            short_name_uc, short_name_ic, short_name_lc,
            text_month_number
        ) VALUES (
            _rec.int_month_number,
            _rec.long_name_uc, _rec.long_name_ic, _rec.long_name_lc,
            _rec.short_name_uc, _rec.short_name_ic, _rec.short_name_lc,
            _rec.text_month_number
        );
    END LOOP;

END;
$$
LANGUAGE plpgsql
SECURITY INVOKER;

COMMIT;
