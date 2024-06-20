BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'language', 'Table rental.language should exist.');

  SELECT has_column('rental', 'language', 'language_id', 'Column rental.language.language_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int4', 'Data type pg_catalog.int4 should exist.');

  SELECT col_not_null('rental', 'language', 'language_id', 'Column rental.language.language_id should be NOT NULL.');

  SELECT col_has_default('rental', 'language', 'language_id', 'Column rental.language.language_id should have DEFAULT.');

  SELECT col_default_is('rental', 'language', 'language_id', $$nextval('language_language_id_seq'::regclass)$$, 'Column rental.language.language_id should have the correct default.');

  SELECT col_type_is('rental', 'language', 'language_id', 'pg_catalog', 'integer', 'Column rental.language.language_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
