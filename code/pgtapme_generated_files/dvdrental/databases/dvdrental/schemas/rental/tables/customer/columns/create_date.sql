BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'create_date', 'Column rental.customer.create_date should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'date', 'Data type pg_catalog.date should exist.');

  SELECT col_not_null('rental', 'customer', 'create_date', 'Column rental.customer.create_date should be NOT NULL.');

  SELECT col_has_default('rental', 'customer', 'create_date', 'Column rental.customer.create_date should have DEFAULT.');

  SELECT col_default_is('rental', 'customer', 'create_date', $$('now'::text)::date$$, 'Column rental.customer.create_date should have the correct default.');

  SELECT col_type_is('rental', 'customer', 'create_date', 'pg_catalog', 'date', 'Column rental.customer.create_date should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
