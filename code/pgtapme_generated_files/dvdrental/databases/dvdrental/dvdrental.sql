BEGIN;
  SELECT plan(3);

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT db_owner_is('dvdrental', 'dbo', 'Database dvdrental should have the correct owner.');

  SELECT schemas_are( ARRAY['public', 'pgtap', 'sqitch', 'rental']::TEXT[], 'Database dvdrental should have the correct schemas.');

  SELECT * FROM finish();
ROLLBACK;
