BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'country', 'Table rental.country should exist.');

  SELECT has_column('rental', 'country', 'country', 'Column rental.country.country should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_not_null('rental', 'country', 'country', 'Column rental.country.country should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'country', 'country', 'Column rental.country.country should not have DEFAULT.');

  SELECT col_type_is('rental', 'country', 'country', 'pg_catalog', 'character varying(50)', 'Column rental.country.country should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
