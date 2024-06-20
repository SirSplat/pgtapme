BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'actor', 'Table rental.actor should exist.');

  SELECT has_column('rental', 'actor', 'last_name', 'Column rental.actor.last_name should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'actor', 'actor_last_name_idx', 'dbo', 'Index rental.actor.actor_last_name_idx should have the correct owner.');

  SELECT index_is_type('rental', 'actor', 'actor_last_name_idx', 'btree', 'Index rental.actor.actor_last_name_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
