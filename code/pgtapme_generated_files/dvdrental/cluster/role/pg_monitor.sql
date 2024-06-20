BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_monitor', 'Role pg_monitor should exist.');

  SELECT isnt_superuser('pg_monitor', 'Group pg_monitor should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
