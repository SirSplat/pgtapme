BEGIN;
  SELECT plan(15);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT schema_owner_is('sqitch', 'dbo', 'Schema sqitch should have the correct owner.');

  SELECT tables_are('sqitch', ARRAY['releases', 'projects', 'changes', 'tags', 'dependencies', 'events']::TEXT[], 'Schema sqitch should have the correct tables.');

  SELECT foreign_tables_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct foreign tables.');

  SELECT views_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct views.');

  SELECT materialized_views_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct materialized views.');

  SELECT sequences_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct sequences.');

  SELECT functions_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct functions.');

  SELECT opclasses_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct opclasses.');

  SELECT types_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct types.');

  SELECT domains_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct domains.');

  SELECT enums_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct enums.');

  SELECT operators_are('sqitch', ARRAY[]::TEXT[], 'Schema sqitch should have the correct operators.');

  SELECT extensions_are('sqitch', ARRAY[]::TEXT[], 'Cluster should have the correct extensions');

  SELECT * FROM finish();
ROLLBACK;
