BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_execute_server_program', 'Role pg_execute_server_program should exist.');

  SELECT isnt_superuser('pg_execute_server_program', 'Group pg_execute_server_program should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
