BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'inventory_id', 'Column rental.rental.inventory_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'inventory', 'Table rental.inventory should exist.');

  SELECT has_column('rental', 'inventory', 'inventory_id', 'Column rental.inventory.inventory_id should exist.');

  SELECT fk_ok('rental', 'rental', ARRAY['inventory_id']::TEXT[], 'rental', 'inventory', ARRAY['inventory_id']::TEXT[], 'Foreign key rental.rental.rental_inventory_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
