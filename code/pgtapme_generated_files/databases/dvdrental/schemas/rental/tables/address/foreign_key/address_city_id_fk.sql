BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_column('rental', 'address', 'city_id', 'Column rental.address.city_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'city_id', 'Column rental.city.city_id should exist.');

  SELECT fk_ok('rental', 'address', ARRAY['city_id']::TEXT[], 'rental', 'city', ARRAY['city_id']::TEXT[], 'Foreign key rental.address.address_city_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
