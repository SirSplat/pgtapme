BEGIN;
  SELECT plan(7);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'dependencies', 'Table sqitch.dependencies should exist.');

  SELECT has_column('sqitch', 'dependencies', 'change_id', 'Column sqitch.dependencies.change_id should exist.');

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_column('sqitch', 'changes', 'change_id', 'Column sqitch.changes.change_id should exist.');

  SELECT fk_ok('sqitch', 'dependencies', ARRAY['change_id']::TEXT[], 'sqitch', 'changes', ARRAY['change_id']::TEXT[], 'Foreign key sqitch.dependencies.dependencies_change_id_fkey should exist.');

  SELECT * FROM finish();
ROLLBACK;
