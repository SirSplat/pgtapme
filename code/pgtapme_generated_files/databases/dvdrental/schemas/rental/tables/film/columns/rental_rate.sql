BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'rental_rate', 'Column rental.film.rental_rate should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'numeric', 'Data type pg_catalog.numeric should exist.');

  SELECT col_not_null('rental', 'film', 'rental_rate', 'Column rental.film.rental_rate should be NOT NULL.');

  SELECT col_has_default('rental', 'film', 'rental_rate', 'Column rental.film.rental_rate should have DEFAULT.');

  SELECT col_default_is('rental', 'film', 'rental_rate', '4.99', 'Column rental.film.rental_rate should have the correct default.');

  SELECT col_type_is('rental', 'film', 'rental_rate', 'pg_catalog', 'numeric(4,2)', 'Column rental.film.rental_rate should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
