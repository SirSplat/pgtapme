BEGIN;
  SELECT plan(20);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'dependencies', 'Table sqitch.dependencies should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('sqitch', 'dependencies', 'dbo', 'Table sqitch.dependencies should have the correct owner.');

  SELECT partitions_are('sqitch', 'dependencies', ARRAY[]::TEXT[], 'Table sqitch.dependencies should have the correct partitions.');

  SELECT columns_are('sqitch', 'dependencies', ARRAY['change_id', 'type', 'dependency', 'dependency_id']::TEXT[], 'Table sqitch.dependencies should have the correct columns.');

  SELECT indexes_are('sqitch', 'dependencies', ARRAY['dependencies_pkey']::TEXT[], 'Table sqitch.dependencies should have the correct indexes.');

  SELECT triggers_are('sqitch', 'dependencies', ARRAY[]::TEXT[], 'Table sqitch.dependencies should have the correct triggers.');

  SELECT rules_are('sqitch', 'dependencies', ARRAY[]::TEXT[], 'Table sqitch.dependencies should have the correct rules.');

  SELECT has_pk('sqitch', 'dependencies', 'Table sqitch.dependencies should have a primary key.');

  SELECT col_is_pk('sqitch', 'dependencies', ARRAY['change_id', 'dependency']::TEXT[], 'Table sqitch.dependencies should have the correct primary key columns.');

  SELECT col_isnt_pk('sqitch', 'dependencies', ARRAY['type', 'dependency_id']::TEXT[], 'Table sqitch.dependencies should have the correct primary key columns.');

  SELECT has_fk('sqitch', 'dependencies', 'Table sqitch.dependencies should have a foreign key.');

  SELECT col_is_fk('sqitch', 'dependencies', ARRAY['change_id']::TEXT[], 'Table sqitch.dependencies should have the correct foreign key columns.');

  SELECT col_is_fk('sqitch', 'dependencies', ARRAY['dependency_id']::TEXT[], 'Table sqitch.dependencies should have the correct foreign key columns.');

  SELECT col_isnt_fk('sqitch', 'dependencies', ARRAY['dependency']::TEXT[], 'Table sqitch.dependencies should have the correct foreign key columns.');

  SELECT has_check('sqitch', 'dependencies', 'Table sqitch.dependencies should have a check constraint.');

  SELECT col_has_check('sqitch', 'dependencies', ARRAY['type', 'dependency_id']::TEXT[], 'Table sqitch.dependencies should have the correct check constraint columns.');

  SELECT isnt_partitioned('sqitch', 'dependencies', 'Table sqitch.dependencies should not be partitioned.');

  SELECT hasnt_inherited_tables('sqitch', 'dependencies', 'Table sqitch.dependencies should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
