BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'staff', 'Table rental.staff should exist.');

  SELECT has_column('rental', 'staff', 'picture', 'Column rental.staff.picture should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'bytea', 'Data type pg_catalog.bytea should exist.');

  SELECT col_is_null('rental', 'staff', 'picture', 'Column rental.staff.picture should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'staff', 'picture', 'Column rental.staff.picture should not have DEFAULT.');

  SELECT col_type_is('rental', 'staff', 'picture', 'pg_catalog', 'bytea', 'Column rental.staff.picture should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
