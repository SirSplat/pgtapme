BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'title', 'Column rental.film.title should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'varchar', 'Data type pg_catalog.varchar should exist.');

  SELECT col_not_null('rental', 'film', 'title', 'Column rental.film.title should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'film', 'title', 'Column rental.film.title should not have DEFAULT.');

  SELECT col_type_is('rental', 'film', 'title', 'pg_catalog', 'character varying(255)', 'Column rental.film.title should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
