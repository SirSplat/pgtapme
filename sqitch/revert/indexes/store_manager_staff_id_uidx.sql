-- Revert db_design_intro:indexes/store_manager_staff_id_uidx from pg

BEGIN;

DROP INDEX rental.store_manager_staff_id_uidx;

COMMIT;
