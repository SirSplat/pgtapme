BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'city_id', 'Column rental.city.city_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int4', 'Data type pg_catalog.int4 should exist.');

  SELECT col_not_null('rental', 'city', 'city_id', 'Column rental.city.city_id should be NOT NULL.');

  SELECT col_has_default('rental', 'city', 'city_id', 'Column rental.city.city_id should have DEFAULT.');

  SELECT col_default_is('rental', 'city', 'city_id', $$nextval('city_city_id_seq'::regclass)$$, 'Column rental.city.city_id should have the correct default.');

  SELECT col_type_is('rental', 'city', 'city_id', 'pg_catalog', 'integer', 'Column rental.city.city_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
