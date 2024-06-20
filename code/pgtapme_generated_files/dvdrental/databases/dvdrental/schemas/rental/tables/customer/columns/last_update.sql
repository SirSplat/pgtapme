BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'last_update', 'Column rental.customer.last_update should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_is_null('rental', 'customer', 'last_update', 'Column rental.customer.last_update should not be NOT NULL.');

  SELECT col_has_default('rental', 'customer', 'last_update', 'Column rental.customer.last_update should have DEFAULT.');

  SELECT col_default_is('rental', 'customer', 'last_update', 'now()', 'Column rental.customer.last_update should have the correct default.');

  SELECT col_type_is('rental', 'customer', 'last_update', 'pg_catalog', 'timestamp without time zone', 'Column rental.customer.last_update should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
