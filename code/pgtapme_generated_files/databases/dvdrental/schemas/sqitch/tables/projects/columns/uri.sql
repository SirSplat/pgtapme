BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'projects', 'Table sqitch.projects should exist.');

  SELECT has_column('sqitch', 'projects', 'uri', 'Column sqitch.projects.uri should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'text', 'Data type pg_catalog.text should exist.');

  SELECT col_is_null('sqitch', 'projects', 'uri', 'Column sqitch.projects.uri should not be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'projects', 'uri', 'Column sqitch.projects.uri should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'projects', 'uri', 'pg_catalog', 'text', 'Column sqitch.projects.uri should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
