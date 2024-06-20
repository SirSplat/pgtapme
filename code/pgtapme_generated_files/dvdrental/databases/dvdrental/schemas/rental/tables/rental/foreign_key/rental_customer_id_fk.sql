BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'customer_id', 'Column rental.rental.customer_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'customer_id', 'Column rental.customer.customer_id should exist.');

  SELECT fk_ok('rental', 'rental', ARRAY['customer_id']::TEXT[], 'rental', 'customer', ARRAY['customer_id']::TEXT[], 'Foreign key rental.rental.rental_customer_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
