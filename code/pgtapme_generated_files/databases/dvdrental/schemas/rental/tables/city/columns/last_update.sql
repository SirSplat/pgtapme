BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'last_update', 'Column rental.city.last_update should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_not_null('rental', 'city', 'last_update', 'Column rental.city.last_update should be NOT NULL.');

  SELECT col_has_default('rental', 'city', 'last_update', 'Column rental.city.last_update should have DEFAULT.');

  SELECT col_default_is('rental', 'city', 'last_update', 'now()', 'Column rental.city.last_update should have the correct default.');

  SELECT col_type_is('rental', 'city', 'last_update', 'pg_catalog', 'timestamp without time zone', 'Column rental.city.last_update should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
