-- Revert db_design_intro:triggers/inventory_last_updated_trg from pg

BEGIN;

DROP TRIGGER last_updated_trg ON rental.inventory;

COMMIT;
