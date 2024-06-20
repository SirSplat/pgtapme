BEGIN;
  SELECT plan(17);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'film', 'dbo', 'Table rental.film should have the correct owner.');

  SELECT partitions_are('rental', 'film', ARRAY[]::TEXT[], 'Table rental.film should have the correct partitions.');

  SELECT columns_are('rental', 'film', ARRAY['film_id', 'title', 'description', 'release_year', 'language_id', 'rental_duration', 'rental_rate', 'length', 'replacement_cost', 'rating', 'last_update', 'special_features', 'fulltext']::TEXT[], 'Table rental.film should have the correct columns.');

  SELECT indexes_are('rental', 'film', ARRAY['film_pk', 'film_fulltext_idx', 'film_language_id_idx', 'film_title_idx']::TEXT[], 'Table rental.film should have the correct indexes.');

  SELECT triggers_are('rental', 'film', ARRAY['fulltext_trg', 'last_updated_trg']::TEXT[], 'Table rental.film should have the correct triggers.');

  SELECT rules_are('rental', 'film', ARRAY[]::TEXT[], 'Table rental.film should have the correct rules.');

  SELECT has_pk('rental', 'film', 'Table rental.film should have a primary key.');

  SELECT col_is_pk('rental', 'film', ARRAY['film_id']::TEXT[], 'Table rental.film should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'film', ARRAY['replacement_cost', 'rental_duration', 'rental_rate', 'length', 'release_year', 'description', 'special_features', 'last_update', 'rating']::TEXT[], 'Table rental.film should have the correct primary key columns.');

  SELECT has_fk('rental', 'film', 'Table rental.film should have a foreign key.');

  SELECT col_is_fk('rental', 'film', ARRAY['language_id']::TEXT[], 'Table rental.film should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'film', ARRAY['replacement_cost', 'title', 'rental_duration', 'film_id', 'rental_rate', 'fulltext', 'length', 'release_year', 'description', 'special_features', 'last_update', 'rating']::TEXT[], 'Table rental.film should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'film', 'Table rental.film should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'film', 'Table rental.film should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
