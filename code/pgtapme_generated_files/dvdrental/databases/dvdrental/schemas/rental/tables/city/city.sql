BEGIN;
  SELECT plan(17);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'city', 'Table rental.city should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'city', 'dbo', 'Table rental.city should have the correct owner.');

  SELECT partitions_are('rental', 'city', ARRAY[]::TEXT[], 'Table rental.city should have the correct partitions.');

  SELECT columns_are('rental', 'city', ARRAY['city_id', 'city', 'country_id', 'last_update']::TEXT[], 'Table rental.city should have the correct columns.');

  SELECT indexes_are('rental', 'city', ARRAY['city_pk', 'city_country_id_idx']::TEXT[], 'Table rental.city should have the correct indexes.');

  SELECT triggers_are('rental', 'city', ARRAY['last_updated_trg']::TEXT[], 'Table rental.city should have the correct triggers.');

  SELECT rules_are('rental', 'city', ARRAY[]::TEXT[], 'Table rental.city should have the correct rules.');

  SELECT has_pk('rental', 'city', 'Table rental.city should have a primary key.');

  SELECT col_is_pk('rental', 'city', ARRAY['city_id']::TEXT[], 'Table rental.city should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'city', ARRAY['city', 'last_update']::TEXT[], 'Table rental.city should have the correct primary key columns.');

  SELECT has_fk('rental', 'city', 'Table rental.city should have a foreign key.');

  SELECT col_is_fk('rental', 'city', ARRAY['country_id']::TEXT[], 'Table rental.city should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'city', ARRAY['city_id', 'city']::TEXT[], 'Table rental.city should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'city', 'Table rental.city should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'city', 'Table rental.city should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
