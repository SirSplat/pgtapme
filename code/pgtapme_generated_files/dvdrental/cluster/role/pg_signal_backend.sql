BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_signal_backend', 'Role pg_signal_backend should exist.');

  SELECT isnt_superuser('pg_signal_backend', 'Group pg_signal_backend should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
