BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'address_id', 'Column rental.address.address_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'address', 'address_pk', 'dbo', 'Index rental.address.address_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'address', 'address_pk', 'Index rental.address.address_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'address', 'address_pk', 'Index rental.address.address_pk should be a unique index.');

  SELECT index_is_type('rental', 'address', 'address_pk', 'btree', 'Index rental.address.address_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
