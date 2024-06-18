BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_view('rental', 'film_list', 'View rental.film_list should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT view_owner_is('rental', 'film_list', 'dbo', 'View rental.film_list should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
