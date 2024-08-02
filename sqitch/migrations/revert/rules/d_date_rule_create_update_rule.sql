-- Revert pgtapme_dev:rules/d_date_rule_create_update_rule from pg

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
      generate_series( date '1 jan 0001', date '31 dec 0001', '1 month' ) as s(v)
    ORDER BY
      1 ASC
  LOOP
    table_name := 'd_date_rule_y' || LPAD( EXTRACT( year from rec.start_date )::TEXT, 4, '0' ) || '_m' || LPAD( EXTRACT( month from rec.start_date )::TEXT, 2, '0' );
    EXECUTE FORMAT('
      DROP RULE %I ON %I.%I
      ',
      table_name || '_upd_rule',
      'pgtapme',
      'd_date_rule'
    );
  END LOOP;
END
$$;

COMMIT;