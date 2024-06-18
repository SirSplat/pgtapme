BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'dbo', 'Function rental.rewards_report(integer_numeric) should have the correct owner.');

  SELECT function_lang_is('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'plpgsql', 'Function rental.rewards_report(integer_numeric) should have the correct language.');

  SELECT function_returns('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'setof customer', 'Function rental.rewards_report(integer_numeric) should have the correct return type.');

  SELECT is_definer('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'Function rental.rewards_report(integer_numeric) should have the correct security definer.');

  SELECT isnt_strict('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'Function rental.rewards_report(integer_numeric) should not be strict.');

  SELECT is_normal_function('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'Function rental.rewards_report(integer_numeric) should be a normal function.');

  SELECT isnt_aggregate('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'Function rental.rewards_report(integer_numeric) should not be an aggregate function.');

  SELECT isnt_window('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'Function rental.rewards_report(integer_numeric) should not be a window function.');

  SELECT isnt_procedure('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'Function rental.rewards_report(integer_numeric) should not be a procedure.');

  SELECT volatility_is('rental', 'rewards_report', ARRAY['integer', 'numeric']::TEXT[], 'v', 'Function rental.rewards_report(integer_numeric) should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
