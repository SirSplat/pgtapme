-- Revert db_design_intro:functions/inventory_in_stock(integer)-func from pg

BEGIN;

DROP FUNCTION rental.inventory_in_stock(integer);

COMMIT;
