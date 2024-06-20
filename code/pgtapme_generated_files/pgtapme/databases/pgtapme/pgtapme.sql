BEGIN;
  SELECT plan(3);

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT db_owner_is('pgtapme', 'dbo', 'Database pgtapme should have the correct owner.');

  SELECT schemas_are( ARRAY['public', 'pgtap']::TEXT[], 'Database pgtapme should have the correct schemas.');

  SELECT * FROM finish();
ROLLBACK;
