BEGIN;
  SELECT plan(4);

  SELECT has_language('sql', 'Language sql should exist.');

  SELECT has_role('postgres', 'Role postgres should exist.');

  SELECT language_owner_is('sql', 'postgres', 'Language sql should have the correct owner.');

  SELECT language_is_trusted('sql', 'Language sql should exist.');

  SELECT * FROM finish();
ROLLBACK;
