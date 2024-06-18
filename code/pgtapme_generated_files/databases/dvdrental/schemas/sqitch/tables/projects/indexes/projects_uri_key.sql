BEGIN;
  SELECT plan(7);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'projects', 'Table sqitch.projects should exist.');

  SELECT has_column('sqitch', 'projects', 'uri', 'Column sqitch.projects.uri should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'projects', 'projects_uri_key', 'dbo', 'Index sqitch.projects.projects_uri_key should have the correct owner.');

  SELECT index_is_unique('sqitch', 'projects', 'projects_uri_key', 'Index sqitch.projects.projects_uri_key should be a unique index.');

  SELECT index_is_type('sqitch', 'projects', 'projects_uri_key', 'btree', 'Index sqitch.projects.projects_uri_key should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
