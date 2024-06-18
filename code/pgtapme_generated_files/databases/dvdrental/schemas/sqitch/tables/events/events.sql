BEGIN;
  SELECT plan(19);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'events', 'Table sqitch.events should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('sqitch', 'events', 'dbo', 'Table sqitch.events should have the correct owner.');

  SELECT partitions_are('sqitch', 'events', ARRAY[]::TEXT[], 'Table sqitch.events should have the correct partitions.');

  SELECT columns_are('sqitch', 'events', ARRAY['event', 'change_id', 'change', 'project', 'note', 'requires', 'conflicts', 'tags', 'committed_at', 'committer_name', 'committer_email', 'planned_at', 'planner_name', 'planner_email']::TEXT[], 'Table sqitch.events should have the correct columns.');

  SELECT indexes_are('sqitch', 'events', ARRAY['events_pkey']::TEXT[], 'Table sqitch.events should have the correct indexes.');

  SELECT triggers_are('sqitch', 'events', ARRAY[]::TEXT[], 'Table sqitch.events should have the correct triggers.');

  SELECT rules_are('sqitch', 'events', ARRAY[]::TEXT[], 'Table sqitch.events should have the correct rules.');

  SELECT has_pk('sqitch', 'events', 'Table sqitch.events should have a primary key.');

  SELECT col_is_pk('sqitch', 'events', ARRAY['change_id', 'committed_at']::TEXT[], 'Table sqitch.events should have the correct primary key columns.');

  SELECT col_isnt_pk('sqitch', 'events', ARRAY['change', 'committer_email', 'requires', 'event', 'planner_name', 'planner_email', 'project', 'note', 'conflicts', 'committer_name', 'tags']::TEXT[], 'Table sqitch.events should have the correct primary key columns.');

  SELECT has_fk('sqitch', 'events', 'Table sqitch.events should have a foreign key.');

  SELECT col_is_fk('sqitch', 'events', ARRAY['project']::TEXT[], 'Table sqitch.events should have the correct foreign key columns.');

  SELECT col_isnt_fk('sqitch', 'events', ARRAY['change', 'committer_email', 'requires', 'event', 'planner_name', 'planner_email', 'committed_at', 'note', 'planned_at', 'conflicts', 'committer_name', 'tags']::TEXT[], 'Table sqitch.events should have the correct foreign key columns.');

  SELECT has_check('sqitch', 'events', 'Table sqitch.events should have a check constraint.');

  SELECT col_has_check('sqitch', 'events', ARRAY['event']::TEXT[], 'Table sqitch.events should have the correct check constraint columns.');

  SELECT isnt_partitioned('sqitch', 'events', 'Table sqitch.events should not be partitioned.');

  SELECT hasnt_inherited_tables('sqitch', 'events', 'Table sqitch.events should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
