BEGIN;
  SELECT plan(9);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'events', 'Table sqitch.events should exist.');

  SELECT has_column('sqitch', 'events', 'change_id', 'Column sqitch.events.change_id should exist.');

  SELECT has_column('sqitch', 'events', 'committed_at', 'Column sqitch.events.committed_at should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('sqitch', 'events', 'events_pkey', 'dbo', 'Index sqitch.events.events_pkey should have the correct owner.');

  SELECT index_is_primary('sqitch', 'events', 'events_pkey', 'Index sqitch.events.events_pkey should be a primary key index.');

  SELECT index_is_unique('sqitch', 'events', 'events_pkey', 'Index sqitch.events.events_pkey should be a unique index.');

  SELECT index_is_type('sqitch', 'events', 'events_pkey', 'btree', 'Index sqitch.events.events_pkey should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
