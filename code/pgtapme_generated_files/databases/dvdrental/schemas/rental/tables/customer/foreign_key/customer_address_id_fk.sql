BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'address_id', 'Column rental.customer.address_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'address_id', 'Column rental.address.address_id should exist.');

  SELECT fk_ok('rental', 'customer', ARRAY['address_id']::TEXT[], 'rental', 'address', ARRAY['address_id']::TEXT[], 'Foreign key rental.customer.customer_address_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
