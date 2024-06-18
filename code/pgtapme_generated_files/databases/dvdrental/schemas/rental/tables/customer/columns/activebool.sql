BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'activebool', 'Column rental.customer.activebool should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'bool', 'Data type pg_catalog.bool should exist.');

  SELECT col_not_null('rental', 'customer', 'activebool', 'Column rental.customer.activebool should be NOT NULL.');

  SELECT col_has_default('rental', 'customer', 'activebool', 'Column rental.customer.activebool should have DEFAULT.');

  SELECT col_default_is('rental', 'customer', 'activebool', 'true', 'Column rental.customer.activebool should have the correct default.');

  SELECT col_type_is('rental', 'customer', 'activebool', 'pg_catalog', 'boolean', 'Column rental.customer.activebool should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
