BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'dbo', 'Function rental.last_day(timestamp_without_time_zone) should have the correct owner.');

  SELECT function_lang_is('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'sql', 'Function rental.last_day(timestamp_without_time_zone) should have the correct language.');

  SELECT function_returns('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'date', 'Function rental.last_day(timestamp_without_time_zone) should have the correct return type.');

  SELECT isnt_definer('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'Function rental.last_day(timestamp_without_time_zone) should have the correct security invoker.');

  SELECT is_strict('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'Function rental.last_day(timestamp_without_time_zone) should be strict.');

  SELECT is_normal_function('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'Function rental.last_day(timestamp_without_time_zone) should be a normal function.');

  SELECT isnt_aggregate('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'Function rental.last_day(timestamp_without_time_zone) should not be an aggregate function.');

  SELECT isnt_window('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'Function rental.last_day(timestamp_without_time_zone) should not be a window function.');

  SELECT isnt_procedure('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'Function rental.last_day(timestamp_without_time_zone) should not be a procedure.');

  SELECT volatility_is('rental', 'last_day', ARRAY['timestamp without time zone']::TEXT[], 'i', 'Function rental.last_day(timestamp_without_time_zone) should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
