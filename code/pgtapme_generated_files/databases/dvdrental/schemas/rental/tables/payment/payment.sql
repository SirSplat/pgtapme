BEGIN;
  SELECT plan(19);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'payment', 'dbo', 'Table rental.payment should have the correct owner.');

  SELECT partitions_are('rental', 'payment', ARRAY[]::TEXT[], 'Table rental.payment should have the correct partitions.');

  SELECT columns_are('rental', 'payment', ARRAY['payment_id', 'customer_id', 'staff_id', 'rental_id', 'amount', 'payment_date']::TEXT[], 'Table rental.payment should have the correct columns.');

  SELECT indexes_are('rental', 'payment', ARRAY['payment_pk', 'payment_customer_id_idx', 'payment_rental_id_idx', 'payment_staff_id_idx']::TEXT[], 'Table rental.payment should have the correct indexes.');

  SELECT triggers_are('rental', 'payment', ARRAY[]::TEXT[], 'Table rental.payment should have the correct triggers.');

  SELECT rules_are('rental', 'payment', ARRAY[]::TEXT[], 'Table rental.payment should have the correct rules.');

  SELECT has_pk('rental', 'payment', 'Table rental.payment should have a primary key.');

  SELECT col_is_pk('rental', 'payment', ARRAY['payment_id']::TEXT[], 'Table rental.payment should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'payment', ARRAY['payment_date', 'amount']::TEXT[], 'Table rental.payment should have the correct primary key columns.');

  SELECT has_fk('rental', 'payment', 'Table rental.payment should have a foreign key.');

  SELECT col_is_fk('rental', 'payment', ARRAY['customer_id']::TEXT[], 'Table rental.payment should have the correct foreign key columns.');

  SELECT col_is_fk('rental', 'payment', ARRAY['rental_id']::TEXT[], 'Table rental.payment should have the correct foreign key columns.');

  SELECT col_is_fk('rental', 'payment', ARRAY['staff_id']::TEXT[], 'Table rental.payment should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'payment', ARRAY['payment_date', 'payment_id', 'amount']::TEXT[], 'Table rental.payment should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'payment', 'Table rental.payment should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'payment', 'Table rental.payment should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
