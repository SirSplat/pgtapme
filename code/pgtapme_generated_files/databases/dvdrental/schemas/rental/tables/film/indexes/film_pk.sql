BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'film_id', 'Column rental.film.film_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'film', 'film_pk', 'dbo', 'Index rental.film.film_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'film', 'film_pk', 'Index rental.film.film_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'film', 'film_pk', 'Index rental.film.film_pk should be a unique index.');

  SELECT index_is_type('rental', 'film', 'film_pk', 'btree', 'Index rental.film.film_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
