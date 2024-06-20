BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'rental_duration', 'Column rental.film.rental_duration should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int2', 'Data type pg_catalog.int2 should exist.');

  SELECT col_not_null('rental', 'film', 'rental_duration', 'Column rental.film.rental_duration should be NOT NULL.');

  SELECT col_has_default('rental', 'film', 'rental_duration', 'Column rental.film.rental_duration should have DEFAULT.');

  SELECT col_default_is('rental', 'film', 'rental_duration', '3', 'Column rental.film.rental_duration should have the correct default.');

  SELECT col_type_is('rental', 'film', 'rental_duration', 'pg_catalog', 'smallint', 'Column rental.film.rental_duration should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
