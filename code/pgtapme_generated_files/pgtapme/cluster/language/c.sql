BEGIN;
  SELECT plan(3);

  SELECT has_language('c', 'Language c should exist.');

  SELECT has_role('postgres', 'Role postgres should exist.');

  SELECT language_owner_is('c', 'postgres', 'Language c should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
