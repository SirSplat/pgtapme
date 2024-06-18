-- Revert db_design_intro:sequences/store_store_id_seq from pg

BEGIN;

DROP SEQUENCE rental.store_store_id_seq;

COMMIT;
