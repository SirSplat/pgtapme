BEGIN;
  SELECT plan(3);

  SELECT has_tablespace('pg_default', 'Tablespace pg_default should exist.');

  SELECT has_role('postgres', 'Role postgres should exist.');

  SELECT tablespace_owner_is('pg_default', 'postgres', 'Tablespace pg_default should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
