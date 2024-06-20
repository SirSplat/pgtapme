BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'actor', 'Table rental.actor should exist.');

  SELECT has_column('rental', 'actor', 'last_update', 'Column rental.actor.last_update should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_not_null('rental', 'actor', 'last_update', 'Column rental.actor.last_update should be NOT NULL.');

  SELECT col_has_default('rental', 'actor', 'last_update', 'Column rental.actor.last_update should have DEFAULT.');

  SELECT col_default_is('rental', 'actor', 'last_update', 'now()', 'Column rental.actor.last_update should have the correct default.');

  SELECT col_type_is('rental', 'actor', 'last_update', 'pg_catalog', 'timestamp without time zone', 'Column rental.actor.last_update should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
