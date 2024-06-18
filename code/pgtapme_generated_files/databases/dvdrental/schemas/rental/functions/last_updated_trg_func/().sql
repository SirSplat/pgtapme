BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'dbo', 'Function rental.() should have the correct owner.');

  SELECT function_lang_is('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'plpgsql', 'Function rental.() should have the correct language.');

  SELECT function_returns('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'trigger', 'Function rental.() should have the correct return type.');

  SELECT isnt_definer('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'Function rental.() should have the correct security invoker.');

  SELECT isnt_strict('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'Function rental.() should not be strict.');

  SELECT is_normal_function('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'Function rental.() should be a normal function.');

  SELECT isnt_aggregate('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'Function rental.() should not be an aggregate function.');

  SELECT isnt_window('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'Function rental.() should not be a window function.');

  SELECT isnt_procedure('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'Function rental.() should not be a procedure.');

  SELECT volatility_is('rental', 'last_updated_trg_func', ARRAY[]::TEXT[], 'v', 'Function rental.() should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
