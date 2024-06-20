BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'inventory', 'Table rental.inventory should exist.');

  SELECT has_column('rental', 'inventory', 'film_id', 'Column rental.inventory.film_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'film_id', 'Column rental.film.film_id should exist.');

  SELECT fk_ok('rental', 'inventory', ARRAY['film_id']::TEXT[], 'rental', 'film', ARRAY['film_id']::TEXT[], 'Foreign key rental.inventory.inventory_film_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
