BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_view('rental', 'staff_list', 'View rental.staff_list should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT view_owner_is('rental', 'staff_list', 'dbo', 'View rental.staff_list should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
