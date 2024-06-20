BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'postal_code', 'Column rental.address.postal_code should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_is_null('rental', 'address', 'postal_code', 'Column rental.address.postal_code should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'address', 'postal_code', 'Column rental.address.postal_code should not have DEFAULT.');

  SELECT col_type_is('rental', 'address', 'postal_code', 'pg_catalog', 'character varying(10)', 'Column rental.address.postal_code should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
