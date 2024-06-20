BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'city_id', 'Column rental.address.city_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int2', 'Data type pg_catalog.int2 should exist.');

  SELECT col_not_null('rental', 'address', 'city_id', 'Column rental.address.city_id should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'address', 'city_id', 'Column rental.address.city_id should not have DEFAULT.');

  SELECT col_type_is('rental', 'address', 'city_id', 'pg_catalog', 'smallint', 'Column rental.address.city_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
