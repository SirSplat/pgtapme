BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_sequence('rental', 'actor_actor_id_seq', 'Sequence rental.actor_actor_id_seq should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT sequence_owner_is('rental', 'actor_actor_id_seq', 'dbo', 'Sequence rental.actor_actor_id_seq should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
