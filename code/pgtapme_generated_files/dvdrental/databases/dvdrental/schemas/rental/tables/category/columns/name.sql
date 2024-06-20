BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'category', 'Table rental.category should exist.');

  SELECT has_column('rental', 'category', 'name', 'Column rental.category.name should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_not_null('rental', 'category', 'name', 'Column rental.category.name should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'category', 'name', 'Column rental.category.name should not have DEFAULT.');

  SELECT col_type_is('rental', 'category', 'name', 'pg_catalog', 'character varying(25)', 'Column rental.category.name should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
