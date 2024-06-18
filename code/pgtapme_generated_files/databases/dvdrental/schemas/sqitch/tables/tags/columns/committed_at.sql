BEGIN;
  SELECT plan(9);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'committed_at', 'Column sqitch.tags.committed_at should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamptz', 'Data type pg_catalog.timestamptz should exist.');

  SELECT col_not_null('sqitch', 'tags', 'committed_at', 'Column sqitch.tags.committed_at should be NOT NULL.');

  SELECT col_has_default('sqitch', 'tags', 'committed_at', 'Column sqitch.tags.committed_at should have DEFAULT.');

  SELECT col_default_is('sqitch', 'tags', 'committed_at', 'clock_timestamp()', 'Column sqitch.tags.committed_at should have the correct default.');

  SELECT col_type_is('sqitch', 'tags', 'committed_at', 'pg_catalog', 'timestamp with time zone', 'Column sqitch.tags.committed_at should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
