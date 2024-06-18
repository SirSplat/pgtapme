BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'dbo', 'Function rental._group_concat(text_text) should have the correct owner.');

  SELECT function_lang_is('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'sql', 'Function rental._group_concat(text_text) should have the correct language.');

  SELECT function_returns('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'text', 'Function rental._group_concat(text_text) should have the correct return type.');

  SELECT isnt_definer('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'Function rental._group_concat(text_text) should have the correct security invoker.');

  SELECT isnt_strict('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'Function rental._group_concat(text_text) should not be strict.');

  SELECT is_normal_function('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'Function rental._group_concat(text_text) should be a normal function.');

  SELECT isnt_aggregate('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'Function rental._group_concat(text_text) should not be an aggregate function.');

  SELECT isnt_window('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'Function rental._group_concat(text_text) should not be a window function.');

  SELECT isnt_procedure('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'Function rental._group_concat(text_text) should not be a procedure.');

  SELECT volatility_is('rental', '_group_concat', ARRAY['text', 'text']::TEXT[], 'i', 'Function rental._group_concat(text_text) should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
