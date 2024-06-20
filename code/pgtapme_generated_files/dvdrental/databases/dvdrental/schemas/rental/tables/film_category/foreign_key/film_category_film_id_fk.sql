BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film_category', 'Table rental.film_category should exist.');

  SELECT has_column('rental', 'film_category', 'film_id', 'Column rental.film_category.film_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'film_id', 'Column rental.film.film_id should exist.');

  SELECT fk_ok('rental', 'film_category', ARRAY['film_id']::TEXT[], 'rental', 'film', ARRAY['film_id']::TEXT[], 'Foreign key rental.film_category.film_category_film_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
