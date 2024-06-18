BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'language_id', 'Column rental.film.language_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'film', 'film_language_id_idx', 'dbo', 'Index rental.film.film_language_id_idx should have the correct owner.');

  SELECT index_is_type('rental', 'film', 'film_language_id_idx', 'btree', 'Index rental.film.film_language_id_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
