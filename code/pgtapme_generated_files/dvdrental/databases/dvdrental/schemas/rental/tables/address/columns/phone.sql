BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'phone', 'Column rental.address.phone should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_not_null('rental', 'address', 'phone', 'Column rental.address.phone should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'address', 'phone', 'Column rental.address.phone should not have DEFAULT.');

  SELECT col_type_is('rental', 'address', 'phone', 'pg_catalog', 'character varying(20)', 'Column rental.address.phone should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
