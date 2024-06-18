BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'address2', 'Column rental.address.address2 should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_is_null('rental', 'address', 'address2', 'Column rental.address.address2 should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'address', 'address2', 'Column rental.address.address2 should not have DEFAULT.');

  SELECT col_type_is('rental', 'address', 'address2', 'pg_catalog', 'character varying(50)', 'Column rental.address.address2 should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
