BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'inventory', 'Table rental.inventory should exist.');

  SELECT has_column('rental', 'inventory', 'store_id', 'Column rental.inventory.store_id should exist.');

  SELECT has_column('rental', 'inventory', 'film_id', 'Column rental.inventory.film_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'inventory', 'inventory_store_id_film_id_idx', 'dbo', 'Index rental.inventory.inventory_store_id_film_id_idx should have the correct owner.');

  SELECT index_is_type('rental', 'inventory', 'inventory_store_id_film_id_idx', 'btree', 'Index rental.inventory.inventory_store_id_film_id_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
