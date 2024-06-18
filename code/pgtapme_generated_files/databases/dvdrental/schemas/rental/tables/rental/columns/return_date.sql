BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'return_date', 'Column rental.rental.return_date should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_is_null('rental', 'rental', 'return_date', 'Column rental.rental.return_date should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'rental', 'return_date', 'Column rental.rental.return_date should not have DEFAULT.');

  SELECT col_type_is('rental', 'rental', 'return_date', 'pg_catalog', 'timestamp without time zone', 'Column rental.rental.return_date should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
