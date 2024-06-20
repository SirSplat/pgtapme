BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'length', 'Column rental.film.length should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int2', 'Data type pg_catalog.int2 should exist.');

  SELECT col_is_null('rental', 'film', 'length', 'Column rental.film.length should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'film', 'length', 'Column rental.film.length should not have DEFAULT.');

  SELECT col_type_is('rental', 'film', 'length', 'pg_catalog', 'smallint', 'Column rental.film.length should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
