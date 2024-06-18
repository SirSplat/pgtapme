BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_column('sqitch', 'changes', 'planned_at', 'Column sqitch.changes.planned_at should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamptz', 'Data type pg_catalog.timestamptz should exist.');

  SELECT col_not_null('sqitch', 'changes', 'planned_at', 'Column sqitch.changes.planned_at should be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'changes', 'planned_at', 'Column sqitch.changes.planned_at should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'changes', 'planned_at', 'pg_catalog', 'timestamp with time zone', 'Column sqitch.changes.planned_at should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
