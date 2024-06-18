BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'city_id', 'Column rental.city.city_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'city', 'city_pk', 'dbo', 'Index rental.city.city_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'city', 'city_pk', 'Index rental.city.city_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'city', 'city_pk', 'Index rental.city.city_pk should be a unique index.');

  SELECT index_is_type('rental', 'city', 'city_pk', 'btree', 'Index rental.city.city_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
