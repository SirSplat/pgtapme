BEGIN;
  SELECT plan(3);

  SELECT has_language('internal', 'Language internal should exist.');

  SELECT has_role('postgres', 'Role postgres should exist.');

  SELECT language_owner_is('internal', 'postgres', 'Language internal should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
