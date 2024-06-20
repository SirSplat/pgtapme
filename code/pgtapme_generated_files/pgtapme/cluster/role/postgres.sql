BEGIN;
  SELECT plan(2);

  SELECT has_role('postgres', 'Role postgres should exist.');

  SELECT is_superuser('postgres', 'Role postgres should be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
