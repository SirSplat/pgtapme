BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'language', 'Table rental.language should exist.');

  SELECT has_column('rental', 'language', 'name', 'Column rental.language.name should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'bpchar', 'Data type pg_catalog.bpchar should exist.');

  SELECT col_not_null('rental', 'language', 'name', 'Column rental.language.name should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'language', 'name', 'Column rental.language.name should not have DEFAULT.');

  SELECT col_type_is('rental', 'language', 'name', 'pg_catalog', 'character(20)', 'Column rental.language.name should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
