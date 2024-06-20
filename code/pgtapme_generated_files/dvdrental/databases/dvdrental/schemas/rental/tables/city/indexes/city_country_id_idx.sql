BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'country_id', 'Column rental.city.country_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'city', 'city_country_id_idx', 'dbo', 'Index rental.city.city_country_id_idx should have the correct owner.');

  SELECT index_is_type('rental', 'city', 'city_country_id_idx', 'btree', 'Index rental.city.city_country_id_idx should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
