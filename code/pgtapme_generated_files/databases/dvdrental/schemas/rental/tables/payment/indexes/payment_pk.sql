BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'payment_id', 'Column rental.payment.payment_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'payment', 'payment_pk', 'dbo', 'Index rental.payment.payment_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'payment', 'payment_pk', 'Index rental.payment.payment_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'payment', 'payment_pk', 'Index rental.payment.payment_pk should be a unique index.');

  SELECT index_is_type('rental', 'payment', 'payment_pk', 'btree', 'Index rental.payment.payment_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
