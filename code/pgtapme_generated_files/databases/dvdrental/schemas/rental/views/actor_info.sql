BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_view('rental', 'actor_info', 'View rental.actor_info should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT view_owner_is('rental', 'actor_info', 'dbo', 'View rental.actor_info should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
