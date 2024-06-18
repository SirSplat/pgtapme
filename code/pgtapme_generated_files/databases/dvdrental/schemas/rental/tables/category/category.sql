BEGIN;
  SELECT plan(16);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'category', 'Table rental.category should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'category', 'dbo', 'Table rental.category should have the correct owner.');

  SELECT partitions_are('rental', 'category', ARRAY[]::TEXT[], 'Table rental.category should have the correct partitions.');

  SELECT columns_are('rental', 'category', ARRAY['category_id', 'name', 'last_update']::TEXT[], 'Table rental.category should have the correct columns.');

  SELECT indexes_are('rental', 'category', ARRAY['category_pk']::TEXT[], 'Table rental.category should have the correct indexes.');

  SELECT triggers_are('rental', 'category', ARRAY['last_updated_trg']::TEXT[], 'Table rental.category should have the correct triggers.');

  SELECT rules_are('rental', 'category', ARRAY[]::TEXT[], 'Table rental.category should have the correct rules.');

  SELECT has_pk('rental', 'category', 'Table rental.category should have a primary key.');

  SELECT col_is_pk('rental', 'category', ARRAY['category_id']::TEXT[], 'Table rental.category should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'category', ARRAY['last_update']::TEXT[], 'Table rental.category should have the correct primary key columns.');

  SELECT hasnt_fk('rental', 'category', 'Table rental.category should not have a foreign key.');

  SELECT col_isnt_fk('rental', 'category', ARRAY['category_id', 'name', 'last_update']::TEXT[], 'Table rental.category should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'category', 'Table rental.category should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'category', 'Table rental.category should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
