-- Revert db_design_intro:indexes/rental_inventory_id_idx from pg

BEGIN;

DROP INDEX rental.rental_inventory_id_idx;

COMMIT;
