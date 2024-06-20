BEGIN;
  SELECT plan(2);

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_extension('pg_catalog', 'plpgsql', 'Extension pg_catalog.plpgsql should exist.');

  SELECT * FROM finish();
ROLLBACK;
