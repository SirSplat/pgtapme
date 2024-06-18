BEGIN;
  SELECT plan(9);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'events', 'Table sqitch.events should exist.');

  SELECT has_column('sqitch', 'events', 'tags', 'Column sqitch.events.tags should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', '_text', 'Data type pg_catalog._text should exist.');

  SELECT col_not_null('sqitch', 'events', 'tags', 'Column sqitch.events.tags should be NOT NULL.');

  SELECT col_has_default('sqitch', 'events', 'tags', 'Column sqitch.events.tags should have DEFAULT.');

  SELECT col_default_is('sqitch', 'events', 'tags', '{}'::text[], 'Column sqitch.events.tags should have the correct default.');

  SELECT col_type_is('sqitch', 'events', 'tags', 'pg_catalog', 'text[]', 'Column sqitch.events.tags should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
