BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'language_id', 'Column rental.film.language_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'language', 'Table rental.language should exist.');

  SELECT has_column('rental', 'language', 'language_id', 'Column rental.language.language_id should exist.');

  SELECT fk_ok('rental', 'film', ARRAY['language_id']::TEXT[], 'rental', 'language', ARRAY['language_id']::TEXT[], 'Foreign key rental.film.film_language_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
