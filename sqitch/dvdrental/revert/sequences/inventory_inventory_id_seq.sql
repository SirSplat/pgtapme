-- Revert db_design_intro:sequences/inventory_inventory_id_seq from pg

BEGIN;

DROP SEQUENCE rental.inventory_inventory_id_seq;

COMMIT;
