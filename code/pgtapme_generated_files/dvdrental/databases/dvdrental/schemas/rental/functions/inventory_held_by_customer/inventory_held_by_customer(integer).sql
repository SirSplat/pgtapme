BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'dbo', 'Function rental.inventory_held_by_customer(integer) should have the correct owner.');

  SELECT function_lang_is('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'plpgsql', 'Function rental.inventory_held_by_customer(integer) should have the correct language.');

  SELECT function_returns('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'integer', 'Function rental.inventory_held_by_customer(integer) should have the correct return type.');

  SELECT isnt_definer('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'Function rental.inventory_held_by_customer(integer) should have the correct security invoker.');

  SELECT isnt_strict('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'Function rental.inventory_held_by_customer(integer) should not be strict.');

  SELECT is_normal_function('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'Function rental.inventory_held_by_customer(integer) should be a normal function.');

  SELECT isnt_aggregate('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'Function rental.inventory_held_by_customer(integer) should not be an aggregate function.');

  SELECT isnt_window('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'Function rental.inventory_held_by_customer(integer) should not be a window function.');

  SELECT isnt_procedure('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'Function rental.inventory_held_by_customer(integer) should not be a procedure.');

  SELECT volatility_is('rental', 'inventory_held_by_customer', ARRAY['integer']::TEXT[], 'v', 'Function rental.inventory_held_by_customer(integer) should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
