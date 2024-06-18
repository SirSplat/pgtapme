BEGIN;
  SELECT plan(20);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('sqitch', 'tags', 'dbo', 'Table sqitch.tags should have the correct owner.');

  SELECT partitions_are('sqitch', 'tags', ARRAY[]::TEXT[], 'Table sqitch.tags should have the correct partitions.');

  SELECT columns_are('sqitch', 'tags', ARRAY['tag_id', 'tag', 'project', 'change_id', 'note', 'committed_at', 'committer_name', 'committer_email', 'planned_at', 'planner_name', 'planner_email']::TEXT[], 'Table sqitch.tags should have the correct columns.');

  SELECT indexes_are('sqitch', 'tags', ARRAY['tags_pkey', 'tags_project_tag_key']::TEXT[], 'Table sqitch.tags should have the correct indexes.');

  SELECT triggers_are('sqitch', 'tags', ARRAY[]::TEXT[], 'Table sqitch.tags should have the correct triggers.');

  SELECT rules_are('sqitch', 'tags', ARRAY[]::TEXT[], 'Table sqitch.tags should have the correct rules.');

  SELECT has_pk('sqitch', 'tags', 'Table sqitch.tags should have a primary key.');

  SELECT col_is_pk('sqitch', 'tags', ARRAY['tag_id']::TEXT[], 'Table sqitch.tags should have the correct primary key columns.');

  SELECT col_isnt_pk('sqitch', 'tags', ARRAY['committer_email', 'tag', 'planner_name', 'planner_email', 'committed_at', 'note', 'planned_at', 'committer_name']::TEXT[], 'Table sqitch.tags should have the correct primary key columns.');

  SELECT has_fk('sqitch', 'tags', 'Table sqitch.tags should have a foreign key.');

  SELECT col_is_fk('sqitch', 'tags', ARRAY['change_id']::TEXT[], 'Table sqitch.tags should have the correct foreign key columns.');

  SELECT col_is_fk('sqitch', 'tags', ARRAY['project']::TEXT[], 'Table sqitch.tags should have the correct foreign key columns.');

  SELECT col_isnt_fk('sqitch', 'tags', ARRAY['committer_email', 'tag', 'planner_name', 'planner_email', 'committed_at', 'note', 'planned_at', 'tag_id', 'committer_name']::TEXT[], 'Table sqitch.tags should have the correct foreign key columns.');

  SELECT has_unique('sqitch', 'tags', 'Table sqitch.tags should have a unique key.');

  SELECT col_is_unique('sqitch', 'tags', ARRAY['project', 'tag']::TEXT[], 'Table sqitch.tags should have the correct unique key columns.');

  SELECT isnt_partitioned('sqitch', 'tags', 'Table sqitch.tags should not be partitioned.');

  SELECT hasnt_inherited_tables('sqitch', 'tags', 'Table sqitch.tags should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
