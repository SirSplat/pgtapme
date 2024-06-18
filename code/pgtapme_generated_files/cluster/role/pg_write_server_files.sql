BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_write_server_files', 'Role pg_write_server_files should exist.');

  SELECT isnt_superuser('pg_write_server_files', 'Group pg_write_server_files should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
