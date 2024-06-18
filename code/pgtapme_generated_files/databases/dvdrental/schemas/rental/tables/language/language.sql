BEGIN;
  SELECT plan(16);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'language', 'Table rental.language should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'language', 'dbo', 'Table rental.language should have the correct owner.');

  SELECT partitions_are('rental', 'language', ARRAY[]::TEXT[], 'Table rental.language should have the correct partitions.');

  SELECT columns_are('rental', 'language', ARRAY['language_id', 'name', 'last_update']::TEXT[], 'Table rental.language should have the correct columns.');

  SELECT indexes_are('rental', 'language', ARRAY['language_pk']::TEXT[], 'Table rental.language should have the correct indexes.');

  SELECT triggers_are('rental', 'language', ARRAY['last_updated_trg']::TEXT[], 'Table rental.language should have the correct triggers.');

  SELECT rules_are('rental', 'language', ARRAY[]::TEXT[], 'Table rental.language should have the correct rules.');

  SELECT has_pk('rental', 'language', 'Table rental.language should have a primary key.');

  SELECT col_is_pk('rental', 'language', ARRAY['language_id']::TEXT[], 'Table rental.language should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'language', ARRAY['last_update']::TEXT[], 'Table rental.language should have the correct primary key columns.');

  SELECT hasnt_fk('rental', 'language', 'Table rental.language should not have a foreign key.');

  SELECT col_isnt_fk('rental', 'language', ARRAY['name', 'language_id', 'last_update']::TEXT[], 'Table rental.language should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'language', 'Table rental.language should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'language', 'Table rental.language should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
