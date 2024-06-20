BEGIN;
  SELECT plan(9);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'events', 'Table sqitch.events should exist.');

  SELECT has_column('sqitch', 'events', 'conflicts', 'Column sqitch.events.conflicts should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', '_text', 'Data type pg_catalog._text should exist.');

  SELECT col_not_null('sqitch', 'events', 'conflicts', 'Column sqitch.events.conflicts should be NOT NULL.');

  SELECT col_has_default('sqitch', 'events', 'conflicts', 'Column sqitch.events.conflicts should have DEFAULT.');

  SELECT col_default_is('sqitch', 'events', 'conflicts', '{}'::text[], 'Column sqitch.events.conflicts should have the correct default.');

  SELECT col_type_is('sqitch', 'events', 'conflicts', 'pg_catalog', 'text[]', 'Column sqitch.events.conflicts should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
