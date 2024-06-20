BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'city', 'Column rental.city.city should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_not_null('rental', 'city', 'city', 'Column rental.city.city should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'city', 'city', 'Column rental.city.city should not have DEFAULT.');

  SELECT col_type_is('rental', 'city', 'city', 'pg_catalog', 'character varying(50)', 'Column rental.city.city should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
