BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'inventory', 'Table rental.inventory should exist.');

  SELECT has_column('rental', 'inventory', 'last_update', 'Column rental.inventory.last_update should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_not_null('rental', 'inventory', 'last_update', 'Column rental.inventory.last_update should be NOT NULL.');

  SELECT col_has_default('rental', 'inventory', 'last_update', 'Column rental.inventory.last_update should have DEFAULT.');

  SELECT col_default_is('rental', 'inventory', 'last_update', 'now()', 'Column rental.inventory.last_update should have the correct default.');

  SELECT col_type_is('rental', 'inventory', 'last_update', 'pg_catalog', 'timestamp without time zone', 'Column rental.inventory.last_update should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
