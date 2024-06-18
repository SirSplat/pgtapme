BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'releases', 'Table sqitch.releases should exist.');

  SELECT has_column('sqitch', 'releases', 'version', 'Column sqitch.releases.version should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'float4', 'Data type pg_catalog.float4 should exist.');

  SELECT col_not_null('sqitch', 'releases', 'version', 'Column sqitch.releases.version should be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'releases', 'version', 'Column sqitch.releases.version should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'releases', 'version', 'pg_catalog', 'real', 'Column sqitch.releases.version should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
