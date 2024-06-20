BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'city_id', 'Column rental.address.city_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'address', 'address_city_id_idx', 'dbo', 'Index rental.address.address_city_id_idx should have the correct owner.');

  SELECT index_is_type('rental', 'address', 'address_city_id_idx', 'btree', 'Index rental.address.address_city_id_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
