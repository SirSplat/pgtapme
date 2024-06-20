BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'customer_id', 'Column rental.customer.customer_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int4', 'Data type pg_catalog.int4 should exist.');

  SELECT col_not_null('rental', 'customer', 'customer_id', 'Column rental.customer.customer_id should be NOT NULL.');

  SELECT col_has_default('rental', 'customer', 'customer_id', 'Column rental.customer.customer_id should have DEFAULT.');

  SELECT col_default_is('rental', 'customer', 'customer_id', $$nextval('customer_customer_id_seq'::regclass)$$, 'Column rental.customer.customer_id should have the correct default.');

  SELECT col_type_is('rental', 'customer', 'customer_id', 'pg_catalog', 'integer', 'Column rental.customer.customer_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
