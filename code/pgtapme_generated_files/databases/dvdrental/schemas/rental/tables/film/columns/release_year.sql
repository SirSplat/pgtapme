BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'release_year', 'Column rental.film.release_year should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_type('rental', 'year', 'Data type rental.year should exist.');

  SELECT col_is_null('rental', 'film', 'release_year', 'Column rental.film.release_year should not be NOT NULL.');

  SELECT col_hasnt_default('rental', 'film', 'release_year', 'Column rental.film.release_year should not have DEFAULT.');

  SELECT col_type_is('rental', 'film', 'release_year', 'rental', 'year', 'Column rental.film.release_year should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
