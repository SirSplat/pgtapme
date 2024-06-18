BEGIN;
  SELECT plan(18);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'projects', 'Table sqitch.projects should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('sqitch', 'projects', 'dbo', 'Table sqitch.projects should have the correct owner.');

  SELECT partitions_are('sqitch', 'projects', ARRAY[]::TEXT[], 'Table sqitch.projects should have the correct partitions.');

  SELECT columns_are('sqitch', 'projects', ARRAY['project', 'uri', 'created_at', 'creator_name', 'creator_email']::TEXT[], 'Table sqitch.projects should have the correct columns.');

  SELECT indexes_are('sqitch', 'projects', ARRAY['projects_pkey', 'projects_uri_key']::TEXT[], 'Table sqitch.projects should have the correct indexes.');

  SELECT triggers_are('sqitch', 'projects', ARRAY[]::TEXT[], 'Table sqitch.projects should have the correct triggers.');

  SELECT rules_are('sqitch', 'projects', ARRAY[]::TEXT[], 'Table sqitch.projects should have the correct rules.');

  SELECT has_pk('sqitch', 'projects', 'Table sqitch.projects should have a primary key.');

  SELECT col_is_pk('sqitch', 'projects', ARRAY['project']::TEXT[], 'Table sqitch.projects should have the correct primary key columns.');

  SELECT col_isnt_pk('sqitch', 'projects', ARRAY['creator_email', 'created_at', 'creator_name']::TEXT[], 'Table sqitch.projects should have the correct primary key columns.');

  SELECT hasnt_fk('sqitch', 'projects', 'Table sqitch.projects should not have a foreign key.');

  SELECT col_isnt_fk('sqitch', 'projects', ARRAY['uri', 'creator_email', 'created_at', 'project', 'creator_name']::TEXT[], 'Table sqitch.projects should have the correct foreign key columns.');

  SELECT has_unique('sqitch', 'projects', 'Table sqitch.projects should have a unique key.');

  SELECT col_is_unique('sqitch', 'projects', ARRAY['uri']::TEXT[], 'Table sqitch.projects should have the correct unique key columns.');

  SELECT isnt_partitioned('sqitch', 'projects', 'Table sqitch.projects should not be partitioned.');

  SELECT hasnt_inherited_tables('sqitch', 'projects', 'Table sqitch.projects should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
