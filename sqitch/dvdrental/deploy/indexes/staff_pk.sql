-- Deploy db_design_intro:indexes/staff_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (staff_id);

COMMIT;
