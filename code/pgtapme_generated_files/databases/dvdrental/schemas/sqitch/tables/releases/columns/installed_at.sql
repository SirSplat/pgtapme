BEGIN;
  SELECT plan(9);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'releases', 'Table sqitch.releases should exist.');

  SELECT has_column('sqitch', 'releases', 'installed_at', 'Column sqitch.releases.installed_at should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamptz', 'Data type pg_catalog.timestamptz should exist.');

  SELECT col_not_null('sqitch', 'releases', 'installed_at', 'Column sqitch.releases.installed_at should be NOT NULL.');

  SELECT col_has_default('sqitch', 'releases', 'installed_at', 'Column sqitch.releases.installed_at should have DEFAULT.');

  SELECT col_default_is('sqitch', 'releases', 'installed_at', 'clock_timestamp()', 'Column sqitch.releases.installed_at should have the correct default.');

  SELECT col_type_is('sqitch', 'releases', 'installed_at', 'pg_catalog', 'timestamp with time zone', 'Column sqitch.releases.installed_at should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
