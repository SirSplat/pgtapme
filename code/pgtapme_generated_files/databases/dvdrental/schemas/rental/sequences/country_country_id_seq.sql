BEGIN;
  SELECT plan(4);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_sequence('rental', 'country_country_id_seq', 'Sequence rental.country_country_id_seq should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT sequence_owner_is('rental', 'country_country_id_seq', 'dbo', 'Sequence rental.country_country_id_seq should have the correct owner.');

  SELECT * FROM finish();
ROLLBACK;
