BEGIN;
  SELECT plan(17);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'staff', 'Table rental.staff should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'staff', 'dbo', 'Table rental.staff should have the correct owner.');

  SELECT partitions_are('rental', 'staff', ARRAY[]::TEXT[], 'Table rental.staff should have the correct partitions.');

  SELECT columns_are('rental', 'staff', ARRAY['staff_id', 'first_name', 'last_name', 'address_id', 'email', 'store_id', 'active', 'username', 'password', 'last_update', 'picture']::TEXT[], 'Table rental.staff should have the correct columns.');

  SELECT indexes_are('rental', 'staff', ARRAY['staff_pk']::TEXT[], 'Table rental.staff should have the correct indexes.');

  SELECT triggers_are('rental', 'staff', ARRAY['last_updated_trg']::TEXT[], 'Table rental.staff should have the correct triggers.');

  SELECT rules_are('rental', 'staff', ARRAY[]::TEXT[], 'Table rental.staff should have the correct rules.');

  SELECT has_pk('rental', 'staff', 'Table rental.staff should have a primary key.');

  SELECT col_is_pk('rental', 'staff', ARRAY['staff_id']::TEXT[], 'Table rental.staff should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'staff', ARRAY['active', 'picture', 'first_name', 'email', 'password', 'username', 'last_update']::TEXT[], 'Table rental.staff should have the correct primary key columns.');

  SELECT has_fk('rental', 'staff', 'Table rental.staff should have a foreign key.');

  SELECT col_is_fk('rental', 'staff', ARRAY['address_id']::TEXT[], 'Table rental.staff should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'staff', ARRAY['active', 'picture', 'staff_id', 'first_name', 'email', 'password', 'username', 'store_id']::TEXT[], 'Table rental.staff should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'staff', 'Table rental.staff should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'staff', 'Table rental.staff should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
