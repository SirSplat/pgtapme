BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'actor', 'Table rental.actor should exist.');

  SELECT has_column('rental', 'actor', 'actor_id', 'Column rental.actor.actor_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'actor', 'actor_pk', 'dbo', 'Index rental.actor.actor_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'actor', 'actor_pk', 'Index rental.actor.actor_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'actor', 'actor_pk', 'Index rental.actor.actor_pk should be a unique index.');

  SELECT index_is_type('rental', 'actor', 'actor_pk', 'btree', 'Index rental.actor.actor_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
