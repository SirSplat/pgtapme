BEGIN;
  SELECT plan(8);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_column('sqitch', 'changes', 'change_id', 'Column sqitch.changes.change_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'changes', 'changes_pkey', 'dbo', 'Index sqitch.changes.changes_pkey should have the correct owner.');

  SELECT index_is_primary('sqitch', 'changes', 'changes_pkey', 'Index sqitch.changes.changes_pkey should be a primary key index.');

  SELECT index_is_unique('sqitch', 'changes', 'changes_pkey', 'Index sqitch.changes.changes_pkey should be a unique index.');

  SELECT index_is_type('sqitch', 'changes', 'changes_pkey', 'btree', 'Index sqitch.changes.changes_pkey should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
