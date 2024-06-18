BEGIN;
  SELECT plan(13);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_function('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'Function rental.None should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT function_owner_is('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'dbo', 'Function rental.film_in_stock(integer_integer) should have the correct owner.');

  SELECT function_lang_is('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'sql', 'Function rental.film_in_stock(integer_integer) should have the correct language.');

  SELECT function_returns('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'setof integer', 'Function rental.film_in_stock(integer_integer) should have the correct return type.');

  SELECT isnt_definer('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'Function rental.film_in_stock(integer_integer) should have the correct security invoker.');

  SELECT isnt_strict('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'Function rental.film_in_stock(integer_integer) should not be strict.');

  SELECT is_normal_function('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'Function rental.film_in_stock(integer_integer) should be a normal function.');

  SELECT isnt_aggregate('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'Function rental.film_in_stock(integer_integer) should not be an aggregate function.');

  SELECT isnt_window('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'Function rental.film_in_stock(integer_integer) should not be a window function.');

  SELECT isnt_procedure('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'Function rental.film_in_stock(integer_integer) should not be a procedure.');

  SELECT volatility_is('rental', 'film_in_stock', ARRAY['integer', 'integer']::TEXT[], 'v', 'Function rental.film_in_stock(integer_integer) should have the correct volatility.');

  SELECT * FROM finish();
ROLLBACK;
