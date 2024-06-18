BEGIN;
  SELECT plan(17);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'inventory', 'Table rental.inventory should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT table_owner_is('rental', 'inventory', 'dbo', 'Table rental.inventory should have the correct owner.');

  SELECT partitions_are('rental', 'inventory', ARRAY[]::TEXT[], 'Table rental.inventory should have the correct partitions.');

  SELECT columns_are('rental', 'inventory', ARRAY['inventory_id', 'film_id', 'store_id', 'last_update']::TEXT[], 'Table rental.inventory should have the correct columns.');

  SELECT indexes_are('rental', 'inventory', ARRAY['inventory_pk', 'inventory_store_id_film_id_idx']::TEXT[], 'Table rental.inventory should have the correct indexes.');

  SELECT triggers_are('rental', 'inventory', ARRAY['last_updated_trg']::TEXT[], 'Table rental.inventory should have the correct triggers.');

  SELECT rules_are('rental', 'inventory', ARRAY[]::TEXT[], 'Table rental.inventory should have the correct rules.');

  SELECT has_pk('rental', 'inventory', 'Table rental.inventory should have a primary key.');

  SELECT col_is_pk('rental', 'inventory', ARRAY['inventory_id']::TEXT[], 'Table rental.inventory should have the correct primary key columns.');

  SELECT col_isnt_pk('rental', 'inventory', ARRAY['last_update']::TEXT[], 'Table rental.inventory should have the correct primary key columns.');

  SELECT has_fk('rental', 'inventory', 'Table rental.inventory should have a foreign key.');

  SELECT col_is_fk('rental', 'inventory', ARRAY['film_id']::TEXT[], 'Table rental.inventory should have the correct foreign key columns.');

  SELECT col_isnt_fk('rental', 'inventory', ARRAY['last_update']::TEXT[], 'Table rental.inventory should have the correct foreign key columns.');

  SELECT isnt_partitioned('rental', 'inventory', 'Table rental.inventory should not be partitioned.');

  SELECT hasnt_inherited_tables('rental', 'inventory', 'Table rental.inventory should not have child tables.');

  SELECT * FROM finish();
ROLLBACK;
