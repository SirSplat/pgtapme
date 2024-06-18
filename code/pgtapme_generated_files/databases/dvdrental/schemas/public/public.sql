BEGIN;
  SELECT plan(15);

  SELECT has_schema('public', 'Schema public should exist.');

  SELECT has_role('pg_database_owner', 'Role pg_database_owner should exist.');

  SELECT schema_owner_is('public', 'pg_database_owner', 'Schema public should have the correct owner.');

  SELECT tables_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct tables.');

  SELECT foreign_tables_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct foreign tables.');

  SELECT views_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct views.');

  SELECT materialized_views_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct materialized views.');

  SELECT sequences_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct sequences.');

  SELECT functions_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct functions.');

  SELECT opclasses_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct opclasses.');

  SELECT types_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct types.');

  SELECT domains_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct domains.');

  SELECT enums_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct enums.');

  SELECT operators_are('public', ARRAY[]::TEXT[], 'Schema public should have the correct operators.');

  SELECT extensions_are('public', ARRAY[]::TEXT[], 'Cluster should have the correct extensions');

  SELECT * FROM finish();
ROLLBACK;
