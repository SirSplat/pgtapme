-- Revert db_design_intro:views/staff_list from pg

BEGIN;

DROP VIEW rental.staff_list;

COMMIT;
