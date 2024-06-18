BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'store', 'Table rental.store should exist.');

  SELECT has_column('rental', 'store', 'store_id', 'Column rental.store.store_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int4', 'Data type pg_catalog.int4 should exist.');

  SELECT col_not_null('rental', 'store', 'store_id', 'Column rental.store.store_id should be NOT NULL.');

  SELECT col_has_default('rental', 'store', 'store_id', 'Column rental.store.store_id should have DEFAULT.');

  SELECT col_default_is('rental', 'store', 'store_id', $$nextval('store_store_id_seq'::regclass)$$, 'Column rental.store.store_id should have the correct default.');

  SELECT col_type_is('rental', 'store', 'store_id', 'pg_catalog', 'integer', 'Column rental.store.store_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
