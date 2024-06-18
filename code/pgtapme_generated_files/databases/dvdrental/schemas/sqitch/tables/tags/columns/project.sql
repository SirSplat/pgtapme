BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'project', 'Column sqitch.tags.project should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'text', 'Data type pg_catalog.text should exist.');

  SELECT col_not_null('sqitch', 'tags', 'project', 'Column sqitch.tags.project should be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'tags', 'project', 'Column sqitch.tags.project should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'tags', 'project', 'pg_catalog', 'text', 'Column sqitch.tags.project should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
