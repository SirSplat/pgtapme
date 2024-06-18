BEGIN;
  SELECT plan(16);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'releases', 'Table sqitch.releases should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('sqitch', 'releases', 'dbo', 'Table sqitch.releases should have the correct owner.');

  SELECT partitions_are('sqitch', 'releases', ARRAY[]::TEXT[], 'Table sqitch.releases should have the correct partitions.');

  SELECT columns_are('sqitch', 'releases', ARRAY['version', 'installed_at', 'installer_name', 'installer_email']::TEXT[], 'Table sqitch.releases should have the correct columns.');

  SELECT indexes_are('sqitch', 'releases', ARRAY['releases_pkey']::TEXT[], 'Table sqitch.releases should have the correct indexes.');

  SELECT triggers_are('sqitch', 'releases', ARRAY[]::TEXT[], 'Table sqitch.releases should have the correct triggers.');

  SELECT rules_are('sqitch', 'releases', ARRAY[]::TEXT[], 'Table sqitch.releases should have the correct rules.');

  SELECT has_pk('sqitch', 'releases', 'Table sqitch.releases should have a primary key.');

  SELECT col_is_pk('sqitch', 'releases', ARRAY['version']::TEXT[], 'Table sqitch.releases should have the correct primary key columns.');

  SELECT col_isnt_pk('sqitch', 'releases', ARRAY['installer_name', 'installer_email', 'installed_at']::TEXT[], 'Table sqitch.releases should have the correct primary key columns.');

  SELECT hasnt_fk('sqitch', 'releases', 'Table sqitch.releases should not have a foreign key.');

  SELECT col_isnt_fk('sqitch', 'releases', ARRAY['installer_name', 'installer_email', 'version', 'installed_at']::TEXT[], 'Table sqitch.releases should have the correct foreign key columns.');

  SELECT isnt_partitioned('sqitch', 'releases', 'Table sqitch.releases should not be partitioned.');

  SELECT hasnt_inherited_tables('sqitch', 'releases', 'Table sqitch.releases should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
