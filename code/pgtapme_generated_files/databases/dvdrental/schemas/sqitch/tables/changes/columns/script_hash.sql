BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_column('sqitch', 'changes', 'script_hash', 'Column sqitch.changes.script_hash should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'text', 'Data type pg_catalog.text should exist.');

  SELECT col_is_null('sqitch', 'changes', 'script_hash', 'Column sqitch.changes.script_hash should not be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'changes', 'script_hash', 'Column sqitch.changes.script_hash should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'changes', 'script_hash', 'pg_catalog', 'text', 'Column sqitch.changes.script_hash should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
