BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'rental_id', 'Column rental.payment.rental_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'payment', 'payment_rental_id_idx', 'dbo', 'Index rental.payment.payment_rental_id_idx should have the correct owner.');

  SELECT index_is_type('rental', 'payment', 'payment_rental_id_idx', 'btree', 'Index rental.payment.payment_rental_id_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
