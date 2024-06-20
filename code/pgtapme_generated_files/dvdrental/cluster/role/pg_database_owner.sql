BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_database_owner', 'Role pg_database_owner should exist.');

  SELECT isnt_superuser('pg_database_owner', 'Group pg_database_owner should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
