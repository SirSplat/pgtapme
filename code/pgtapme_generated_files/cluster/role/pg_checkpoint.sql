BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_checkpoint', 'Role pg_checkpoint should exist.');

  SELECT isnt_superuser('pg_checkpoint', 'Group pg_checkpoint should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
