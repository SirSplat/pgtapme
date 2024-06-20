BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'last_update', 'Column rental.rental.last_update should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_not_null('rental', 'rental', 'last_update', 'Column rental.rental.last_update should be NOT NULL.');

  SELECT col_has_default('rental', 'rental', 'last_update', 'Column rental.rental.last_update should have DEFAULT.');

  SELECT col_default_is('rental', 'rental', 'last_update', 'now()', 'Column rental.rental.last_update should have the correct default.');

  SELECT col_type_is('rental', 'rental', 'last_update', 'pg_catalog', 'timestamp without time zone', 'Column rental.rental.last_update should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
