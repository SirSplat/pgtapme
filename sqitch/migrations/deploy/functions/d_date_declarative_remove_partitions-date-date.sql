-- Deploy pgtapme_dev:functions/d_date_declarative_remove_partitions-date-date to pg
-- requires: appschema
-- requires: tables/d_date_declarative

BEGIN;

CREATE OR REPLACE FUNCTION pgtapme.d_date_declarative_remove_partitions( start_date date DEFAULT '1 jan 0001', end_date date DEFAULT '31 dec 0001' )
RETURNS pg_catalog.void AS
$$
DECLARE
    _rec RECORD;
    table_name TEXT;
BEGIN

    ASSERT start_date < end_date, 'Start date can not be after end date! start_date: ' || start_date || ', end_date: ' || end_date;

    FOR _rec IN
        SELECT
            DISTINCT CAST( DATE_TRUNC( 'month', s.v ) AS DATE ) as start_date,
            CAST( DATE_TRUNC( 'month', s.v +INTERVAL '1 month' ) AS DATE ) AS end_date
        FROM
            GENERATE_SERIES( start_date, end_date, '1 month' ) AS s(v)
        ORDER BY
            1 ASC
    LOOP
        table_name := 'd_date_declarative_y' || LPAD( EXTRACT( year from _rec.start_date )::TEXT, 4, '0' ) || '_m' || LPAD( EXTRACT( month from _rec.start_date )::TEXT, 2, '0' );

        EXECUTE FORMAT(
            $_$
                DROP TABLE %I.%I;
            $_$,
            'pgtapme',
            table_name
        );
    END LOOP;

END;
$$
LANGUAGE plpgsql
SECURITY INVOKER;

COMMIT;
