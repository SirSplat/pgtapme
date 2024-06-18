BEGIN;
  SELECT plan(18);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film_actor', 'Table rental.film_actor should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'film_actor', 'dbo', 'Table rental.film_actor should have the correct owner.');

  SELECT partitions_are('rental', 'film_actor', ARRAY[]::TEXT[], 'Table rental.film_actor should have the correct partitions.');

  SELECT columns_are('rental', 'film_actor', ARRAY['actor_id', 'film_id', 'last_update']::TEXT[], 'Table rental.film_actor should have the correct columns.');

  SELECT indexes_are('rental', 'film_actor', ARRAY['film_actor_pk', 'film_actor_film_id_idx']::TEXT[], 'Table rental.film_actor should have the correct indexes.');

  SELECT triggers_are('rental', 'film_actor', ARRAY['last_updated_trg']::TEXT[], 'Table rental.film_actor should have the correct triggers.');

  SELECT rules_are('rental', 'film_actor', ARRAY[]::TEXT[], 'Table rental.film_actor should have the correct rules.');

  SELECT has_pk('rental', 'film_actor', 'Table rental.film_actor should have a primary key.');

  SELECT col_is_pk('rental', 'film_actor', ARRAY['actor_id', 'film_id']::TEXT[], 'Table rental.film_actor should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'film_actor', ARRAY['last_update']::TEXT[], 'Table rental.film_actor should have the correct primary key columns.');

  SELECT has_fk('rental', 'film_actor', 'Table rental.film_actor should have a foreign key.');

  SELECT col_is_fk('rental', 'film_actor', ARRAY['actor_id']::TEXT[], 'Table rental.film_actor should have the correct foreign key columns.');

  SELECT col_is_fk('rental', 'film_actor', ARRAY['film_id']::TEXT[], 'Table rental.film_actor should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'film_actor', ARRAY['last_update']::TEXT[], 'Table rental.film_actor should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'film_actor', 'Table rental.film_actor should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'film_actor', 'Table rental.film_actor should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
