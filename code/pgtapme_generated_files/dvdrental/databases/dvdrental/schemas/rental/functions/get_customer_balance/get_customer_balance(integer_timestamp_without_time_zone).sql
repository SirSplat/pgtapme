BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'dbo', 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should have the correct owner.');

  SELECT function_lang_is('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'plpgsql', 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should have the correct language.');

  SELECT function_returns('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'numeric', 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should have the correct return type.');

  SELECT isnt_definer('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should have the correct security invoker.');

  SELECT isnt_strict('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should not be strict.');

  SELECT is_normal_function('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should be a normal function.');

  SELECT isnt_aggregate('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should not be an aggregate function.');

  SELECT isnt_window('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should not be a window function.');

  SELECT isnt_procedure('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should not be a procedure.');

  SELECT volatility_is('rental', 'get_customer_balance', ARRAY['integer', 'timestamp without time zone']::TEXT[], 'v', 'Function rental.get_customer_balance(integer_timestamp_without_time_zone) should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
