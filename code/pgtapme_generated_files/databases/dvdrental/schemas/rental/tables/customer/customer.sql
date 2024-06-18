BEGIN;
  SELECT plan(17);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'customer', 'Table rental.customer should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'customer', 'dbo', 'Table rental.customer should have the correct owner.');

  SELECT partitions_are('rental', 'customer', ARRAY[]::TEXT[], 'Table rental.customer should have the correct partitions.');

  SELECT columns_are('rental', 'customer', ARRAY['customer_id', 'store_id', 'first_name', 'last_name', 'email', 'address_id', 'activebool', 'create_date', 'last_update', 'active']::TEXT[], 'Table rental.customer should have the correct columns.');

  SELECT indexes_are('rental', 'customer', ARRAY['customer_pk', 'customer_address_id_idx', 'customer_store_id_idx', 'customer_last_name_idx']::TEXT[], 'Table rental.customer should have the correct indexes.');

  SELECT triggers_are('rental', 'customer', ARRAY['last_updated_trg']::TEXT[], 'Table rental.customer should have the correct triggers.');

  SELECT rules_are('rental', 'customer', ARRAY[]::TEXT[], 'Table rental.customer should have the correct rules.');

  SELECT has_pk('rental', 'customer', 'Table rental.customer should have a primary key.');

  SELECT col_is_pk('rental', 'customer', ARRAY['customer_id']::TEXT[], 'Table rental.customer should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'customer', ARRAY['create_date', 'active', 'activebool', 'first_name', 'email', 'last_update']::TEXT[], 'Table rental.customer should have the correct primary key columns.');

  SELECT has_fk('rental', 'customer', 'Table rental.customer should have a foreign key.');

  SELECT col_is_fk('rental', 'customer', ARRAY['address_id']::TEXT[], 'Table rental.customer should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'customer', ARRAY['create_date', 'active', 'activebool', 'last_name', 'customer_id', 'first_name', 'email', 'last_update']::TEXT[], 'Table rental.customer should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'customer', 'Table rental.customer should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'customer', 'Table rental.customer should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
