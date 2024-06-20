BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'active', 'Column rental.customer.active should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int4', 'Data type pg_catalog.int4 should exist.');

  SELECT col_is_null('rental', 'customer', 'active', 'Column rental.customer.active should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'customer', 'active', 'Column rental.customer.active should not have DEFAULT.');

  SELECT col_type_is('rental', 'customer', 'active', 'pg_catalog', 'integer', 'Column rental.customer.active should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
