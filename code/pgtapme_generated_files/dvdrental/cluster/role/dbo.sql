BEGIN;
  SELECT plan(2);

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT isnt_superuser('dbo', 'Group dbo should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
