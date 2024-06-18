-- Verify db_design_intro:functions/get_customer_balance(integer-timestamp_without_time_zone)-func on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.get_customer_balance( integer, timestamp without time zone )', 'execute' );

ROLLBACK;
