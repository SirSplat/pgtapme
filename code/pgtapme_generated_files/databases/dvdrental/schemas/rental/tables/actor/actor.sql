BEGIN;
  SELECT plan(16);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'actor', 'Table rental.actor should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'actor', 'dbo', 'Table rental.actor should have the correct owner.');

  SELECT partitions_are('rental', 'actor', ARRAY[]::TEXT[], 'Table rental.actor should have the correct partitions.');

  SELECT columns_are('rental', 'actor', ARRAY['actor_id', 'first_name', 'last_name', 'last_update']::TEXT[], 'Table rental.actor should have the correct columns.');

  SELECT indexes_are('rental', 'actor', ARRAY['actor_pk', 'actor_last_name_idx']::TEXT[], 'Table rental.actor should have the correct indexes.');

  SELECT triggers_are('rental', 'actor', ARRAY['last_updated_trg']::TEXT[], 'Table rental.actor should have the correct triggers.');

  SELECT rules_are('rental', 'actor', ARRAY[]::TEXT[], 'Table rental.actor should have the correct rules.');

  SELECT has_pk('rental', 'actor', 'Table rental.actor should have a primary key.');

  SELECT col_is_pk('rental', 'actor', ARRAY['actor_id']::TEXT[], 'Table rental.actor should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'actor', ARRAY['first_name', 'last_update']::TEXT[], 'Table rental.actor should have the correct primary key columns.');

  SELECT hasnt_fk('rental', 'actor', 'Table rental.actor should not have a foreign key.');

  SELECT col_isnt_fk('rental', 'actor', ARRAY['actor_id', 'last_name', 'first_name', 'last_update']::TEXT[], 'Table rental.actor should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'actor', 'Table rental.actor should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'actor', 'Table rental.actor should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
