BEGIN;
  SELECT plan(2);

  SELECT has_role('pg_create_subscription', 'Role pg_create_subscription should exist.');

  SELECT isnt_superuser('pg_create_subscription', 'Group pg_create_subscription should not be a superuser.');

  SELECT * FROM finish();
ROLLBACK;
