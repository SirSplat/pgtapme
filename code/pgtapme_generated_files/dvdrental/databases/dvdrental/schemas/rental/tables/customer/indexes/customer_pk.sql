BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_column('rental', 'customer', 'customer_id', 'Column rental.customer.customer_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'customer', 'customer_pk', 'dbo', 'Index rental.customer.customer_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'customer', 'customer_pk', 'Index rental.customer.customer_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'customer', 'customer_pk', 'Index rental.customer.customer_pk should be a unique index.');

  SELECT index_is_type('rental', 'customer', 'customer_pk', 'btree', 'Index rental.customer.customer_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
