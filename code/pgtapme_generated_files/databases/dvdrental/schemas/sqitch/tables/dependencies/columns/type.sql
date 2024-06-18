BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'dependencies', 'Table sqitch.dependencies should exist.');

  SELECT has_column('sqitch', 'dependencies', 'type', 'Column sqitch.dependencies.type should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'text', 'Data type pg_catalog.text should exist.');

  SELECT col_not_null('sqitch', 'dependencies', 'type', 'Column sqitch.dependencies.type should be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'dependencies', 'type', 'Column sqitch.dependencies.type should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'dependencies', 'type', 'pg_catalog', 'text', 'Column sqitch.dependencies.type should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
