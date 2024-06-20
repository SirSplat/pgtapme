BEGIN;
  SELECT plan(18);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'store', 'Table rental.store should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'store', 'dbo', 'Table rental.store should have the correct owner.');

  SELECT partitions_are('rental', 'store', ARRAY[]::TEXT[], 'Table rental.store should have the correct partitions.');

  SELECT columns_are('rental', 'store', ARRAY['store_id', 'manager_staff_id', 'address_id', 'last_update']::TEXT[], 'Table rental.store should have the correct columns.');

  SELECT indexes_are('rental', 'store', ARRAY['store_pk', 'store_manager_staff_id_uidx']::TEXT[], 'Table rental.store should have the correct indexes.');

  SELECT triggers_are('rental', 'store', ARRAY['last_updated_trg']::TEXT[], 'Table rental.store should have the correct triggers.');

  SELECT rules_are('rental', 'store', ARRAY[]::TEXT[], 'Table rental.store should have the correct rules.');

  SELECT has_pk('rental', 'store', 'Table rental.store should have a primary key.');

  SELECT col_is_pk('rental', 'store', ARRAY['store_id']::TEXT[], 'Table rental.store should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'store', ARRAY['last_update']::TEXT[], 'Table rental.store should have the correct primary key columns.');

  SELECT has_fk('rental', 'store', 'Table rental.store should have a foreign key.');

  SELECT col_is_fk('rental', 'store', ARRAY['address_id']::TEXT[], 'Table rental.store should have the correct foreign key columns.');

  SELECT col_is_fk('rental', 'store', ARRAY['manager_staff_id']::TEXT[], 'Table rental.store should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'store', ARRAY[]::TEXT[], 'Table rental.store should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'store', 'Table rental.store should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'store', 'Table rental.store should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
