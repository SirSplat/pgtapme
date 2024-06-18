BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', 'group_concat', ARRAY['text']::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', 'group_concat', ARRAY['text']::TEXT[], 'dbo', 'Function rental.group_concat(text) should have the correct owner.');

  SELECT function_lang_is('rental', 'group_concat', ARRAY['text']::TEXT[], 'internal', 'Function rental.group_concat(text) should have the correct language.');

  SELECT function_returns('rental', 'group_concat', ARRAY['text']::TEXT[], 'text', 'Function rental.group_concat(text) should have the correct return type.');

  SELECT isnt_definer('rental', 'group_concat', ARRAY['text']::TEXT[], 'Function rental.group_concat(text) should have the correct security invoker.');

  SELECT isnt_strict('rental', 'group_concat', ARRAY['text']::TEXT[], 'Function rental.group_concat(text) should not be strict.');

  SELECT isnt_normal_function('rental', 'group_concat', ARRAY['text']::TEXT[], 'Function rental.group_concat(text) should not be a normal function.');

  SELECT is_aggregate('rental', 'group_concat', ARRAY['text']::TEXT[], 'Function rental.group_concat(text) should be an aggregate function.');

  SELECT isnt_window('rental', 'group_concat', ARRAY['text']::TEXT[], 'Function rental.group_concat(text) should not be a window function.');

  SELECT isnt_procedure('rental', 'group_concat', ARRAY['text']::TEXT[], 'Function rental.group_concat(text) should not be a procedure.');

  SELECT volatility_is('rental', 'group_concat', ARRAY['text']::TEXT[], 'i', 'Function rental.group_concat(text) should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
