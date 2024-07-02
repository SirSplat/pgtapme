-- Revert pgtapme_dev:tables/d_date_inherit_create_partitions from pg

BEGIN;

DO
$$
DECLARE
  start_date DATE;
  end_date DATE;
  table_name TEXT;
  rec RECORD;
BEGIN
    FOR rec IN
        SELECT
            DISTINCT CAST( DATE_TRUNC( 'month', s.v ) AS DATE ) as start_date,
            CAST( DATE_TRUNC( 'month', s.v +INTERVAL '1 month' ) AS DATE ) AS end_date
        FROM
            GENERATE_SERIES( DATE '1 jan 0001', DATE '31 dec 0001', '1 month' ) AS s(v)
        ORDER BY
            1 ASC
    LOOP
        table_name := 'd_date_inherit_y' || LPAD( EXTRACT( year from rec.start_date )::TEXT, 4, '0' ) || '_m' || LPAD( EXTRACT( month from rec.start_date )::TEXT, 2, '0' );
        EXECUTE FORMAT('DROP TABLE %I.%I',
            'pgtapme',
            table_name
        );
    END LOOP;
END
$$;

COMMIT;
