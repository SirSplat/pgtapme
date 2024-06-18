-- Revert db_design_intro:functions/inventory_held_by_customer(integer)-func from pg

BEGIN;

DROP FUNCTION rental.inventory_held_by_customer(integer);

COMMIT;
