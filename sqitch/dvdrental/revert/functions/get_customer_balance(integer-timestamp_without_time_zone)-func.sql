-- Revert db_design_intro:functions/get_customer_balance(integer-timestamp_without_time_zone)-func from pg

BEGIN;

DROP FUNCTION rental.get_customer_balance(integer, timestamp without time zone);

COMMIT;
