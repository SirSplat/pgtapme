BEGIN;
  SELECT plan(3);

  SELECT has_tablespace('pg_global', 'Tablespace pg_global should exist.');

  SELECT has_role('postgres', 'Role postgres should exist.');

  SELECT tablespace_owner_is('pg_global', 'postgres', 'Tablespace pg_global should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
