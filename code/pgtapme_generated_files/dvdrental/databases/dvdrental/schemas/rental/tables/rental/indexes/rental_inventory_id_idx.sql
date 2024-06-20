BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'inventory_id', 'Column rental.rental.inventory_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'rental', 'rental_inventory_id_idx', 'dbo', 'Index rental.rental.rental_inventory_id_idx should have the correct owner.');

  SELECT index_is_type('rental', 'rental', 'rental_inventory_id_idx', 'btree', 'Index rental.rental.rental_inventory_id_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
