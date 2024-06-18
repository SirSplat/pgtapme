BEGIN;
  SELECT plan(9);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'note', 'Column sqitch.tags.note should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'text', 'Data type pg_catalog.text should exist.');

  SELECT col_not_null('sqitch', 'tags', 'note', 'Column sqitch.tags.note should be NOT NULL.');

  SELECT col_has_default('sqitch', 'tags', 'note', 'Column sqitch.tags.note should have DEFAULT.');

  SELECT col_default_is('sqitch', 'tags', 'note', ''::text, 'Column sqitch.tags.note should have the correct default.');

  SELECT col_type_is('sqitch', 'tags', 'note', 'pg_catalog', 'text', 'Column sqitch.tags.note should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
