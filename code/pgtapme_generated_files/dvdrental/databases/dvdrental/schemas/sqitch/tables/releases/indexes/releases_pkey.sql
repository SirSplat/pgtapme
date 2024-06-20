BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'releases', 'Table sqitch.releases should exist.');

  SELECT has_column('sqitch', 'releases', 'version', 'Column sqitch.releases.version should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'releases', 'releases_pkey', 'dbo', 'Index sqitch.releases.releases_pkey should have the correct owner.');

  SELECT index_is_primary('sqitch', 'releases', 'releases_pkey', 'Index sqitch.releases.releases_pkey should be a primary key index.');

  SELECT index_is_unique('sqitch', 'releases', 'releases_pkey', 'Index sqitch.releases.releases_pkey should be a unique index.');

  SELECT index_is_type('sqitch', 'releases', 'releases_pkey', 'btree', 'Index sqitch.releases.releases_pkey should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
