BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'inventory', 'Table rental.inventory should exist.');

  SELECT has_column('rental', 'inventory', 'inventory_id', 'Column rental.inventory.inventory_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'inventory', 'inventory_pk', 'dbo', 'Index rental.inventory.inventory_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'inventory', 'inventory_pk', 'Index rental.inventory.inventory_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'inventory', 'inventory_pk', 'Index rental.inventory.inventory_pk should be a unique index.');

  SELECT index_is_type('rental', 'inventory', 'inventory_pk', 'btree', 'Index rental.inventory.inventory_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
