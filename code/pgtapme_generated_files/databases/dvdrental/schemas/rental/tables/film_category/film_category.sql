BEGIN;
  SELECT plan(18);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film_category', 'Table rental.film_category should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'film_category', 'dbo', 'Table rental.film_category should have the correct owner.');

  SELECT partitions_are('rental', 'film_category', ARRAY[]::TEXT[], 'Table rental.film_category should have the correct partitions.');

  SELECT columns_are('rental', 'film_category', ARRAY['film_id', 'category_id', 'last_update']::TEXT[], 'Table rental.film_category should have the correct columns.');

  SELECT indexes_are('rental', 'film_category', ARRAY['film_category_pk']::TEXT[], 'Table rental.film_category should have the correct indexes.');

  SELECT triggers_are('rental', 'film_category', ARRAY['last_updated_trg']::TEXT[], 'Table rental.film_category should have the correct triggers.');

  SELECT rules_are('rental', 'film_category', ARRAY[]::TEXT[], 'Table rental.film_category should have the correct rules.');

  SELECT has_pk('rental', 'film_category', 'Table rental.film_category should have a primary key.');

  SELECT col_is_pk('rental', 'film_category', ARRAY['film_id', 'category_id']::TEXT[], 'Table rental.film_category should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'film_category', ARRAY['last_update']::TEXT[], 'Table rental.film_category should have the correct primary key columns.');

  SELECT has_fk('rental', 'film_category', 'Table rental.film_category should have a foreign key.');

  SELECT col_is_fk('rental', 'film_category', ARRAY['category_id']::TEXT[], 'Table rental.film_category should have the correct foreign key columns.');

  SELECT col_is_fk('rental', 'film_category', ARRAY['film_id']::TEXT[], 'Table rental.film_category should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'film_category', ARRAY['last_update']::TEXT[], 'Table rental.film_category should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'film_category', 'Table rental.film_category should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'film_category', 'Table rental.film_category should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
