BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'fulltext', 'Column rental.film.fulltext should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'tsvector', 'Data type pg_catalog.tsvector should exist.');

  SELECT col_not_null('rental', 'film', 'fulltext', 'Column rental.film.fulltext should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'film', 'fulltext', 'Column rental.film.fulltext should not have DEFAULT.');

  SELECT col_type_is('rental', 'film', 'fulltext', 'pg_catalog', 'tsvector', 'Column rental.film.fulltext should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
