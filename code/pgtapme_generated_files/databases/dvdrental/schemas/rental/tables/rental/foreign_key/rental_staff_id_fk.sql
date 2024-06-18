BEGIN;
  SELECT plan(7);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'staff_id', 'Column rental.rental.staff_id should exist.');

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'staff', 'Table rental.staff should exist.');

  SELECT has_column('rental', 'staff', 'staff_id', 'Column rental.staff.staff_id should exist.');

  SELECT fk_ok('rental', 'rental', ARRAY['staff_id']::TEXT[], 'rental', 'staff', ARRAY['staff_id']::TEXT[], 'Foreign key rental.rental.rental_staff_id_fk should exist.');

  SELECT * FROM finish();
ROLLBACK;
