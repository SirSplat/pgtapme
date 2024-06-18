BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'email', 'Column rental.customer.email should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_is_null('rental', 'customer', 'email', 'Column rental.customer.email should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'customer', 'email', 'Column rental.customer.email should not have DEFAULT.');

  SELECT col_type_is('rental', 'customer', 'email', 'pg_catalog', 'character varying(50)', 'Column rental.customer.email should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
