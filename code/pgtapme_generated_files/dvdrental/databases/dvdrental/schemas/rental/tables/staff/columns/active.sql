BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'staff', 'Table rental.staff should exist.');

  SELECT has_column('rental', 'staff', 'active', 'Column rental.staff.active should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'bool', 'Data type pg_catalog.bool should exist.');

  SELECT col_not_null('rental', 'staff', 'active', 'Column rental.staff.active should be NOT NULL.');

  SELECT col_has_default('rental', 'staff', 'active', 'Column rental.staff.active should have DEFAULT.');

  SELECT col_default_is('rental', 'staff', 'active', 'true', 'Column rental.staff.active should have the correct default.');

  SELECT col_type_is('rental', 'staff', 'active', 'pg_catalog', 'boolean', 'Column rental.staff.active should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
