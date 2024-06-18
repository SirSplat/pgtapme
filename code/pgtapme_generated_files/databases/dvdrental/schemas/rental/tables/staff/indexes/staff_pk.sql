BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'staff', 'Table rental.staff should exist.');

  SELECT has_column('rental', 'staff', 'staff_id', 'Column rental.staff.staff_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'staff', 'staff_pk', 'dbo', 'Index rental.staff.staff_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'staff', 'staff_pk', 'Index rental.staff.staff_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'staff', 'staff_pk', 'Index rental.staff.staff_pk should be a unique index.');

  SELECT index_is_type('rental', 'staff', 'staff_pk', 'btree', 'Index rental.staff.staff_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
