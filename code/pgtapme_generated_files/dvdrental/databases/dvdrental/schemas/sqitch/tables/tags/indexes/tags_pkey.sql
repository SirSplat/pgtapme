BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'tag_id', 'Column sqitch.tags.tag_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'tags', 'tags_pkey', 'dbo', 'Index sqitch.tags.tags_pkey should have the correct owner.');

  SELECT index_is_primary('sqitch', 'tags', 'tags_pkey', 'Index sqitch.tags.tags_pkey should be a primary key index.');

  SELECT index_is_unique('sqitch', 'tags', 'tags_pkey', 'Index sqitch.tags.tags_pkey should be a unique index.');

  SELECT index_is_type('sqitch', 'tags', 'tags_pkey', 'btree', 'Index sqitch.tags.tags_pkey should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
