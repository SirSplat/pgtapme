-- Revert db_design_intro:indexes/staff_pk from pg

BEGIN;

ALTER TABLE ONLY rental.staff
    DROP CONSTRAINT staff_pk;

COMMIT;
