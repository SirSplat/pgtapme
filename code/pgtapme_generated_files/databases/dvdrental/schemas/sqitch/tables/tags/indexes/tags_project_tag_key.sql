BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'project', 'Column sqitch.tags.project should exist.');

  SELECT has_column('sqitch', 'tags', 'tag', 'Column sqitch.tags.tag should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'tags', 'tags_project_tag_key', 'dbo', 'Index sqitch.tags.tags_project_tag_key should have the correct owner.');

  SELECT index_is_unique('sqitch', 'tags', 'tags_project_tag_key', 'Index sqitch.tags.tags_project_tag_key should be a unique index.');

  SELECT index_is_type('sqitch', 'tags', 'tags_project_tag_key', 'btree', 'Index sqitch.tags.tags_project_tag_key should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
