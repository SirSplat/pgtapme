BEGIN;
  SELECT plan(19);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('sqitch', 'changes', 'dbo', 'Table sqitch.changes should have the correct owner.');

  SELECT partitions_are('sqitch', 'changes', ARRAY[]::TEXT[], 'Table sqitch.changes should have the correct partitions.');

  SELECT columns_are('sqitch', 'changes', ARRAY['change_id', 'script_hash', 'change', 'project', 'note', 'committed_at', 'committer_name', 'committer_email', 'planned_at', 'planner_name', 'planner_email']::TEXT[], 'Table sqitch.changes should have the correct columns.');

  SELECT indexes_are('sqitch', 'changes', ARRAY['changes_pkey', 'changes_project_script_hash_key']::TEXT[], 'Table sqitch.changes should have the correct indexes.');

  SELECT triggers_are('sqitch', 'changes', ARRAY[]::TEXT[], 'Table sqitch.changes should have the correct triggers.');

  SELECT rules_are('sqitch', 'changes', ARRAY[]::TEXT[], 'Table sqitch.changes should have the correct rules.');

  SELECT has_pk('sqitch', 'changes', 'Table sqitch.changes should have a primary key.');

  SELECT col_is_pk('sqitch', 'changes', ARRAY['change_id']::TEXT[], 'Table sqitch.changes should have the correct primary key columns.');

  SELECT col_isnt_pk('sqitch', 'changes', ARRAY['change', 'committer_email', 'planner_name', 'planner_email', 'committed_at', 'note', 'planned_at', 'script_hash', 'committer_name']::TEXT[], 'Table sqitch.changes should have the correct primary key columns.');

  SELECT has_fk('sqitch', 'changes', 'Table sqitch.changes should have a foreign key.');

  SELECT col_is_fk('sqitch', 'changes', ARRAY['project']::TEXT[], 'Table sqitch.changes should have the correct foreign key columns.');

  SELECT col_isnt_fk('sqitch', 'changes', ARRAY['change', 'committer_email', 'planner_name', 'planner_email', 'committed_at', 'note', 'planned_at', 'script_hash', 'committer_name']::TEXT[], 'Table sqitch.changes should have the correct foreign key columns.');

  SELECT has_unique('sqitch', 'changes', 'Table sqitch.changes should have a unique key.');

  SELECT col_is_unique('sqitch', 'changes', ARRAY['project', 'script_hash']::TEXT[], 'Table sqitch.changes should have the correct unique key columns.');

  SELECT isnt_partitioned('sqitch', 'changes', 'Table sqitch.changes should not be partitioned.');

  SELECT hasnt_inherited_tables('sqitch', 'changes', 'Table sqitch.changes should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
