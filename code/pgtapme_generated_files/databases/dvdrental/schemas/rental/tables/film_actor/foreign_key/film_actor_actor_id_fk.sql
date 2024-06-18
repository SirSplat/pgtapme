BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film_actor', 'Table rental.film_actor should exist.');

  SELECT has_column('rental', 'film_actor', 'actor_id', 'Column rental.film_actor.actor_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'actor', 'Table rental.actor should exist.');

  SELECT has_column('rental', 'actor', 'actor_id', 'Column rental.actor.actor_id should exist.');

  SELECT fk_ok('rental', 'film_actor', ARRAY['actor_id']::TEXT[], 'rental', 'actor', ARRAY['actor_id']::TEXT[], 'Foreign key rental.film_actor.film_actor_actor_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
