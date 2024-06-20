BEGIN;
  SELECT plan(17);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'address', 'Table rental.address should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'address', 'dbo', 'Table rental.address should have the correct owner.');

  SELECT partitions_are('rental', 'address', ARRAY[]::TEXT[], 'Table rental.address should have the correct partitions.');

  SELECT columns_are('rental', 'address', ARRAY['address_id', 'address', 'address2', 'district', 'city_id', 'postal_code', 'phone', 'last_update']::TEXT[], 'Table rental.address should have the correct columns.');

  SELECT indexes_are('rental', 'address', ARRAY['address_pk', 'address_city_id_idx']::TEXT[], 'Table rental.address should have the correct indexes.');

  SELECT triggers_are('rental', 'address', ARRAY['last_updated_trg']::TEXT[], 'Table rental.address should have the correct triggers.');

  SELECT rules_are('rental', 'address', ARRAY[]::TEXT[], 'Table rental.address should have the correct rules.');

  SELECT has_pk('rental', 'address', 'Table rental.address should have a primary key.');

  SELECT col_is_pk('rental', 'address', ARRAY['address_id']::TEXT[], 'Table rental.address should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'address', ARRAY['address', 'district', 'postal_code', 'address2', 'last_update', 'phone']::TEXT[], 'Table rental.address should have the correct primary key columns.');

  SELECT has_fk('rental', 'address', 'Table rental.address should have a foreign key.');

  SELECT col_is_fk('rental', 'address', ARRAY['city_id']::TEXT[], 'Table rental.address should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'address', ARRAY['address', 'address_id', 'district', 'postal_code', 'address2', 'last_update']::TEXT[], 'Table rental.address should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'address', 'Table rental.address should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'address', 'Table rental.address should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
