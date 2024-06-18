-- Revert db_design_intro:sequences/staff_staff_id_seq from pg

BEGIN;

DROP SEQUENCE rental.staff_staff_id_seq;

COMMIT;
