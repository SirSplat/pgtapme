BEGIN;
  SELECT plan(5);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT type_owner_is('rental', 'mpaa_rating', 'dbo', 'Type rental.mpaa_rating should have the correct owner.');

  SELECT has_enum('rental', 'mpaa_rating', 'ENUM rental.mpaa_rating should exist.');

  SELECT enum_has_labels('rental', 'mpaa_rating', ARRAY['G', 'PG', 'PG-13', 'R', 'NC-17']::TEXT[], 'ENUM rental.mpaa_rating should have the correct labels.');

  SELECT * FROM finish();
ROLLBACK;
