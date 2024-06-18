BEGIN;
  SELECT plan(19);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'rental', 'dbo', 'Table rental.rental should have the correct owner.');

  SELECT partitions_are('rental', 'rental', ARRAY[]::TEXT[], 'Table rental.rental should have the correct partitions.');

  SELECT columns_are('rental', 'rental', ARRAY['rental_id', 'rental_date', 'inventory_id', 'customer_id', 'return_date', 'staff_id', 'last_update']::TEXT[], 'Table rental.rental should have the correct columns.');

  SELECT indexes_are('rental', 'rental', ARRAY['rental_pk', 'rental_inventory_id_idx', 'rental_rental_date_inventory_id_customer_id_uidx']::TEXT[], 'Table rental.rental should have the correct indexes.');

  SELECT triggers_are('rental', 'rental', ARRAY['last_updated_trg']::TEXT[], 'Table rental.rental should have the correct triggers.');

  SELECT rules_are('rental', 'rental', ARRAY[]::TEXT[], 'Table rental.rental should have the correct rules.');

  SELECT has_pk('rental', 'rental', 'Table rental.rental should have a primary key.');

  SELECT col_is_pk('rental', 'rental', ARRAY['rental_id']::TEXT[], 'Table rental.rental should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'rental', ARRAY['return_date', 'last_update']::TEXT[], 'Table rental.rental should have the correct primary key columns.');

  SELECT has_fk('rental', 'rental', 'Table rental.rental should have a foreign key.');

  SELECT col_is_fk('rental', 'rental', ARRAY['customer_id']::TEXT[], 'Table rental.rental should have the correct foreign key columns.');

  SELECT col_is_fk('rental', 'rental', ARRAY['inventory_id']::TEXT[], 'Table rental.rental should have the correct foreign key columns.');

  SELECT col_is_fk('rental', 'rental', ARRAY['staff_id']::TEXT[], 'Table rental.rental should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'rental', ARRAY['return_date', 'rental_date']::TEXT[], 'Table rental.rental should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'rental', 'Table rental.rental should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'rental', 'Table rental.rental should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
