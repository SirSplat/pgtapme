BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'country_id', 'Column rental.city.country_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int2', 'Data type pg_catalog.int2 should exist.');

  SELECT col_not_null('rental', 'city', 'country_id', 'Column rental.city.country_id should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'city', 'country_id', 'Column rental.city.country_id should not have DEFAULT.');

  SELECT col_type_is('rental', 'city', 'country_id', 'pg_catalog', 'smallint', 'Column rental.city.country_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
