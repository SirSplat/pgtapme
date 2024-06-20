BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'staff_id', 'Column rental.payment.staff_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'staff', 'Table rental.staff should exist.');

  SELECT has_column('rental', 'staff', 'staff_id', 'Column rental.staff.staff_id should exist.');

  SELECT fk_ok('rental', 'payment', ARRAY['staff_id']::TEXT[], 'rental', 'staff', ARRAY['staff_id']::TEXT[], 'Foreign key rental.payment.payment_staff_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
