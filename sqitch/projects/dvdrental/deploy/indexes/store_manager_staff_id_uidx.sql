-- Deploy db_design_intro:indexes/store_manager_staff_id_uidx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE UNIQUE INDEX store_manager_staff_id_uidx ON rental.store USING btree (manager_staff_id);

COMMIT;
