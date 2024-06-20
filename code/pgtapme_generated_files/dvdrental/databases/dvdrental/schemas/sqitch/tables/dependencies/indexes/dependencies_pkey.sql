BEGIN;
  SELECT plan(9);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'dependencies', 'Table sqitch.dependencies should exist.');

  SELECT has_column('sqitch', 'dependencies', 'change_id', 'Column sqitch.dependencies.change_id should exist.');

  SELECT has_column('sqitch', 'dependencies', 'dependency', 'Column sqitch.dependencies.dependency should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'dependencies', 'dependencies_pkey', 'dbo', 'Index sqitch.dependencies.dependencies_pkey should have the correct owner.');

  SELECT index_is_primary('sqitch', 'dependencies', 'dependencies_pkey', 'Index sqitch.dependencies.dependencies_pkey should be a primary key index.');

  SELECT index_is_unique('sqitch', 'dependencies', 'dependencies_pkey', 'Index sqitch.dependencies.dependencies_pkey should be a unique index.');

  SELECT index_is_type('sqitch', 'dependencies', 'dependencies_pkey', 'btree', 'Index sqitch.dependencies.dependencies_pkey should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
