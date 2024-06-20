BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'staff', 'Table rental.staff should exist.');

  SELECT has_column('rental', 'staff', 'username', 'Column rental.staff.username should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_not_null('rental', 'staff', 'username', 'Column rental.staff.username should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'staff', 'username', 'Column rental.staff.username should not have DEFAULT.');

  SELECT col_type_is('rental', 'staff', 'username', 'pg_catalog', 'character varying(16)', 'Column rental.staff.username should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
