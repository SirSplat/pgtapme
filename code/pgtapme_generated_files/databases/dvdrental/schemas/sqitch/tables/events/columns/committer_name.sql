BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'events', 'Table sqitch.events should exist.');

  SELECT has_column('sqitch', 'events', 'committer_name', 'Column sqitch.events.committer_name should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'text', 'Data type pg_catalog.text should exist.');

  SELECT col_not_null('sqitch', 'events', 'committer_name', 'Column sqitch.events.committer_name should be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'events', 'committer_name', 'Column sqitch.events.committer_name should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'events', 'committer_name', 'pg_catalog', 'text', 'Column sqitch.events.committer_name should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
