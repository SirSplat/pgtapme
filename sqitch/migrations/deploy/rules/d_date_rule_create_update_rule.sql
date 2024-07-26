-- Deploy pgtapme_dev:rules/d_date_rule_create_update_rule to pg
-- requires: appschema
-- requires: tables/d_date_rule
-- requires: tables/d_date_rule_create_partitions

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
      CREATE OR REPLACE RULE %I AS
        ON UPDATE TO %I.%I
        WHERE NEW."SQL Date" >= %L AND NEW."SQL Date" < %L
        DO INSTEAD (
          DELETE FROM %I.%I WHERE %I = OLD.%I;
          INSERT INTO %I.%I VALUES ( NEW.* )
        )
      ',
      table_name || '_upd_rule', /*CREATE OR REPLACE "Rule name"*/
      'pgtapme', /*ON UPDATE parent schema name*/
      'd_date_rule', /*ON UPDATE parent table name*/
      rec.start_date, /*WHERE >= value*/
      rec.end_date, /*WHERE < value*/
      'pgtapme', /*DELETE child schema name*/
      table_name, /*DELETE child table name*/
      'SQL Date', /*DELETE WHERE clause child primary key column name*/
      'SQL Date', /*DELETE WHERE clause NEW child primary key column name*/
      'pgtapme', /*INSERT INTO parent schema name*/
      'd_date_rule' /*INSERT INTO parent table name*/
    );
  END LOOP;
END
$$;

COMMIT;
