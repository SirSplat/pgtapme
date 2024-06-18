BEGIN;
  SELECT plan(7);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'change_id', 'Column sqitch.tags.change_id should exist.');

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_column('sqitch', 'changes', 'change_id', 'Column sqitch.changes.change_id should exist.');

  SELECT fk_ok('sqitch', 'tags', ARRAY['change_id']::TEXT[], 'sqitch', 'changes', ARRAY['change_id']::TEXT[], 'Foreign key sqitch.tags.tags_change_id_fkey should exist.');

  SELECT * FROM finish();
ROLLBACK;
