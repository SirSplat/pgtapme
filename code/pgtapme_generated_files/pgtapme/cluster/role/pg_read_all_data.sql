BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_read_all_data', 'Role pg_read_all_data should exist.');

  SELECT isnt_superuser('pg_read_all_data', 'Group pg_read_all_data should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
