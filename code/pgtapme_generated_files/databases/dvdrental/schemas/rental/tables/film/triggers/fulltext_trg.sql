BEGIN;
  SELECT plan(6);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_function('pg_catalog', 'tsvector_update_trigger', ARRAY[]::TEXT[], 'Function pg_catalog.None should exist.');

  SELECT has_trigger('rental', 'film', 'fulltext_trg', 'Trigger rental.film.fulltext_trg should exist.');

  SELECT trigger_is('rental', 'film', 'fulltext_trg', 'pg_catalog', 'tsvector_update_trigger', 'Trigger rental.film.fulltext_trg should exist.');

  SELECT * FROM finish();
ROLLBACK;
