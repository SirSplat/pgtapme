BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'store', 'Table rental.store should exist.');

  SELECT has_column('rental', 'store', 'manager_staff_id', 'Column rental.store.manager_staff_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'store', 'store_manager_staff_id_uidx', 'dbo', 'Index rental.store.store_manager_staff_id_uidx should have the correct owner.');

  SELECT index_is_unique('rental', 'store', 'store_manager_staff_id_uidx', 'Index rental.store.store_manager_staff_id_uidx should be a unique index.');

  SELECT index_is_type('rental', 'store', 'store_manager_staff_id_uidx', 'btree', 'Index rental.store.store_manager_staff_id_uidx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
