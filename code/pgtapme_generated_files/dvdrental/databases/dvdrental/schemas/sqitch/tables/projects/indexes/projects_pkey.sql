BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'projects', 'Table sqitch.projects should exist.');

  SELECT has_column('sqitch', 'projects', 'project', 'Column sqitch.projects.project should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'projects', 'projects_pkey', 'dbo', 'Index sqitch.projects.projects_pkey should have the correct owner.');

  SELECT index_is_primary('sqitch', 'projects', 'projects_pkey', 'Index sqitch.projects.projects_pkey should be a primary key index.');

  SELECT index_is_unique('sqitch', 'projects', 'projects_pkey', 'Index sqitch.projects.projects_pkey should be a unique index.');

  SELECT index_is_type('sqitch', 'projects', 'projects_pkey', 'btree', 'Index sqitch.projects.projects_pkey should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
