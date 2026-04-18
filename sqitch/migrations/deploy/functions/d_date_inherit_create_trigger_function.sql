-- Deploy pgtapme_dev:functions/d_date_inherit_create_trigger_function to pg
-- requires: appschema
-- requires: tables/d_date_inherit

BEGIN;

CREATE OR REPLACE FUNCTION pgtapme.d_date_inherit_trg_func()
RETURNS TRIGGER AS $$
BEGIN
  IF ( TG_OP = 'DELETE' OR TG_OP = 'UPDATE' )
  THEN
    EXECUTE FORMAT(
      'DELETE FROM %I.%I WHERE %I = $1',
      TG_TABLE_SCHEMA,
      TG_TABLE_NAME || '_y' || LPAD( EXTRACT( year FROM OLD."SQL Date" )::TEXT, 4, '0' ) || '_m' || LPAD( EXTRACT( month FROM OLD."SQL Date" )::TEXT, 2, '0' )
    ) USING OLD.id;
  END IF;

  IF ( TG_OP = 'INSERT' OR TG_OP = 'UPDATE' )
  THEN
    EXECUTE FORMAT(
      'INSERT INTO %I.%I VALUES ($1.*)',
      TG_TABLE_SCHEMA,
      TG_TABLE_NAME || '_y' || LPAD( EXTRACT( year FROM NEW."SQL Date" )::TEXT, 4, '0' ) || '_m' || LPAD( EXTRACT( month FROM NEW."SQL Date" )::TEXT, 2, '0' )
    ) USING NEW;
  END IF;
  RETURN NULL;
END;
$$
LANGUAGE plpgsql;

COMMIT;
