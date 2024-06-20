BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'customer_id', 'Column rental.payment.customer_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'customer_id', 'Column rental.customer.customer_id should exist.');

  SELECT fk_ok('rental', 'payment', ARRAY['customer_id']::TEXT[], 'rental', 'customer', ARRAY['customer_id']::TEXT[], 'Foreign key rental.payment.payment_customer_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
