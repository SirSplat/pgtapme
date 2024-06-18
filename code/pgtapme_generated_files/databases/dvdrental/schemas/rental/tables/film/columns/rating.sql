BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'rating', 'Column rental.film.rating should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_type('rental', 'mpaa_rating', 'Data type rental.mpaa_rating should exist.');

  SELECT col_is_null('rental', 'film', 'rating', 'Column rental.film.rating should not be NOT NULL.');

  SELECT col_has_default('rental', 'film', 'rating', 'Column rental.film.rating should have DEFAULT.');

  SELECT col_default_is('rental', 'film', 'rating', 'G'::mpaa_rating, 'Column rental.film.rating should have the correct default.');

  SELECT col_type_is('rental', 'film', 'rating', 'rental', 'mpaa_rating', 'Column rental.film.rating should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
