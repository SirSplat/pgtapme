BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'releases', 'Table sqitch.releases should exist.');

  SELECT has_column('sqitch', 'releases', 'installer_email', 'Column sqitch.releases.installer_email should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'text', 'Data type pg_catalog.text should exist.');

  SELECT col_not_null('sqitch', 'releases', 'installer_email', 'Column sqitch.releases.installer_email should be NOT NULL.');

  SELECT col_hasnt_default('sqitch', 'releases', 'installer_email', 'Column sqitch.releases.installer_email should not have DEFAULT.');

  SELECT col_type_is('sqitch', 'releases', 'installer_email', 'pg_catalog', 'text', 'Column sqitch.releases.installer_email should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
