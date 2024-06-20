BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_view('rental', 'nicer_but_slower_film_list', 'View rental.nicer_but_slower_film_list should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT view_owner_is('rental', 'nicer_but_slower_film_list', 'dbo', 'View rental.nicer_but_slower_film_list should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
