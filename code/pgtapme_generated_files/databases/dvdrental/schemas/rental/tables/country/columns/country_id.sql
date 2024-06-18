BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'country', 'Table rental.country should exist.');

  SELECT has_column('rental', 'country', 'country_id', 'Column rental.country.country_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int4', 'Data type pg_catalog.int4 should exist.');

  SELECT col_not_null('rental', 'country', 'country_id', 'Column rental.country.country_id should be NOT NULL.');

  SELECT col_has_default('rental', 'country', 'country_id', 'Column rental.country.country_id should have DEFAULT.');

  SELECT col_default_is('rental', 'country', 'country_id', $$nextval('country_country_id_seq'::regclass)$$, 'Column rental.country.country_id should have the correct default.');

  SELECT col_type_is('rental', 'country', 'country_id', 'pg_catalog', 'integer', 'Column rental.country.country_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
