BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_column('sqitch', 'changes', 'project', 'Column sqitch.changes.project should exist.');

  SELECT has_column('sqitch', 'changes', 'script_hash', 'Column sqitch.changes.script_hash should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'changes', 'changes_project_script_hash_key', 'dbo', 'Index sqitch.changes.changes_project_script_hash_key should have the correct owner.');

  SELECT index_is_unique('sqitch', 'changes', 'changes_project_script_hash_key', 'Index sqitch.changes.changes_project_script_hash_key should be a unique index.');

  SELECT index_is_type('sqitch', 'changes', 'changes_project_script_hash_key', 'btree', 'Index sqitch.changes.changes_project_script_hash_key should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
