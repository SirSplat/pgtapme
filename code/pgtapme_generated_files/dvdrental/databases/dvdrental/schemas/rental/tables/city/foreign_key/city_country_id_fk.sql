BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_column('rental', 'city', 'country_id', 'Column rental.city.country_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'country', 'Table rental.country should exist.');

  SELECT has_column('rental', 'country', 'country_id', 'Column rental.country.country_id should exist.');

  SELECT fk_ok('rental', 'city', ARRAY['country_id']::TEXT[], 'rental', 'country', ARRAY['country_id']::TEXT[], 'Foreign key rental.city.city_country_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
