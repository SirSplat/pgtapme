BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'rental_id', 'Column rental.payment.rental_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'rental_id', 'Column rental.rental.rental_id should exist.');

  SELECT fk_ok('rental', 'payment', ARRAY['rental_id']::TEXT[], 'rental', 'rental', ARRAY['rental_id']::TEXT[], 'Foreign key rental.payment.payment_rental_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
