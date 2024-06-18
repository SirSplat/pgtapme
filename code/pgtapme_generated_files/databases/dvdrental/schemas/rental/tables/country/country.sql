BEGIN;
  SELECT plan(16);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'country', 'Table rental.country should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'country', 'dbo', 'Table rental.country should have the correct owner.');

  SELECT partitions_are('rental', 'country', ARRAY[]::TEXT[], 'Table rental.country should have the correct partitions.');

  SELECT columns_are('rental', 'country', ARRAY['country_id', 'country', 'last_update']::TEXT[], 'Table rental.country should have the correct columns.');

  SELECT indexes_are('rental', 'country', ARRAY['country_pk']::TEXT[], 'Table rental.country should have the correct indexes.');

  SELECT triggers_are('rental', 'country', ARRAY['last_updated_trg']::TEXT[], 'Table rental.country should have the correct triggers.');

  SELECT rules_are('rental', 'country', ARRAY[]::TEXT[], 'Table rental.country should have the correct rules.');

  SELECT has_pk('rental', 'country', 'Table rental.country should have a primary key.');

  SELECT col_is_pk('rental', 'country', ARRAY['country_id']::TEXT[], 'Table rental.country should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'country', ARRAY['country', 'last_update']::TEXT[], 'Table rental.country should have the correct primary key columns.');

  SELECT hasnt_fk('rental', 'country', 'Table rental.country should not have a foreign key.');

  SELECT col_isnt_fk('rental', 'country', ARRAY['country', 'last_update', 'country_id']::TEXT[], 'Table rental.country should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'country', 'Table rental.country should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'country', 'Table rental.country should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
