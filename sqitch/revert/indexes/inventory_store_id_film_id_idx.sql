-- Revert db_design_intro:indexes/inventory_store_id_film_id_idx from pg

BEGIN;

DROP INDEX rental.inventory_store_id_film_id_idx;

COMMIT;
