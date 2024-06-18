BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_view('rental', 'sales_by_film_category', 'View rental.sales_by_film_category should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT view_owner_is('rental', 'sales_by_film_category', 'dbo', 'View rental.sales_by_film_category should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
