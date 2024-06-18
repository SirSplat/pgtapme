BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_view('rental', 'sales_by_store', 'View rental.sales_by_store should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT view_owner_is('rental', 'sales_by_store', 'dbo', 'View rental.sales_by_store should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
