BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'language', 'Table rental.language should exist.');

  SELECT has_column('rental', 'language', 'last_update', 'Column rental.language.last_update should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_not_null('rental', 'language', 'last_update', 'Column rental.language.last_update should be NOT NULL.');

  SELECT col_has_default('rental', 'language', 'last_update', 'Column rental.language.last_update should have DEFAULT.');

  SELECT col_default_is('rental', 'language', 'last_update', 'now()', 'Column rental.language.last_update should have the correct default.');

  SELECT col_type_is('rental', 'language', 'last_update', 'pg_catalog', 'timestamp without time zone', 'Column rental.language.last_update should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
