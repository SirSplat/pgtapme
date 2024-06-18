BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film_category', 'Table rental.film_category should exist.');

  SELECT has_column('rental', 'film_category', 'category_id', 'Column rental.film_category.category_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'category', 'Table rental.category should exist.');

  SELECT has_column('rental', 'category', 'category_id', 'Column rental.category.category_id should exist.');

  SELECT fk_ok('rental', 'film_category', ARRAY['category_id']::TEXT[], 'rental', 'category', ARRAY['category_id']::TEXT[], 'Foreign key rental.film_category.film_category_category_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
