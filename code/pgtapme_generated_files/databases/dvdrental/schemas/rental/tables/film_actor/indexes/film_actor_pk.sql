BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film_actor', 'Table rental.film_actor should exist.');

  SELECT has_column('rental', 'film_actor', 'actor_id', 'Column rental.film_actor.actor_id should exist.');

  SELECT has_column('rental', 'film_actor', 'film_id', 'Column rental.film_actor.film_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'film_actor', 'film_actor_pk', 'dbo', 'Index rental.film_actor.film_actor_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'film_actor', 'film_actor_pk', 'Index rental.film_actor.film_actor_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'film_actor', 'film_actor_pk', 'Index rental.film_actor.film_actor_pk should be a unique index.');

  SELECT index_is_type('rental', 'film_actor', 'film_actor_pk', 'btree', 'Index rental.film_actor.film_actor_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
