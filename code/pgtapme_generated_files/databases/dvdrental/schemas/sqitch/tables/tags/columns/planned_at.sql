BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'planned_at', 'Column sqitch.tags.planned_at should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamptz', 'Data type pg_catalog.timestamptz should exist.');

  SELECT col_not_null('sqitch', 'tags', 'planned_at', 'Column sqitch.tags.planned_at should be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'tags', 'planned_at', 'Column sqitch.tags.planned_at should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'tags', 'planned_at', 'pg_catalog', 'timestamp with time zone', 'Column sqitch.tags.planned_at should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
