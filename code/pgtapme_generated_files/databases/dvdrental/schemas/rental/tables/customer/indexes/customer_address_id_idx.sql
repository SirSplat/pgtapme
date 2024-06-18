BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'address_id', 'Column rental.customer.address_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'customer', 'customer_address_id_idx', 'dbo', 'Index rental.customer.customer_address_id_idx should have the correct owner.');

  SELECT index_is_type('rental', 'customer', 'customer_address_id_idx', 'btree', 'Index rental.customer.customer_address_id_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
