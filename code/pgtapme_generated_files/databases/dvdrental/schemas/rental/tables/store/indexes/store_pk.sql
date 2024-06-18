BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'store', 'Table rental.store should exist.');

  SELECT has_column('rental', 'store', 'store_id', 'Column rental.store.store_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'store', 'store_pk', 'dbo', 'Index rental.store.store_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'store', 'store_pk', 'Index rental.store.store_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'store', 'store_pk', 'Index rental.store.store_pk should be a unique index.');

  SELECT index_is_type('rental', 'store', 'store_pk', 'btree', 'Index rental.store.store_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
