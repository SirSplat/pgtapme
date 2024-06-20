BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_domain('rental', 'year', 'Domain rental.year should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT type_owner_is('rental', 'year', 'dbo', 'Type rental.year should have the correct owner.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT domain_type_is('rental', 'year', 'pg_catalog', 'integer', 'Domain rental.year should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
