BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_use_reserved_connections', 'Role pg_use_reserved_connections should exist.');

  SELECT isnt_superuser('pg_use_reserved_connections', 'Group pg_use_reserved_connections should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
