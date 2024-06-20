BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'rental_date', 'Column rental.rental.rental_date should exist.');

  SELECT has_column('rental', 'rental', 'inventory_id', 'Column rental.rental.inventory_id should exist.');

  SELECT has_column('rental', 'rental', 'customer_id', 'Column rental.rental.customer_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'rental', 'rental_rental_date_inventory_id_customer_id_uidx', 'dbo', 'Index rental.rental.rental_rental_date_inventory_id_customer_id_uidx should have the correct owner.');

  SELECT index_is_unique('rental', 'rental', 'rental_rental_date_inventory_id_customer_id_uidx', 'Index rental.rental.rental_rental_date_inventory_id_customer_id_uidx should be a unique index.');

  SELECT index_is_type('rental', 'rental', 'rental_rental_date_inventory_id_customer_id_uidx', 'btree', 'Index rental.rental.rental_rental_date_inventory_id_customer_id_uidx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
